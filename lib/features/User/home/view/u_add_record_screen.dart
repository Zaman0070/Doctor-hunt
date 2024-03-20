import 'dart:io';

import 'package:doctor_app/commons/common_functions/upload_image_to_firebase.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/features/User/home/controller/home_notify.dart';
import 'package:doctor_app/features/User/home/controller/u_add_medical_rec_controller.dart';
import 'package:doctor_app/features/User/home/widgets/u_add_record_detail.dart';
import 'package:doctor_app/features/User/home/widgets/u_bottom_image_selection.dart';
import 'package:doctor_app/features/User/home/widgets/u_upload_bottom_sheet.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/models/med_record/med_record_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserAddRecordScreen extends ConsumerStatefulWidget {
  const UserAddRecordScreen({super.key});

  @override
  ConsumerState<UserAddRecordScreen> createState() =>
      _UserAddRecordScreenState();
}

class _UserAddRecordScreenState extends ConsumerState<UserAddRecordScreen> {
  List<String> recordImage = [
    AppAssets.report,
    AppAssets.pres,
  ];
  List<File> imageFile = [];
  var picker = ImagePicker();

  List<String> titleRecor = [
    'Report',
    'Prescription',
  ];

  String type = 'Report';

  DateTime onCreate = DateTime.now();

  late String date = DateFormat('dd MMM, yyyy').format(onCreate);

  DateTime now = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != now) {
      setState(() {
        date = DateFormat('dd MMM, yyyy').format(picked);
        onCreate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MasterScafold(
        child: Consumer(builder: (context, ref, child) {
          UserModel userModel = ref.watch(authNotifierCtr).userModel!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    AppAssets.backArrowIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
                title: Text(
                  'Add Records',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size18),
                ),
              ),
              UAddImageSection(
                image: imageFile,
                onTap: () {
                  _displayBottomSheet(
                    context: context,
                    camera: () {
                      _getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    gallery: () {
                      _getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              const Spacer(),
              UAddRecordDetailSection(
                onTap: (type) {
                  setState(() {
                    this.type = type;
                  });
                },
                name: ref.watch(userHomeNotifier).tags,
                image: recordImage,
                title: titleRecor,
                edit: () {
                  Navigator.pushNamed(context, AppRoutes.userTageScreen);
                },
                selectDate: () {
                  _selectDate(context);
                },
                date: date,
                upload: ref.watch(userHomeNotifier).tags == 'Choose Doctor'
                    ? () {}
                    : () {
                        insertRecord(userModel);
                      },
                isLoad: ref.read(uAddMedicalRecControllerProvider),
              ),
            ],
          );
        }),
      ),
    );
  }

  List<String> imageUrls = [];

  _getImage(ImageSource source) async {
    var pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile.add(File(pickedFile.path));
      });
      List<String> image = await uploadImages(
          imageFile.map((e) => XFile(e.path)).toList(),
          storageFolderName: FirebaseConstants.ownerCollection);
      setState(() {
        imageUrls.addAll(image);
      });
    }
  }

  Future _displayBottomSheet(
      {required BuildContext context,
      required Function() camera,
      required Function() gallery}) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (_) => UploadBottomSheetSection(
              file: imageFile,
              title: 'Add a record',
              camera: camera,
              gallery: gallery,
            ));
  }

  insertRecord(UserModel model) async {
    List<String> images = imageFile.map((e) => e.path).toList();
    if (ref.read(userHomeNotifier).tags != 'Choose Doctor' ||
        imageFile.isNotEmpty) {
      await ref.read(uAddMedicalRecControllerProvider.notifier).insertMedRecord(
          model: MedRecordModel(
              userName: model.name,
              recCreatedOn: onCreate,
              recType: type,
              doctorUid: ref.read(userHomeNotifier).doctorUid,
              doctorName: ref.read(userHomeNotifier).tags,
              uid: model.uid,
              recImageUrl: imageUrls,
              createdAt: DateTime.now()),
          context: context,
          images: images);
      ref.watch(userHomeNotifier).clear();
      imageUrls.clear();
    } else {
      showSnackBar(
        context,
        'Please select doctor and image',
      );
    }
  }
}

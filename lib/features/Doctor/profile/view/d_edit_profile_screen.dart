import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/available_card.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/Doctor/profile/controller/profile_controller.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/features/Doctor/profile/widgets/edit_profile_image_widget.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:intl/intl.dart';
import '../../../auth/controller/auth_controller.dart';

class DoctorEditProfileScreen extends ConsumerStatefulWidget {
  final DoctorModel doctorModel;
  final UserModel userModel;
  const DoctorEditProfileScreen(
      {Key? key, required this.userModel, required this.doctorModel})
      : super(key: key);

  @override
  ConsumerState<DoctorEditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<DoctorEditProfileScreen> {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final specialityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<dynamic> availableDays = [];
  String? newImagePath;
  String? oldImage;
  TimeOfDay? from;
  TimeOfDay? to;
  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.userModel.name;
    emailController.text = widget.userModel.email;
    oldImage = widget.userModel.profileImage;
    specialityController.text = widget.doctorModel.speciality;
    availableDays = widget.doctorModel.avaialbleDays;
    // from = TimeOfDay(
    //     hour: widget.doctorModel.from.hour,
    //     minute: widget.doctorModel.from.minute);
    // to = TimeOfDay(
    //     hour: widget.doctorModel.to.hour, minute: widget.doctorModel.to.minute);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  late DateTime fromTime = DateTime.now();
  late DateTime toTime = DateTime.now();

  Future<void> selectTimeFrom(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != TimeOfDay.now()) {
      setState(() {
        from = picked;
        fromTime = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, from!.hour, from!.minute);
      });
    }
  }

  Future<void> selectTimeTo(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != TimeOfDay.now()) {
      to = picked;
      setState(() {
        to = picked;
        toTime = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, to!.hour, to!.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(dprofileNotifierCtr);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        body: MasterScafold(
          child: Column(
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
                  'Account Details',
                  style: getMediumStyle(
                      color: MyColors.appColor1, fontSize: MyFonts.size18),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingHorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        padding40,
                        EditProfileImageWidget(
                          userImage: widget.userModel.profileImage,
                          imgPath: (imgPath) {
                            setState(() {
                              newImagePath = imgPath;
                            });
                          },
                        ),
                        padding30,
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                borderRadius: 12.r,
                                controller: fullNameController,
                                hintText: 'Enter Full Name',
                                label: 'Full Name',
                                validatorFn: uNameValidator,
                                borderColor: MyColors.lightContainerColor,
                              ),
                              CustomTextField(
                                borderRadius: 12.r,
                                controller: emailController,
                                hintText: 'info@example.com',
                                label: 'Email Address',
                                validatorFn: emailValidator,
                                tailingIconPath: AppAssets.emailSvgIcon,
                                borderColor: MyColors.lightContainerColor,
                              ),
                              CustomTextField(
                                borderRadius: 12.r,
                                controller: specialityController,
                                hintText: 'Enter Speciality',
                                label: 'Speciality',
                                tailingIconPath: AppAssets.emailSvgIcon,
                                borderColor: MyColors.lightContainerColor,
                              ),
                            ],
                          ),
                        ),
                        padding24,
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.availableDays.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: AvailableCards(
                                  isChecked: availableDays.contains(
                                      controller.availableDays[index]),
                                  onTap: () {
                                    controller.addDays(
                                        controller.availableDays[index],
                                        availableDays);
                                  },
                                  title: controller.availableDays[index],
                                ),
                              );
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                selectTimeFrom(context);
                              },
                              child: Container(
                                height: 45.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                        color: MyColors.lightGreyColor)),
                                child: Center(
                                    child: Text(
                                  'From: ${from != null ? from!.format(context) : DateFormat('hh:mm a').format(widget.doctorModel.from)}',
                                  style: getMediumStyle(
                                      color: MyColors.bodyTextColor,
                                      fontSize: MyFonts.size15),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                selectTimeTo(context);
                              },
                              child: Container(
                                height: 45.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                        color: MyColors.lightGreyColor)),
                                child: Center(
                                    child: Text(
                                  'To: ${to != null ? to!.format(context) : DateFormat('hh:mm a').format(widget.doctorModel.to)}',
                                  style: getMediumStyle(
                                      color: MyColors.bodyTextColor,
                                      fontSize: MyFonts.size15),
                                )),
                              ),
                            ),
                          ],
                        ),
                        padding40,
                        Consumer(
                          builder: (BuildContext context, WidgetRef ref,
                              Widget? child) {
                            return CustomButton(
                              isLoading: ref.watch(authControllerProvider),
                              onPressed: () async {
                                final authCtr =
                                    ref.read(authControllerProvider.notifier);
                                final authNotiCtr =
                                    ref.read(authNotifierCtr.notifier);

                                String phoneNo =
                                    "${codeController.text}-${phoneNumberController.text}";
                                if (phoneNumberController.text.trim() == "") {
                                  phoneNo = '';
                                }

                                UserModel userModel = UserModel.fromMap({
                                  ...widget.userModel.toMap(),
                                  "name": fullNameController.text,
                                  'email': emailController.text,
                                  'phoneNumber': phoneNo,
                                  'profileImage': oldImage!,
                                });
                                await authCtr.updateCurrentUserInfo(
                                    context: context,
                                    userModel: userModel,
                                    oldImage: oldImage!,
                                    newImagePath: newImagePath);
                                await authCtr.updateDoctorInfo(
                                    oldImage: oldImage!,
                                    newImagePath: newImagePath,
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    model: DoctorModel.fromMap({
                                      ...widget.doctorModel.toMap(),
                                      "name": fullNameController.text,
                                      "email": emailController.text,
                                      "speciality": specialityController.text,
                                      "avaialbleDays": availableDays,
                                      "from": from != null
                                          ? fromTime.millisecondsSinceEpoch
                                          : widget.doctorModel.from
                                              .millisecondsSinceEpoch,
                                      "to": to != null
                                          ? toTime.millisecondsSinceEpoch
                                          : widget.doctorModel.to
                                              .millisecondsSinceEpoch,
                                    }));
                                authCtr
                                    .getCurrentUserInfoStreamData()
                                    .listen((event) {
                                  authNotiCtr.setUserModelData(event);
                                });
                              },
                              buttonText: 'Update Profile',
                              buttonWidth: 130.w,
                              fontSize: MyFonts.size14,
                              backColor: MyColors.appColor1,
                            );
                          },
                        ),
                        padding100,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool hasLastName(String fullName) {
    int num = fullName.split(' ').length;
    return num > 1 ? true : false;
  }
}

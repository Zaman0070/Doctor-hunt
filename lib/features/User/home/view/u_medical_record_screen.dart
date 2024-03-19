import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/features/User/home/widgets/u_record_card.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class UserMedicalRecordScreen extends ConsumerStatefulWidget {
  const UserMedicalRecordScreen({super.key});

  @override
  ConsumerState<UserMedicalRecordScreen> createState() =>
      _UserFindDoctorScreenState();
}

class _UserFindDoctorScreenState
    extends ConsumerState<UserMedicalRecordScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Medical Records',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Consumer(builder: (context, ref, child) {
                final recordStream = ref.watch(watchAllMedRecordStreamProvider(
                    FirebaseAuth.instance.currentUser!.uid));
                return recordStream.when(
                  data: (record) {
                    return record.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.addRec,
                                height: 214.h,
                                width: 214.w,
                              ),
                              padding18,
                              Text(
                                'Add a medical record.',
                                style: getBoldStyle(
                                    color: MyColors.black,
                                    fontSize: MyFonts.size22),
                              ),
                              padding18,
                              Text(
                                textAlign: TextAlign.center,
                                'A detailed health history helps a doctor diagnose you btter.',
                                style: getRegularStyle(
                                    color: MyColors.bodyTextColor,
                                    fontSize: MyFonts.size14),
                              ),
                              padding24,
                              CustomButton(
                                  borderRadius: 6.r,
                                  backColor: MyColors.appColor1,
                                  buttonHeight: 54.h,
                                  buttonWidth: 270.w,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.userAddRecordScreen);
                                  },
                                  buttonText: 'Add a record')
                            ],
                          )
                        : Stack(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.only(bottom: 100.h),
                                itemCount: record.length,
                                itemBuilder: (context, index) {
                                  final data = record[index];
                                  return InkWell(
                                      onTap: () => Navigator.pushNamed(context,
                                              AppRoutes.userRecorDetailScreen,
                                              arguments: {
                                                'model': data,
                                              }),
                                      child: URecordCard(model: data));
                                },
                              ),
                              Positioned(
                                bottom: 30,
                                left: 35,
                                child: CustomButton(
                                    borderRadius: 6.r,
                                    backColor: MyColors.appColor1,
                                    buttonHeight: 54.h,
                                    buttonWidth: 270.w,
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          AppRoutes.userAddRecordScreen);
                                    },
                                    buttonText: 'Add a record'),
                              )
                            ],
                          );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text('Error: $error'),
                  ),
                  loading: () {
                    return const Loader();
                  },
                );
              }),
            ),
          ),
        ],
      )),
    );
  }
}

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/features/Doctor/main_menu/controller/d_main_menu_controller.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';

class SpecialityScreen extends ConsumerStatefulWidget {
  const SpecialityScreen(
      {super.key,
      required this.availableDays,
      required this.from,
      required this.to});
  final List<String> availableDays;
  final TimeOfDay from;
  final TimeOfDay to;

  @override
  ConsumerState<SpecialityScreen> createState() => _SpecialityScreenState();
}

class _SpecialityScreenState extends ConsumerState<SpecialityScreen> {
  late final TextEditingController controller;
  late final TextEditingController totalExperienceController;
  late final TextEditingController detailController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = TextEditingController();
    totalExperienceController = TextEditingController();
    detailController = TextEditingController();
    initialization();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    totalExperienceController.dispose();
    detailController.dispose();
    super.dispose();
  }

  /// Here in this method, we are initializing necessary methods
  initialization() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // DynamicLinkService.initDynamicLink(context, ref);
      final authCtr = ref.read(authControllerProvider.notifier);
      UserModel userModel = await authCtr.getCurrentUserInfo();
      final authNotifierProvider = ref.read(authNotifierCtr.notifier);
      authNotifierProvider.setUserModelData(userModel);
      setToHome();
    });
  }

  setToHome() {
    final mainMenuCtr = ref.read(dmainMenuProvider);
    mainMenuCtr.setIndex(0);
  }

  late DateTime fromTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, widget.from.hour, widget.from.minute);
  late DateTime toTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, widget.to.hour, widget.to.minute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          UserModel? userModel = ref.watch(authNotifierCtr).userModel;
          return userModel != null
              ? MasterScafold(
                  child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppConstants.padding),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          padding40,
                          Text(
                            'Speciality',
                            style: getMediumStyle(
                                color: MyColors.black,
                                fontSize: MyFonts.size24),
                          ),
                          padding40,
                          CustomTextField(
                              borderColor: MyColors.lightContainerColor,
                              borderRadius: 12.r,
                              controller: controller,
                              hintText: 'Name Speciality',
                              validatorFn: dSpecialValidator,
                              label: ''),
                          CustomTextField(
                              borderColor: MyColors.lightContainerColor,
                              borderRadius: 12.r,
                              controller: totalExperienceController,
                              hintText: 'Total Experience in years',
                              validatorFn: dTotalExpValidator,
                              label: ''),
                          CustomTextField(
                              maxLines: 6,
                              verticalPadding: 10,
                              borderColor: MyColors.lightContainerColor,
                              borderRadius: 12.r,
                              controller: detailController,
                              hintText: 'Write about your self',
                              validatorFn: dDetailValidator,
                              label: ''),
                          padding100,
                          padding100,
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            child: CustomButton(
                              buttonWidth: 295.w,
                              onPressed: () {
                                done(userModel: userModel);
                              },
                              buttonText: 'Done',
                              isLoading: ref.watch(authControllerProvider),
                              borderRadius: 12.h,
                              backColor: MyColors.appColor1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
              : const Loader();
        }),
      ),
    );
  }

  done({
    required UserModel userModel,
  }) async {
    if (formKey.currentState!.validate()) {
      await ref.read(authControllerProvider.notifier).updateDoctorInfo(
          model: DoctorModel(
              details: detailController.text,
              name: userModel.name,
              email: userModel.email,
              imageUrl: userModel.profileImage,
              speciality: controller.text,
              avaialbleDays: widget.availableDays,
              from: fromTime,
              to: toTime,
              id: userModel.id,
              createdAt: DateTime.now(),
              totalExperience: totalExperienceController.text,
              favorite: [],
              doctorId: FirebaseAuth.instance.currentUser!.uid,
              rating: 0),
          context: context,
          oldImage: '');
    }
  }
}

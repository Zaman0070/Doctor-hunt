import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_functions/validator.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';

class SpecialityScreen extends ConsumerStatefulWidget {
  const SpecialityScreen({super.key, required this.availableDays});
  final List<String> availableDays;

  @override
  ConsumerState<SpecialityScreen> createState() => _SpecialityScreenState();
}

class _SpecialityScreenState extends ConsumerState<SpecialityScreen> {
  late final TextEditingController controller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MasterScafold(
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
                      color: MyColors.black, fontSize: MyFonts.size24),
                ),
                padding40,
                CustomTextField(
                    borderColor: MyColors.lightContainerColor,
                    borderRadius: 12.r,
                    controller: controller,
                    hintText: 'Name Speciality',
                    validatorFn: dSpecialValidator,
                    label: ''),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: CustomButton(
                    buttonWidth: 295.w,
                    onPressed: done,
                    buttonText: 'Done',
                    isLoading: ref.watch(authControllerProvider),
                    borderRadius: 12.h,
                    backColor: MyColors.appColor1,
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  done() async {
    if (formKey.currentState!.validate()) {
      await ref.read(authControllerProvider.notifier).updateDoctorInfo(
          speciality: controller.text,
          availabiltyDays: widget.availableDays,
          context: context);
    }
  }
}

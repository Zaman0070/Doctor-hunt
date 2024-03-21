import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:load_switch/load_switch.dart';

class UPredictionScreen extends ConsumerStatefulWidget {
  const UPredictionScreen({super.key});

  @override
  ConsumerState<UPredictionScreen> createState() =>
      _UserFindDoctorScreenState();
}

class _UserFindDoctorScreenState extends ConsumerState<UPredictionScreen> {
  final ageController = TextEditingController();
  final glucoseController = TextEditingController();
  final bmiController = TextEditingController();
  bool isParent = false;
  bool isSibling = false;
  bool isMultipale = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
          child: Column(
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
              'Prediction',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padding24,
                CustomTextField(
                    controller: ageController,
                    hintText: 'Enter Age',
                    borderColor: MyColors.bodyTextColor.withOpacity(0.3),
                    borderRadius: 12.r,
                    label: ""),
                CustomTextField(
                    controller: glucoseController,
                    hintText: 'Enter Glucose Level',
                    borderColor: MyColors.bodyTextColor.withOpacity(0.3),
                    borderRadius: 12.r,
                    label: ""),
                CustomTextField(
                    controller: ageController,
                    hintText: 'Enter BMI Level',
                    borderColor: MyColors.bodyTextColor.withOpacity(0.3),
                    borderRadius: 12.r,
                    label: ""),
                padding24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Parent with type 2 diabetes:',
                      style: getMediumStyle(
                          color: MyColors.black, fontSize: MyFonts.size14),
                    ),
                    LoadSwitch(
                      height: 23.h,
                      width: 38.33.w,
                      value: isParent,
                      future: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        return true;
                      },
                      spinColor: (v) => MyColors.appColor1,
                      switchDecoration: (bool value, bool value2) =>
                          BoxDecoration(
                        color: value
                            ? MyColors.appColor1
                            : MyColors.lightContainerColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      style: SpinStyle.material,
                      onChange: (v) {
                        setState(() {
                          isParent = !isParent;
                        });
                      },
                      onTap: (v) {
                        print('Tapping while value is $v');
                      },
                    ),
                  ],
                ),
                padding24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sibling with type 1 diabetes:',
                      style: getMediumStyle(
                          color: MyColors.black, fontSize: MyFonts.size14),
                    ),
                    LoadSwitch(
                      height: 23.h,
                      width: 38.33.w,
                      value: isSibling,
                      future: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        return true;
                      },
                      spinColor: (v) => MyColors.appColor1,
                      switchDecoration: (bool value, bool value2) =>
                          BoxDecoration(
                        color: value
                            ? MyColors.appColor1
                            : MyColors.lightContainerColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      style: SpinStyle.material,
                      onChange: (v) {
                        setState(() {
                          isSibling = !isSibling;
                        });
                      },
                      onTap: (v) {
                        print('Tapping while value is $v');
                      },
                    ),
                  ],
                ),
                padding24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 260.w,
                      ),
                      child: Text(
                        'Multiple family members with diabetes:',
                        style: getMediumStyle(
                            color: MyColors.black, fontSize: MyFonts.size14),
                      ),
                    ),
                    LoadSwitch(
                      height: 23.h,
                      width: 38.33.w,
                      value: isMultipale,
                      future: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        return true;
                      },
                      spinColor: (v) => MyColors.appColor1,
                      switchDecoration: (bool value, bool value2) =>
                          BoxDecoration(
                        color: value
                            ? MyColors.appColor1
                            : MyColors.lightContainerColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      style: SpinStyle.material,
                      onChange: (v) {
                        setState(() {
                          isMultipale = !isMultipale;
                        });
                      },
                      onTap: (v) {
                        print('Tapping while value is $v');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

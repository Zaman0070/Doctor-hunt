import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class CustomDialogeBox extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onCrossTap;
  final String iconPath;
  final bool isLoading;
  final VoidCallback onButtonTap;

  const CustomDialogeBox({
    super.key,
    required this.title,
    this.isLoading = false,
    required this.onCrossTap,
    required this.iconPath,
    required this.onButtonTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(AppConstants.padding),
        decoration: BoxDecoration(
          color:
              context.containerColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: context.whiteColor.withOpacity(0.1),
              // spreadRadius: 12,
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onCrossTap,
                  child: Image.asset(AppAssets.dialogCloseIcon,
                      width: 38.w, height: 38.h),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Image.asset(
                key: const Key('customDialogBoxImageIcon'),
                iconPath,
                width: 80.w,
                height: 80.h),
            SizedBox(
              height: 32.h,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 243.w),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: context.whiteColor,
                    fontSize: MyFonts.size14),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            SizedBox(
              width: 150.w,
              child: CustomButton(
                isLoading: isLoading,
                onPressed: onButtonTap,
                buttonText: buttonText,
              ),
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      ),
    );
  }
}

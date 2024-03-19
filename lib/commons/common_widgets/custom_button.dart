import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/utils/loading.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backColor,
    this.textColor,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.borderColor,
  });

  final Function()? onPressed;
  final String buttonText;
  final bool isLoading;
  final Color? backColor;
  final Color? textColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;
  final double? padding;
  final double? borderRadius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('customButton'),
      height: buttonHeight ?? 54.h,
      margin: EdgeInsets.symmetric(vertical: padding ?? 10.h),
      child: RawMaterialButton(
        elevation: 2,
        fillColor: backColor ?? context.secondaryContainerColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 50.r),
          side: BorderSide(color: borderColor ?? Colors.transparent, width: 1),
        ),
        child: SizedBox(
          // padding: EdgeInsets.symmetric(vertical: 10.h),
          width: buttonWidth ?? double.infinity,
          height: buttonHeight ?? 45.h,
          child: Center(
              child: isLoading
                  ? LoadingWidget(color: context.buttonColor)
                  : Text(
                      textAlign: TextAlign.center,
                      buttonText,
                      style: getMediumStyle(
                          color: textColor ?? context.buttonColor,
                          fontSize: fontSize ?? MyFonts.size18),
                    )),
        ),
      ),
    );
  }
}

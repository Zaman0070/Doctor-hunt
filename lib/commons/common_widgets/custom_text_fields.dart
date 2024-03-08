import 'package:doctor_app/commons/common_imports/common_libs.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputType? inputType;
  final bool obscure;
  final IconData? icon;
  final String? Function(String?)? validatorFn;
  final Widget? leadingIcon;
  final Widget? tailingIcon;
  final String? tailingIconPath;
  final String? leadigingIconPath;
  final double? texFieldHeight;
  final double? borderRadius;
  final double? verticalPadding;
  final double? verticalMargin;
  final String label;
  final Color? borderColor;
  final int? maxLines;
  final bool showLabel;
  final bool showReq;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputType,
    this.leadingIcon,
    this.obscure = false,
    this.validatorFn,
    this.icon,
    this.tailingIcon,
    this.texFieldHeight,
    required this.label,
    this.showLabel = true,
    this.tailingIconPath,
    this.borderColor,
    this.maxLines,
    this.borderRadius,
    this.verticalPadding,
    this.verticalMargin,
    this.showReq = true,
    this.leadigingIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
        border: Border.all(
          color: borderColor ?? context.containerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(left: 20.0.w, bottom: 5.h),
          //   child: Row(
          //     children: [
          //       Text(
          //         label,
          //         style: getSemiBoldStyle(
          //             fontSize: MyFonts.size13, color: context.whiteColor),
          //       ),
          //       Text(
          //         label == '' ? '' : showReq?'*':'',
          //         style: getSemiBoldStyle(
          //             fontSize: MyFonts.size18,
          //             color: Theme.of(context).colorScheme.error),
          //       ),
          //     ],
          //   ),
          // ),
          TextFormField(
            validator: validatorFn,
            obscureText: obscure,
            controller: controller,
            keyboardType: inputType,
            maxLines: maxLines ?? 1,
            style: getRegularStyle(
                fontSize: MyFonts.size12,
                color: borderColor != null
                    ? context.bodyTextColor
                    : context.whiteColor),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w, vertical: verticalPadding ?? 0.0),
              errorStyle: getRegularStyle(
                  fontSize: MyFonts.size10,
                  color: Theme.of(context).colorScheme.error),
              suffixIcon: tailingIconPath != null
                  ? Padding(
                      padding: EdgeInsets.all(13.0.h),
                      child: SvgPicture.asset(
                        tailingIconPath!,
                      ),
                    )
                  : tailingIcon,
              prefixIcon: leadigingIconPath != null
                  ? Padding(
                      padding: EdgeInsets.all(13.0.h),
                      child: SvgPicture.asset(
                        leadigingIconPath!,
                      ),
                    )
                  : leadingIcon,
              hintText: hintText,
              hintStyle: getRegularStyle(
                  fontSize: MyFonts.size12, color: context.bodyTextColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
              ),
            ),
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

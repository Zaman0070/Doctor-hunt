import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPasswordTextField extends StatelessWidget {
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
  final double? texfieldHeight;
  final double? borderRadius;
  final double? verticalPadding;
  final String label;
  final Color? borderColor;
  final bool showLabel;

  const CustomPasswordTextField({
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
    this.texfieldHeight,
    required this.label,
    this.showLabel = true,
    this.tailingIconPath,
    this.borderColor,
    this.borderRadius,
    this.verticalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
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
          //         key: const Key('labelText'), // Add this line
          //         style: getSemiBoldStyle(
          //             fontSize: MyFonts.size13,
          //             color: context.whiteColor),
          //       ),
          //       Text(
          //         label == '' ? '' : '*',
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
            style: getRegularStyle(
                fontSize: MyFonts.size12, color: context.whiteColor),
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

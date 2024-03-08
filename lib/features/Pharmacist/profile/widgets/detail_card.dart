import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/utils/constants/font_manager.dart';
import 'package:doctor_app/utils/themes/my_colors.dart';
import 'package:doctor_app/utils/themes/styles_manager.dart';
import 'package:flutter/cupertino.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getRegularStyle(
              color: MyColors.bodyTextColor, fontSize: MyFonts.size14),
        ),
        padding6,
        Text(
          value,
          style:
              getMediumStyle(color: MyColors.black, fontSize: MyFonts.size14),
        ),
      ],
    );
  }
}

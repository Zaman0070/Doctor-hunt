import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileCard extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  const ProfileCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon,
                  width: 25.w, height: 25.h, color: MyColors.black),
              SizedBox(width: 10.w),
              Text(
                title,
                style: getSemiBoldStyle(
                    color: MyColors.black, fontSize: MyFonts.size16),
              ),
            ],
          ),
          SvgPicture.asset(
            AppAssets.arrowfarSvgIcon,
          )
        ],
      ),
    );
    // return Stack(
    //   children: [
    //     Container(
    //       height: 10,
    //       width: 10,
    //       color: Colors.amber,
    //     ),
    //     Image.asset(

    //       height: 150.h,
    //       width: 150.w,
    //     ),

    //   ],
    // );
  }
}

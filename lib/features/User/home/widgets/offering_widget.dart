import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class OfferingWidget extends StatelessWidget {
  const OfferingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'We are offering multiple consultation modes',
            style:
                getMediumStyle(color: MyColors.black, fontSize: MyFonts.size13),
          ),
          padding12,
          SizedBox(
            height: 125.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  card(
                      imgUrl: AppAssets.con,
                      title: 'Consultation',
                      onPressed: () {}),
                  padding12,
                  card(
                      imgUrl: AppAssets.pre,
                      title: 'Prediction',
                      onPressed: () {}),
                  padding12,
                  card(
                      imgUrl: AppAssets.rec,
                      title: 'Record store',
                      onPressed: () {}),
                  padding12,
                  card(imgUrl: AppAssets.con, title: 'News', onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  card({
    required String imgUrl,
    required String title,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 122.h,
      width: 103.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: MyColors.surfaceColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            imgUrl,
            height: 86.h,
            width: 103.w,
          ),
          Text(
            title,
            style: getRegularStyle(
                color: MyColors.black, fontSize: MyFonts.size12),
          ),
          padding6,
        ],
      ),
    );
  }
}
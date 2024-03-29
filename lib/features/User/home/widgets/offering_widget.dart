import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.userFindDoctorScreen);
                      }),
                  padding12,
                  card(
                      imgUrl: AppAssets.pre,
                      title: 'Prediction',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.userPredictionScreen);
                      }),
                  padding12,
                  card(
                      imgUrl: AppAssets.rec,
                      title: 'Record store',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.userRecordScreen);
                      }),
                  padding12,
                  card(
                      imgUrl: AppAssets.news,
                      title: 'News',
                      onPressed: () {
                        _launch();
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launch() async {
    const url = 'https://www.news-medical.net/condition/Type-1-Diabetes';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  card({
    required String imgUrl,
    required String title,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
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
      ),
    );
  }
}

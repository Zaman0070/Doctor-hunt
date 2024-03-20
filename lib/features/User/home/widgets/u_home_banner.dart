import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class UHomeBannerSection extends ConsumerStatefulWidget {
  const UHomeBannerSection({
    super.key,
  });

  @override
  ConsumerState<UHomeBannerSection> createState() => _UHomeBannerSectionState();
}

class _UHomeBannerSectionState extends ConsumerState<UHomeBannerSection> {
  int _current = 0;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<String> imageBanner = [
    AppAssets.news3,
    AppAssets.news4,
    AppAssets.news1,
    AppAssets.news2,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.padding),
      child: Column(
        children: [
          SizedBox(
            width: 1.sw,
            height: 148.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Swiper(
                    autoplay: true,
                    outer: false,
                    indicatorLayout: PageIndicatorLayout.NONE,
                    itemBuilder: (context, index) {
                      return Image.asset(imageBanner[index], fit: BoxFit.cover);
                    },
                    onIndexChanged: (value) {
                      setState(() {
                        _current = value;
                      });
                    },
                    layout: SwiperLayout.DEFAULT,
                    itemCount: imageBanner.length,
                    pagination: const SwiperPagination(
                        builder: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.transparent,
                          activeColor: Colors.transparent,
                          size: 10,
                          activeSize: 10),
                    )),
                    control: SwiperControl(
                      color: MyColors.black.withOpacity(0.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imageBanner, (value, url) {
              return Container(
                width: 6.h,
                height: 6.h,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: _current == value
                      ? BorderRadius.circular(20.r)
                      : BorderRadius.circular(20.r),
                  color: _current == value
                      ? MyColors.appColor1
                      : MyColors.appColor1.withOpacity(0.4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/rating_bar.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';

class USelectTimeDoctorCard extends ConsumerWidget {
  const USelectTimeDoctorCard({super.key, required this.model});
  final DoctorModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          height: 88.h,
          width: 1.sw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: MyColors.white,
              boxShadow: [
                BoxShadow(
                  color: MyColors.lightGreyColor.withOpacity(0.4),
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
            child: Row(
              children: [
                CachedRectangularNetworkImageWidget(
                    name: model.name,
                    image: model.imageUrl,
                    width: 70,
                    height: 67),
                padding12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(model.name,
                        style: getMediumStyle(
                            color: MyColors.black, fontSize: MyFonts.size16)),
                    padding2,
                    Text(model.speciality,
                        style: getLightStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size12)),
                    padding2,
                    CommonRatingBar(rating: model.rating, ignoreGestures: true)
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 5,
          child: IconButton(
              onPressed: () {
                ref.watch(homeControllerProvider.notifier).likeDislikeDoctor(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    docId: model.doctorId);
              },
              icon: Icon(
                model.favorite.contains(FirebaseAuth.instance.currentUser!.uid)
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart,
                color: model.favorite
                        .contains(FirebaseAuth.instance.currentUser!.uid)
                    ? MyColors.red
                    : MyColors.lightContainerColor,
                size: 24.r,
              )),
        ),
      ],
    );
  }
}

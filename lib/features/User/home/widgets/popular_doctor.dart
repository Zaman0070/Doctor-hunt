import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_toasts/all_toasts.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/commons/common_widgets/rating_bar.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopularDoctorWidget extends StatelessWidget {
  const PopularDoctorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.padding),
      child: Column(
        children: [
          padding2,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Doctor',
                style: getMediumStyle(
                    color: MyColors.black, fontSize: MyFonts.size18),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.userFindDoctorScreen);
                },
                child: Row(
                  children: [
                    Text(
                      'See all',
                      style: getLightStyle(
                          color: MyColors.bodyTextColor,
                          fontSize: MyFonts.size12),
                    ),
                    padding6,
                    SvgPicture.asset(
                      AppAssets.farArrowSvgIcon,
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
          padding12,
          Consumer(builder: (context, ref, child) {
            final doctorStream = ref.watch(watchAllPopularDoctorStream);
            return doctorStream.when(data: (doctor) {
              return SizedBox(
                height: 285.h,
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    itemCount: doctor.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      DoctorModel data = doctor[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.userDoctorDetailScreen,
                              arguments: {
                                'model': data,
                              });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          height: 264.h,
                          width: 190.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: MyColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      MyColors.lightGreyColor.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CachedRectangularNetworkImageWidget(
                                    image: data.imageUrl,
                                    width: 190,
                                    height: 180,
                                    name: data.name,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          ref
                                              .watch(homeControllerProvider
                                                  .notifier)
                                              .likeDislikeDoctor(
                                                  userId: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  docId: data.doctorId);
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: data.favorite.contains(
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid)
                                              ? MyColors.red
                                              : MyColors.white.withOpacity(0.6),
                                          size: 24.r,
                                        )),
                                  )
                                ],
                              ),
                              padding8,
                              Text(data.name,
                                  style: getMediumStyle(
                                      color: MyColors.black,
                                      fontSize: MyFonts.size18)),
                              padding4,
                              Text(data.speciality,
                                  style: getLightStyle(
                                      color: MyColors.bodyTextColor,
                                      fontSize: MyFonts.size12)),
                              padding4,
                              CommonRatingBar(
                                ignoreGestures: true,
                                rating: data.rating,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }, error: (e, s) {
              return showAwesomeSnackBar(
                context: context,
                title: 'Faild to load!',
                msg: e.toString(),
                type: ContentType.failure,
              );
            }, loading: () {
              return const Loader();
            });
          })
        ],
      ),
    );
  }
}

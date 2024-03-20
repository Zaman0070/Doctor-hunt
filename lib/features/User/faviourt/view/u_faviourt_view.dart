import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/rating_bar.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/features/User/main_menu/controller/u_main_menu_controller.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter/cupertino.dart';

class UserFaviourtScreen extends StatelessWidget {
  const UserFaviourtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              leading: Consumer(builder: (context, ref, child) {
                return IconButton(
                  onPressed: () {
                    final ctr = ref.read(usermainMenuProvider);
                    ctr.setIndex(0);
                  },
                  icon: Image.asset(
                    AppAssets.backArrowIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                );
              }),
              title: Text(
                'Favourite Doctors',
                style: getMediumStyle(
                    color: MyColors.black, fontSize: MyFonts.size18),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final communityWalls = ref.watch(
                      watchAllFavDoctorStreamProvider(
                          FirebaseAuth.instance.currentUser!.uid));
                  return communityWalls.when(
                    data: (doctor) {
                      return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.all(AppConstants.padding),
                          shrinkWrap: true,
                          itemCount: doctor.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 7,
                                  crossAxisSpacing: 7,
                                  childAspectRatio: 0.7,
                                  mainAxisExtent: 180.h),
                          itemBuilder: (context, index) {
                            final data = doctor[index];
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.userDoctorDetailScreen,
                                    arguments: {
                                      'model': data,
                                    });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        color: MyColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: MyColors.lightGreyColor
                                                .withOpacity(0.3),
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          )
                                        ]),
                                    child: Column(
                                      children: [
                                        padding16,
                                        CachedCircularNetworkImageWidget(
                                          image: data.imageUrl,
                                          name: data.name,
                                          size: 80,
                                        ),
                                        padding8,
                                        Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 150.w),
                                          child: Text(data.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: getMediumStyle(
                                                  color: MyColors.black,
                                                  fontSize: MyFonts.size15)),
                                        ),
                                        padding4,
                                        Text(data.speciality,
                                            style: getLightStyle(
                                                color: MyColors.appColor1,
                                                fontSize: MyFonts.size12)),
                                        padding4,
                                        CommonRatingBar(
                                          ignoreGestures: true,
                                          rating: data.rating,
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 4,
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
                            );
                          });
                    },
                    error: (error, stackTrace) => Center(
                      child: Text('Error: $error'),
                    ),
                    loading: () {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

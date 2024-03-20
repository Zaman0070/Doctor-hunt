import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UCustomAppBar extends ConsumerWidget {
  final VoidCallback? onPress;
  final VoidCallback onMenuPress;
  final String title;
  const UCustomAppBar(
      {super.key,
      this.onPress,
      required this.onMenuPress,
      required this.title});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userStateStreamProvider).when(
      data: (user) {
        return ref.watch(currentAuthUserinfoStreamProvider(user!.uid)).when(
          data: (userModel) {
            return SizedBox(
              height: 175.h,
              width: 1.sw,
              child: Stack(
                children: [
                  Container(
                    height: 156.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                      color: MyColors.appColor1,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi ${userModel.name}!',
                                    style: getLightStyle(
                                        color: MyColors.white,
                                        fontSize: MyFonts.size20),
                                  ),
                                  Text(
                                    title,
                                    style: getBoldStyle(
                                        color: MyColors.white,
                                        fontSize: MyFonts.size24),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: onMenuPress,
                                child: CachedCircularNetworkImageWidget(
                                  image: userModel.profileImage,
                                  size: 50,
                                  name: userModel.name,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 18,
                    right: 18,
                    child: GestureDetector(
                      onTap: onPress,
                      child: Container(
                        height: 50.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(6.r),
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(1, 3),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppAssets.searchtf,
                                    height: 15.h,
                                    width: 15.w,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Search...",
                                    style: getRegularStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size15),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (err, stack) {
            debugPrintStack(stackTrace: stack);
            debugPrint(err.toString());
            return const SizedBox();
          },
          loading: () {
            return const SizedBox();
          },
        );
      },
      error: (err, stack) {
        debugPrintStack(stackTrace: stack);
        debugPrint(err.toString());
        return const SizedBox();
      },
      loading: () {
        return const SizedBox();
      },
    );
  }
}

import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DCustomAppBar extends ConsumerWidget {
  final String title;
  const DCustomAppBar({super.key, required this.title});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userStateStreamProvider).when(
      data: (user) {
        return ref.watch(currentAuthUserinfoStreamProvider(user!.uid)).when(
          data: (userModel) {
            return SizedBox(
              height: 135.h,
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
                              CachedCircularNetworkImageWidget(
                                image: userModel.profileImage,
                                size: 50,
                                name: userModel.name,
                              ),
                            ],
                          ),
                        ],
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

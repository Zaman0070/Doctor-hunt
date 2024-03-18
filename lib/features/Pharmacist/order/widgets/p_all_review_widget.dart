import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/commons/common_widgets/rating_bar.dart';
import 'package:doctor_app/features/Pharmacist/order/controller/order_controller.dart';

class PAllReviewWidget extends StatelessWidget {
  const PAllReviewWidget({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final reviewStream = ref.watch(watchAllReviewProvider(productId));
        return reviewStream.when(
          data: (reviews) {
            return Column(
              children: [
                for (var review in reviews)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CachedCircularNetworkImageWidget(
                            image: review.userImage!,
                            size: 48,
                            name: review.userName!,
                          ),
                          padding12,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' ${review.userName!}',
                                style: getSemiBoldStyle(
                                    color: MyColors.black,
                                    fontSize: MyFonts.size14),
                              ),
                              CommonRatingBar(
                                rating: review.rating!,
                                ignoreGestures: true,
                              )
                            ],
                          ),
                        ],
                      ),
                      padding12,
                      Text(
                        review.review!,
                        style: getRegularStyle(
                            color: MyColors.bluishTextColor,
                            fontSize: MyFonts.size12),
                      ),
                      padding18,
                    ],
                  ),
              ],
            );
          },
          loading: () => const Loader(),
          error: (error, stack) => Center(
            child: Text(error.toString()),
          ),
        );
      },
    );
  }
}

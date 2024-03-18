import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/commons/common_widgets/rating_bar.dart';
import 'package:doctor_app/features/Pharmacist/order/controller/order_controller.dart';
import 'package:doctor_app/features/Pharmacist/order/widgets/p_all_review_widget.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class PharmaistProductDetailScreen extends StatelessWidget {
  const PharmaistProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  AppAssets.backArrowIcon,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
              title: Text(
                'Product details',
                style: getMediumStyle(
                    color: MyColors.black, fontSize: MyFonts.size18),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Consumer(builder: (context, ref, child) {
                    final productStream =
                        ref.watch(watchProductByIdProvider(productId));
                    return productStream.when(
                      data: (product) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedRectangularNetworkImageWidget(
                                borderColor: MyColors.lightContainerColor,
                                image: product.productImage!,
                                width: 328,
                                height: 280),
                            padding18,
                            Text(
                              product.productName!,
                              style: getMediumStyle(
                                  color: MyColors.black,
                                  fontSize: MyFonts.size18),
                            ),
                            padding8,
                            Text(
                              product.productDescription!,
                              style: getLightStyle(
                                  color: MyColors.bodyTextColor,
                                  fontSize: MyFonts.size14),
                            ),
                            padding8,
                            Row(
                              children: [
                                Text(
                                  'Price: ',
                                  style: getMediumStyle(
                                      color: MyColors.black,
                                      fontSize: MyFonts.size16),
                                ),
                                Text(
                                  product.productPrice!,
                                  style: getMediumStyle(
                                      color: MyColors.appColor1,
                                      fontSize: MyFonts.size16),
                                ),
                              ],
                            ),
                            padding16,
                            Text(
                              'Customer Reviews',
                              style: getMediumStyle(
                                  color: MyColors.bodyTextColor,
                                  fontSize: MyFonts.size14),
                            ),
                            padding8,
                            Row(
                              children: [
                                Text(
                                  '${product.rating} Out of 5',
                                  style: getMediumStyle(
                                      color: MyColors.black,
                                      fontSize: MyFonts.size12),
                                ),
                                padding6,
                                CommonRatingBar(
                                    rating: product.rating!,
                                    ignoreGestures: true)
                              ],
                            ),
                            padding16,
                            Text(
                              'Review Product',
                              style: getMediumStyle(
                                  color: MyColors.black,
                                  fontSize: MyFonts.size15),
                            ),
                            padding16,
                            PAllReviewWidget(productId: productId),
                          ],
                        );
                      },
                      error: (e, s) {
                        return Center(
                          child: Text('Error: $e'),
                        );
                      },
                      loading: () => const Loader(),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/features/Pharmacist/order/controller/order_controller.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:intl/intl.dart';

class PProcessingOrderWidget extends ConsumerWidget {
  const PProcessingOrderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      final orderStream = ref.watch(watchOrderByStatus('Processing'));
      return orderStream.when(data: (orders) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: orders.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemBuilder: (context, index) {
              final model = orders[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoutes.pharmacyOrderDetailScreen,
                      arguments: {'orderModel': model});
                },
                child: Container(
                  margin: EdgeInsets.all(AppConstants.padding),
                  padding: EdgeInsets.all(AppConstants.padding),
                  height: 150.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: MyColors.lightContainerColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedRectangularNetworkImageWidget(
                        image: model.productImage!,
                        width: 110,
                        height: 110,
                      ),
                      padding8,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.productName!,
                            style: getRegularStyle(
                                color: MyColors.black,
                                fontSize: MyFonts.size12),
                          ),
                          padding4,
                          Container(
                            constraints: BoxConstraints(maxWidth: 160.w),
                            child: Text(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              model.productDescription!,
                              style: getLightStyle(
                                  color: MyColors.bodyTextColor,
                                  fontSize: MyFonts.size12),
                            ),
                          ),
                          padding6,
                          Text(
                            'Rs. ${model.productPrice!}',
                            style: getSemiBoldStyle(
                                color: MyColors.black,
                                fontSize: MyFonts.size14),
                          ),
                          padding6,
                          SizedBox(
                            width: 160.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('dd MMM yyyy')
                                      .format(model.createdAt!),
                                  style: getSemiBoldStyle(
                                      color: MyColors.bluishTextColor,
                                      fontSize: MyFonts.size10),
                                ),
                                Container(
                                  height: 17.h,
                                  width: 65.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    color: MyColors.appColor1.withOpacity(0.15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      model.orderStatus!,
                                      style: getSemiBoldStyle(
                                          color: MyColors.bluishTextColor,
                                          fontSize: MyFonts.size8),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      }, error: (error, stackTrace) {
        return Center(
          child: Text(
            'Error: $error',
            style: getRegularStyle(
                color: MyColors.black, fontSize: MyFonts.size12),
          ),
        );
      }, loading: () {
        return const Center(
          child: Loader(),
        );
      });
    });
  }
}

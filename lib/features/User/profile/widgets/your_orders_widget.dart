import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/models/order/order_model.dart';

class UYourOrderWidget extends ConsumerWidget {
  const UYourOrderWidget(
      {super.key, required this.model, required this.onPressed});
  final OrderModel model;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: MyColors.lightContainerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedRectangularNetworkImageWidget(
                image: model.productImage!,
                width: 175,
                height: 100,
              ),
            ],
          ),
          padding8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.productName!,
                  style: getRegularStyle(
                      color: MyColors.black, fontSize: MyFonts.size12),
                ),
                padding4,
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  model.productDescription!,
                  style: getLightStyle(
                      color: MyColors.bodyTextColor, fontSize: MyFonts.size12),
                ),
                padding4,
                Text(
                  'Rs. ${model.productPrice!}',
                  style: getSemiBoldStyle(
                      color: MyColors.black, fontSize: MyFonts.size14),
                ),
                padding4,
                Row(
                  children: [
                    Text(
                      'Order Status:',
                      style: getSemiBoldStyle(
                          color: MyColors.black, fontSize: MyFonts.size10),
                    ),
                    padding4,
                    Text(
                      model.orderStatus!,
                      style: getSemiBoldStyle(
                          color: MyColors.bodyTextColor,
                          fontSize: MyFonts.size10),
                    ),
                  ],
                ),
                CustomButton(
                  onPressed:
                      model.orderStatus == "Delivered" ? onPressed : null,
                  buttonText: 'Add Review',
                  buttonHeight: 30.h,
                  borderRadius: 6.r,
                  backColor: model.orderStatus == "Delivered"
                      ? MyColors.appColor1
                      : MyColors.lightContainerColor,
                  fontSize: MyFonts.size13,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

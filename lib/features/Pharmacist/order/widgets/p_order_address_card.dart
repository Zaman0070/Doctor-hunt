import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/models/order/order_model.dart';

class POrderAddressCard extends StatelessWidget {
  const POrderAddressCard({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 1.sw,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: context.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: context.bodyTextColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery Address',
              style: getSemiBoldStyle(
                  color: MyColors.black, fontSize: MyFonts.size15),
            ),
            padding4,
            Text(
              orderModel.userAddress!,
              style: getLightStyle(
                  color: MyColors.lightLightTextColor,
                  fontSize: MyFonts.size10),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/features/Pharmacist/order/widgets/p_manage_order_widget.dart';
import 'package:doctor_app/features/Pharmacist/order/widgets/p_order_address_card.dart';
import 'package:doctor_app/models/order/order_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class PharmaistOrderDetailScreen extends StatelessWidget {
  const PharmaistOrderDetailScreen({super.key, required this.orderModel});
  final OrderModel orderModel;

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
                'Order details',
                style: getMediumStyle(
                    color: MyColors.black, fontSize: MyFonts.size18),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                children: [
                  POrderAddressCard(orderModel: orderModel),
                  padding12,
                  PManageOrderCard(model: orderModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

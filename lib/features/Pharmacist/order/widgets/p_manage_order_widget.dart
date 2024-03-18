import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/features/Pharmacist/order/controller/order_controller.dart';
import 'package:doctor_app/features/Pharmacist/order/diaglog/p_order_status_dialog.dart';
import 'package:doctor_app/features/Pharmacist/order/widgets/p_order_timeline_widget.dart';
import 'package:doctor_app/models/order/order_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class PManageOrderCard extends ConsumerStatefulWidget {
  const PManageOrderCard({super.key, required this.model});
  final OrderModel model;

  @override
  ConsumerState<PManageOrderCard> createState() => _PManageOrderCardState();
}

class _PManageOrderCardState extends ConsumerState<PManageOrderCard> {
  String orderStatus = '';
  @override
  void initState() {
    orderStatus = widget.model.orderStatus!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 215.h,
          width: 1.sw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: context.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: MyColors.bodyTextColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Container(
                  height: 44.h,
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: context.scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.bodyTextColor.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      padding8,
                      Text(
                        'Manage Order',
                        style: getSemiBoldStyle(
                            color: MyColors.black, fontSize: MyFonts.size15),
                      ),
                      CustomPopup(
                        barrierColor: MyColors.bodyTextColor.withOpacity(0.1),
                        backgroundColor: Colors.white,
                        content: POrderStatusDialog(
                          pending: () {
                            setState(() {
                              orderStatus = 'Pending';
                            });
                            updateOrder("Pending");
                            Navigator.pop(context);
                          },
                          prepairing: () {
                            setState(() {
                              orderStatus = "Processing";
                            });
                            updateOrder("Processing");
                            Navigator.pop(context);
                          },
                          delivered: () {
                            setState(() {
                              orderStatus = 'Delivered';
                            });
                            updateOrder("Delivered");
                            Navigator.pop(context);
                          },
                          cancelled: () {
                            setState(() {
                              orderStatus = 'Cancelled';
                            });
                            updateOrder("Cancelled");
                            Navigator.pop(context);
                          },
                        ),
                        child: Container(
                          height: 44.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              color: MyColors.appColor1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Select Status",
                                style: getSemiBoldStyle(
                                    color: context.scaffoldBackgroundColor,
                                    fontSize: MyFonts.size15),
                              ),
                              RotatedBox(
                                quarterTurns: 1,
                                child: SvgPicture.asset(
                                    AppAssets.farArrowSvgIcon,
                                    colorFilter: const ColorFilter.mode(
                                        MyColors.white, BlendMode.srcIn),
                                    height: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                padding24,
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.pharmacyProductDetailScreen,
                        arguments: {
                          'productId': widget.model.productId,
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedRectangularNetworkImageWidget(
                        image: widget.model.productImage!,
                        width: 110,
                        height: 110,
                      ),
                      padding8,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.model.productName!,
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
                              widget.model.productDescription!,
                              style: getLightStyle(
                                  color: MyColors.bodyTextColor,
                                  fontSize: MyFonts.size12),
                            ),
                          ),
                          padding6,
                          Text(
                            'Rs. ${widget.model.productPrice!}',
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
                                      .format(widget.model.createdAt!),
                                  style: getSemiBoldStyle(
                                      color: MyColors.bluishTextColor,
                                      fontSize: MyFonts.size10),
                                ),
                                Container(
                                  height: 17.h,
                                  width: 65.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    color: orderStatus == "Cancelled"
                                        ? MyColors.red.withOpacity(0.15)
                                        : MyColors.appColor1.withOpacity(0.15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      orderStatus,
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
              ],
            ),
          ),
        ),
        padding24,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Timeline",
              style: getSemiBoldStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
            Text(
              '#${widget.model.orderId}',
              style: getMediumStyle(
                  color: MyColors.bodyTextColor, fontSize: MyFonts.size10),
            )
          ],
        ),
        padding24,
        OrderTimeLineCard(
          startDate: widget.model.createdAt!,
          endDate: widget.model.deliveredDate!,
          status: orderStatus,
        ),
      ],
    );
  }

  updateOrder(status) async {
    await ref.watch(pharmistOrderControllerProvider.notifier).updateOrderStatus(
        orderId: widget.model.orderId!,
        status: status,
        date: DateTime.now().millisecondsSinceEpoch);
  }
}

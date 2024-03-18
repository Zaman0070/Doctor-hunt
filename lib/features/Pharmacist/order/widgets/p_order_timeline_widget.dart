import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:intl/intl.dart';

class OrderTimeLineCard extends StatelessWidget {
  const OrderTimeLineCard(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.status});

  final DateTime startDate;
  final DateTime endDate;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd MMM yyy').format(startDate),
                  style: getSemiBoldStyle(
                      color: MyColors.black, fontSize: MyFonts.size16),
                ),
                Text(
                  DateFormat('hh:mm a').format(startDate),
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size10),
                ),
              ],
            ),
            padding100,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd MMM yyy').format(endDate),
                  style: getSemiBoldStyle(
                      color: status == "Delivered"
                          ? MyColors.black
                          : MyColors.lightContainerColor,
                      fontSize: MyFonts.size16),
                ),
                Text(
                  DateFormat('hh:mm a')
                      .format(startDate == endDate ? DateTime.now() : endDate),
                  style: getMediumStyle(
                      color: status == "Delivered"
                          ? MyColors.black
                          : MyColors.lightContainerColor,
                      fontSize: MyFonts.size10),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(
                radius: 12.r,
                backgroundColor: MyColors.appColor1.withOpacity(0.15),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundColor: MyColors.appColor1,
                  ),
                )),
            padding16,
            Container(
              height: 80.h,
              width: 2.w,
              color: MyColors.appColor1,
            ),
            padding16,
            CircleAvatar(
              radius: 12.r,
              backgroundColor: status == 'Delivered'
                  ? MyColors.appColor1.withOpacity(0.15)
                  : MyColors.lightContainerColor,
              child: status == 'Delivered'
                  ? Icon(
                      Icons.check,
                      size: 12.r,
                    )
                  : CircleAvatar(
                      radius: 7.r,
                      backgroundColor: MyColors.bodyTextColor.withOpacity(0.6),
                    ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: getSemiBoldStyle(
                      color: MyColors.black, fontSize: MyFonts.size16),
                ),
                padding12,
              ],
            ),
            padding100,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Confirmed",
                  style: getSemiBoldStyle(
                      color: status == "Delivered"
                          ? MyColors.black
                          : MyColors.lightContainerColor,
                      fontSize: MyFonts.size16),
                ),
                Text(
                  status == 'Delivered'
                      ? 'Your order has been delivered'
                      : 'Delivery time too long',
                  style: getMediumStyle(
                      color: MyColors.lightContainerColor,
                      fontSize: MyFonts.size10),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

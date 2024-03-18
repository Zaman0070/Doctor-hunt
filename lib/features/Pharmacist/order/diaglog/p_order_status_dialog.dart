import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';

class POrderStatusDialog extends StatelessWidget {
  const POrderStatusDialog({
    super.key,
    required this.pending,
    required this.prepairing,
    required this.delivered,
    required this.cancelled,
  });
  final VoidCallback pending;
  final VoidCallback prepairing;
  final VoidCallback delivered;
  final VoidCallback cancelled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: 200.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: context.scaffoldBackgroundColor),
      child: Column(
        children: [
          padding16,
          InkWell(
            onTap: pending,
            child: Text(
              "Pending",
              style:
                  getBoldStyle(color: MyColors.black, fontSize: MyFonts.size14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Divider(
              color: MyColors.bodyTextColor.withOpacity(0.3),
            ),
          ),
          InkWell(
            onTap: prepairing,
            child: Text(
              "Processing",
              style:
                  getBoldStyle(color: MyColors.black, fontSize: MyFonts.size14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Divider(
              color: MyColors.bodyTextColor.withOpacity(0.3),
            ),
          ),
          InkWell(
            onTap: delivered,
            child: Text(
              "Delivered",
              style:
                  getBoldStyle(color: MyColors.black, fontSize: MyFonts.size14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Divider(
              color: MyColors.bodyTextColor.withOpacity(0.3),
            ),
          ),
          InkWell(
            onTap: cancelled,
            child: Text(
              "Cancelled",
              style:
                  getBoldStyle(color: MyColors.black, fontSize: MyFonts.size14),
            ),
          ),
        ],
      ),
    );
  }
}

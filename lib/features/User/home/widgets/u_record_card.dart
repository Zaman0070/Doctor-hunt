// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/models/med_record/med_record_model.dart';

class URecordCard extends StatefulWidget {
  const URecordCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MedRecordModel model;

  @override
  State<URecordCard> createState() => _URecordCardState();
}

class _URecordCardState extends State<URecordCard> {
  late DateTime tenDaysAgo =
      widget.model.recCreatedOn.subtract(const Duration(days: 10));
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: 1.sw,
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: MyColors.lightGreyColor.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  height: 60.h,
                  width: 55.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: MyColors.appColor1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('dd').format(widget.model.recCreatedOn),
                        style: getMediumStyle(
                            color: MyColors.white, fontSize: MyFonts.size14),
                      ),
                      Text(
                        DateFormat('MMM').format(widget.model.recCreatedOn),
                        style: getMediumStyle(
                            color: MyColors.white, fontSize: MyFonts.size14),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 22.h,
                  width: 55.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: MyColors.appColor1.withOpacity(0.1)),
                  child: Center(
                      child: Text(
                    DateTime.now().isBefore(tenDaysAgo) ? 'Old' : "New",
                    style: getMediumStyle(
                        color: MyColors.appColor1, fontSize: MyFonts.size12),
                  )),
                ),
              ],
            ),
            padding12,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Records added by you',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size14),
                ),
                Text(
                  'Records for ${widget.model.doctorName}',
                  style: getLightStyle(
                      color: MyColors.appColor1, fontSize: MyFonts.size12),
                ),
                padding4,
                Text.rich(
                  TextSpan(
                    text: 'Records Type: ',
                    style: getMediumStyle(
                        color: MyColors.black, fontSize: MyFonts.size12),
                    children: [
                      TextSpan(
                        text: widget.model.recType,
                        style: getMediumStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size12),
                      ),
                    ],
                  ),
                ),
                padding24,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

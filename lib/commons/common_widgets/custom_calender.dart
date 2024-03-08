import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:intl/intl.dart';

class CustumCalender extends StatelessWidget {
  final DateTime date;
  const CustumCalender({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
          child: Text(
            DateFormat('dd MMMM yyyy').format(date),
            style: getSemiBoldStyle(
                color: context.secondaryContainerColor,
                fontSize: MyFonts.size16),
          ),
        ),
        padding16,
        SizedBox(
          height: 82.h,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    height: 82.h,
                    width: 48.w,
                    decoration: BoxDecoration(
                      color: index == 0
                          ? context.secondaryContainerColor
                          : context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEE')
                              .format(date.add(Duration(days: index))),
                          style: getMediumStyle(
                              color: index == 0
                                  ? context.scaffoldBackgroundColor
                                  : context.secondaryContainerColor,
                              fontSize: MyFonts.size16),
                        ),
                        padding4,
                        Text(
                          DateFormat('dd')
                              .format(date.add(Duration(days: index))),
                          style: getRegularStyle(
                              color: index == 0
                                  ? context.scaffoldBackgroundColor
                                  : context.secondaryContainerColor,
                              fontSize: MyFonts.size14),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

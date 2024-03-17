import 'package:doctor_app/commons/common_imports/common_libs.dart';

class AvailableCards extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isChecked;
  const AvailableCards(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(
                    color: isChecked
                        ? MyColors.appColor1
                        : MyColors.bodyTextColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  backgroundColor:
                      isChecked ? MyColors.appColor1 : Colors.transparent,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: getMediumStyle(
                    color: MyColors.black, fontSize: MyFonts.size18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

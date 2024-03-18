import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/features/User/pharmacy/controller/u_pharmacy_noti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UGenderWidget extends ConsumerStatefulWidget {
  const UGenderWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  ConsumerState<UGenderWidget> createState() => _EditProfileCardState();
}

class _EditProfileCardState extends ConsumerState<UGenderWidget> {
  @override
  Widget build(BuildContext context) {
    final ctr = ref.watch(uPharmacyNotifierCtr);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: getMediumStyle(
                color: MyColors.black, fontSize: MyFonts.size14)),
        padding12,
        Wrap(
          direction: Axis.horizontal,
          children: ctr.genderList
              .map((e) => Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: GestureDetector(
                      onTap: () {
                        ctr.setGender(e);
                      },
                      child: SizedBox(
                        width: 80.w,
                        child: Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  border: Border.all(
                                      color: ctr.gender == e
                                          ? MyColors.appColor1
                                          : MyColors.bodyTextColor)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.5),
                                child: CircleAvatar(
                                  backgroundColor: ctr.gender == e
                                      ? MyColors.appColor1
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            padding4,
                            Text(
                              e,
                              style: getLightStyle(
                                  color: MyColors.bodyTextColor,
                                  fontSize: MyFonts.size16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

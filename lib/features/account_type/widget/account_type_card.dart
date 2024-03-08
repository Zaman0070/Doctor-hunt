import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:flutter_svg/svg.dart';

class AccountTypeCard extends StatelessWidget {
  final Function() onTap;
  final int index;
  final int selectIndex;
  final String image;
  final String title;

  const AccountTypeCard({
    super.key,
    required this.onTap,
    required this.index,
    required this.selectIndex,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 155.h,
        width: 134.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: MyColors.lightContainerColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20.h,
                width: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: selectIndex == index
                          ? MyColors.appColor1
                          : MyColors.lightContainerColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 12.h,
                      width: 12.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: selectIndex == index
                            ? MyColors.appColor1
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: SvgPicture.asset(
                  image,
                  height: 48.h,
                  width: 48.w,
                  color: MyColors.appColor1,
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Center(
                child: Text(
                  title,
                  style: getBoldStyle(
                      color: MyColors.black, fontSize: MyFonts.size16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

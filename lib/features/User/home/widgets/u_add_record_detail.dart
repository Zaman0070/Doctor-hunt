import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_svg/svg.dart';

class UAddRecordDetailSection extends StatefulWidget {
  final String name;
  final List<String> image;
  final List<String> title;
  final Function(String) onTap;
  final VoidCallback edit;
  final VoidCallback selectDate;
  final String date;
  final VoidCallback upload;
  final bool isLoad;

  const UAddRecordDetailSection(
      {super.key,
      required this.name,
      required this.image,
      required this.title,
      required this.onTap,
      required this.edit,
      required this.selectDate,
      required this.date, required this.upload, required this.isLoad});

  @override
  State<UAddRecordDetailSection> createState() =>
      _UAddRecordDetailSectionState();
}

class _UAddRecordDetailSectionState extends State<UAddRecordDetailSection> {
  int seletIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 453.h,
      width: 1.sw,
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
                color: MyColors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          padding16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Record for',
                  style: getRegularStyle(
                      color: MyColors.black, fontSize: MyFonts.size16)),
              InkWell(
                  onTap: widget.edit,
                  child: SvgPicture.asset(AppAssets.edit00SvgIcon))
            ],
          ),
          padding12,
          Text(widget.name,
              style: getMediumStyle(
                  color: MyColors.appColor1, fontSize: MyFonts.size18)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: const Divider(
              thickness: 0.8,
            ),
          ),
          Text('Type of record',
              style: getRegularStyle(
                  color: MyColors.black, fontSize: MyFonts.size16)),
          padding18,
          SizedBox(
            height: 60.h,
            child: ListView.builder(
                itemCount: widget.image.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          seletIndex = index;
                          widget.onTap(widget.title[index]);
                        });
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            widget.image[index],
                            height: 22.h,
                            width: 17.w,
                            color: seletIndex == index
                                ? MyColors.appColor1
                                : MyColors.bodyTextColor,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            widget.title[index],
                            style: getRegularStyle(
                                color: seletIndex == index
                                    ? MyColors.appColor1
                                    : MyColors.bodyTextColor,
                                fontSize: MyFonts.size13),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          const Divider(
            thickness: 0.8,
          ),
          padding16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Record created on',
                  style: getRegularStyle(
                      color: MyColors.black, fontSize: MyFonts.size16)),
              InkWell(
                  onTap: widget.selectDate,
                  child: SvgPicture.asset(AppAssets.edit00SvgIcon))
            ],
          ),
          padding12,
          Text(widget.date,
              style: getMediumStyle(
                  color: MyColors.appColor1, fontSize: MyFonts.size18)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(
              thickness: 0.8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomButton(
              onPressed: widget.upload,
              isLoading: widget.isLoad,
              buttonText: 'Upload record',
              backColor: MyColors.appColor1,
              borderRadius: 6.r,
              fontSize: MyFonts.size18,
            ),
          ),
        ]),
      ),
    );
  }
}

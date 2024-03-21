import 'dart:io';

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class UploadBottomSheetSection extends StatelessWidget {
  final Function() camera;
  final Function() gallery;
  final String title;
  final List<File> file;
  final double top;
  const UploadBottomSheetSection(
      {super.key,
      required this.camera,
      required this.gallery,
      required this.title,
      required this.file,
      this.top = 75.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Container(
        height: 250.h,
        decoration: const BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                      color: MyColors.lightContainerColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              padding40,
              Text(title,
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size22)),
              padding32,
              InkWell(
                onTap: camera,
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.camera,
                      width: 15.w,
                      height: 12.h,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      'Take a photo',
                      style: getRegularStyle(
                          color: MyColors.black, fontSize: MyFonts.size16),
                    ),
                  ],
                ),
              ),
              padding16,
              InkWell(
                onTap: gallery,
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.gallery,
                      width: 15.w,
                      height: 12.h,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      'Choose from gallery',
                      style: getRegularStyle(
                          color: MyColors.black, fontSize: MyFonts.size16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

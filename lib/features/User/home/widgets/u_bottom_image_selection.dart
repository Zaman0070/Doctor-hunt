import 'dart:io';

import 'package:doctor_app/commons/common_imports/common_libs.dart';

class UAddImageSection extends StatelessWidget {
  final Function() onTap;
  final List<File> image;
  const UAddImageSection({super.key, required this.onTap, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            image.isNotEmpty
                ? Row(
                    children: [
                      for (var image in image)
                        Container(
                          height: 120.h,
                          width: 100.w,
                          margin: EdgeInsets.only(right: 10.w),
                          decoration: BoxDecoration(
                              image: image.path.isNotEmpty
                                  ? DecorationImage(
                                      image: FileImage(File(image.path)),
                                      fit: BoxFit.cover)
                                  : null,
                              borderRadius: BorderRadius.circular(6.r),
                              color: MyColors.appColor1.withOpacity(0.1)),
                        ),
                    ],
                  )
                : Container(),
            InkWell(
              onTap: onTap,
              child: Container(
                height: 120.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: MyColors.appColor1.withOpacity(0.1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 30.r,
                    ),
                    Text(
                      image.isNotEmpty ? "Add More Images" : "Add Image",
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                          color: MyColors.black, fontSize: MyFonts.size16),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

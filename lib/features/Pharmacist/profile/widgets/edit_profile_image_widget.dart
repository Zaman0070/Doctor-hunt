import 'dart:io';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../commons/common_functions/crop_image.dart';
import '../../../auth/controller/auth_notifier_controller.dart';

class EditProfileImageWidget extends StatefulWidget {
  final String userImage;
  final Function(String imgPath) imgPath;
  const EditProfileImageWidget({
    super.key,
    required this.userImage,
    required this.imgPath,
  });

  @override
  State<EditProfileImageWidget> createState() => _EditProfileImageWidgetState();
}

class _EditProfileImageWidgetState extends State<EditProfileImageWidget> {
  File? imageFile;
  getPhoto() async {
    XFile? imgFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imgFile != null) {
      File? img =
          // ignore: use_build_context_synchronously
          await cropImage(imageFile: File(imgFile.path), context: context);
      if (img != null) {
        setState(() {
          imageFile = img;
        });
        widget.imgPath(imageFile!.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Consumer(builder: (context, ref, child) {
            UserModel userModel = ref.read(authNotifierCtr).userModel!;
            return CircleAvatar(
              radius: 62.r,
              backgroundColor: MyColors.appColor1,
              child: CircleAvatar(
                radius: 61.5.r,
                backgroundColor: MyColors.appColor1,
                backgroundImage:
                    imageFile != null ? FileImage(imageFile!) : null,
                child: imageFile == null
                    ? CachedCircularNetworkImageWidget(
                        name: userModel.name,
                        image: widget.userImage,
                        size: 120)
                    : null,
              ),
            );
          }),
          Positioned(
              right: 0,
              bottom: 3.h,
              child: InkWell(
                onTap: getPhoto,
                child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: MyColors.appColor1,
                    child: Image.asset(
                      AppAssets.cameraIcon,
                      width: 24.w,
                      height: 24.h,
                      color: context.buttonColor,
                    )),
              ))
        ],
      ),
    );
  }
}

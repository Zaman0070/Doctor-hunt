import 'dart:io';
import 'package:doctor_app/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';


// ...

Future<File?> cropImage(
    {required File imageFile, required BuildContext context}) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,
    ],
    cropStyle: CropStyle.circle,
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: context.buttonColor,
          toolbarWidgetColor: context.whiteColor,
          initAspectRatio: CropAspectRatioPreset.original,
          activeControlsWidgetColor:  context.buttonColor,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ],
  );

  if (croppedFile != null) {
    return File(croppedFile.path);
  }
  return null;
}

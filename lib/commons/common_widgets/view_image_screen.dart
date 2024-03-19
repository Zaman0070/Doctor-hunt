import 'package:doctor_app/utils/themes/my_colors.dart';
import 'package:flutter/material.dart';

class ViewImageScreen extends StatelessWidget {
  const ViewImageScreen({super.key, required this.imgUrl});
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.black,
        appBar: AppBar(
            backgroundColor: MyColors.black,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: MyColors.white,
              ),
            )),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imgUrl,
                ),
                fit: BoxFit.cover,
              ),
            )));
  }
}

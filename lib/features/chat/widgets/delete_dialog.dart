import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/features/Pharmacist/profile/controller/profile_controller.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/features/chat/controller/chat_Controller.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteDialog extends ConsumerWidget {
  const DeleteDialog({super.key, required this.id, required this.recieverId});
  final String id;
  final String recieverId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 200,
      width: 300.w,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      ref.read(pprofileNotifierCtr).setIsDeleteAccount(false);
                    },
                    child: Image.asset(
                      AppAssets.dialogClose,
                      height: 25.h,
                      width: 25.h,
                    ),
                  ),
                ],
              ),
              Image.asset(
                AppAssets.infoRound,
                height: 40.h,
                width: 40.w,
              ),
              padding12,
              Text(
                'Are You Sure Want To Delete this text?',
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: MyColors.bodyTextColor, fontSize: MyFonts.size15),
              ),
              padding12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      borderColor: MyColors.appColor1,
                      backColor: Colors.white,
                      buttonHeight: 38.h,
                      buttonWidth: 130.w,
                      onPressed: () {
                        Navigator.pop(context);
                        ref.read(pprofileNotifierCtr).setIsDeleteAccount(false);
                      },
                      textColor: MyColors.appColor1,
                      buttonText: 'Cancel'),
                  CustomButton(
                      isLoading: ref.watch(authControllerProvider),
                      backColor: context.errorColor,
                      buttonHeight: 38.h,
                      buttonWidth: 130.w,
                      onPressed: () async {
                        ref.watch(chatControllerProvider).deleteMessage(
                              context,
                              recieverId,
                              id,
                            );
                        Navigator.pop(context);
                      },
                      textColor: MyColors.white,
                      buttonText: 'Delete'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

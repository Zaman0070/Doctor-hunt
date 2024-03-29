import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/features/Doctor/profile/dialog/d_delete_account_dialog.dart';
import 'package:doctor_app/features/Doctor/profile/dialog/d_logout_dialog.dart';
import 'package:doctor_app/features/Doctor/profile/widgets/profile_card.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.appColor1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            AppAssets.backArrowIcon,
            width: 30.w,
            height: 30.h,
          ),
        ),
        title: Text(
          'My Profile',
          style: getBoldStyle(color: MyColors.white, fontSize: MyFonts.size18),
        ),
      ),
      body: MasterScafold(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              UserModel userModel = ref.watch(authNotifierCtr).userModel!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 250.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                        color: MyColors.appColor1,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r))),
                    child: Column(
                      children: [
                        padding24,
                        Text('Set up your profile',
                            style: getMediumStyle(
                                color: MyColors.white,
                                fontSize: MyFonts.size16)),
                        padding16,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'Update your profile to connect your patient with better impression.',
                            textAlign: TextAlign.center,
                            style: getRegularStyle(
                                color: MyColors.white,
                                fontSize: MyFonts.size14),
                          ),
                        ),
                        padding18,
                        CircleAvatar(
                          radius: 52.r,
                          backgroundColor: MyColors.appColor2,
                          child: CircleAvatar(
                            radius: 50.5.r,
                            backgroundColor: MyColors.appColor1,
                            child: CachedCircularNetworkImageWidget(
                              name: userModel.name,
                              size: 120,
                              image: userModel.profileImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  padding28,
                  Padding(
                    padding: EdgeInsets.all(AppConstants.padding),
                    child: Column(
                      children: [
                        ProfileCard(
                            icon: AppAssets.accountSvgIcon,
                            title: 'Account details',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.userEditProfileScreen,
                                  arguments: {'userModel': userModel});
                            }),
                        padding20,
                        ProfileCard(
                            icon: AppAssets.orderSvgIcon,
                            title: 'Your Orders',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.userYourOrderScreen);
                            }),
                        padding20,
                        ProfileCard(
                            icon: AppAssets.linkSvgIcon,
                            title: 'Community Chat',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.commMessageScreen);
                            }),
                        padding20,
                        ProfileCard(
                            icon: AppAssets.bellSvgIcon,
                            title: 'Remainder',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.userRemainderScreen);
                            }),
                        padding20,
                        ProfileCard(
                            icon: AppAssets.newsSvgIcon,
                            title: 'News',
                            onTap: () {
                              _launch();
                            }),
                        padding20,
                        ProfileCard(
                            icon: AppAssets.privacySvgIcon,
                            title: 'Terms & Conditions',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.termConditionScreen);
                            }),
                        padding20,
                        ProfileCard(
                            icon: AppAssets.lockSvgIcon,
                            title: 'Change Password',
                            onTap: () {
                              Navigator.pushNamed(context,
                                  AppRoutes.userChangePasswordProfileScreen);
                            }),
                        padding20,
                        ProfileCard(
                            icon: AppAssets.logoutSvgIcon,
                            title: 'Log out',
                            onTap: () async {
                              showGeneralDialog(
                                barrierLabel: "Label",
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.6),
                                transitionDuration:
                                    const Duration(milliseconds: 700),
                                context: context,
                                pageBuilder: (context, anim1, anim2) {
                                  return Consumer(
                                    builder: (context, ref, child) {
                                      return const Align(
                                          alignment: Alignment.center,
                                          child: DLogoutDialog());
                                    },
                                  );
                                },
                                transitionBuilder:
                                    (context, anim1, anim2, child) {
                                  return SlideTransition(
                                    position: Tween(
                                            begin: const Offset(1, 0),
                                            end: const Offset(0, 0))
                                        .animate(anim1),
                                    child: child,
                                  );
                                },
                              );
                              // await controller.logout(context: context);
                            }),
                        padding20,
                        ProfileCard(
                            icon: AppAssets.deleteSvgIcon,
                            title: 'Delete Account',
                            onTap: () {
                              showGeneralDialog(
                                barrierLabel: "Label",
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.6),
                                transitionDuration:
                                    const Duration(milliseconds: 700),
                                context: context,
                                pageBuilder: (context, anim1, anim2) {
                                  return Consumer(
                                    builder: (context, ref, child) {
                                      return const Align(
                                          alignment: Alignment.center,
                                          child: DDeleteAccountDialog());
                                    },
                                  );
                                },
                                transitionBuilder:
                                    (context, anim1, anim2, child) {
                                  return SlideTransition(
                                    position: Tween(
                                            begin: const Offset(1, 0),
                                            end: const Offset(0, 0))
                                        .animate(anim1),
                                    child: child,
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _launch() async {
    const url = 'https://www.news-medical.net/condition/Type-1-Diabetes';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

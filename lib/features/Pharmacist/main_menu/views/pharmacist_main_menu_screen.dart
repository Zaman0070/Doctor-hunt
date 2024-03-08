import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/features/Pharmacist/main_menu/controller/p_main_menu_controller.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PharmacistMainMenuScreen extends ConsumerStatefulWidget {
  const PharmacistMainMenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PharmacistMainMenuScreen> createState() =>
      _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<PharmacistMainMenuScreen> {
  /// Here in this method, we are initializing necessary methods
  initialization() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // DynamicLinkService.initDynamicLink(context, ref);
      final authCtr = ref.read(authControllerProvider.notifier);
      UserModel userModel = await authCtr.getCurrentUserInfo();
      final authNotifierProvider = ref.read(authNotifierCtr.notifier);
      authNotifierProvider.setUserModelData(userModel);
      setToHome();
    });
  }

  @override
  void initState() {
    initialization();
    super.initState();
  }

  setToHome() {
    final mainMenuCtr = ref.read(pmainMenuProvider);
    mainMenuCtr.setIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    final mainMenuCtr = ref.watch(pmainMenuProvider);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 80.h,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: BottomNavigationBar(
            fixedColor: MyColors.appColor1,
            currentIndex: mainMenuCtr.index,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.homeSvgIcon,
                  colorFilter: const ColorFilter.mode(
                      MyColors.bodyTextColor, BlendMode.srcIn),
                ),
                activeIcon: CircleAvatar(
                  radius: 22.r,
                  backgroundColor: MyColors.appColor1,
                  child: SvgPicture.asset(
                    AppAssets.homeSvgIcon,
                    colorFilter:
                        const ColorFilter.mode(MyColors.white, BlendMode.srcIn),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.docSvgIcon,
                  colorFilter: const ColorFilter.mode(
                      MyColors.bodyTextColor, BlendMode.srcIn),
                ),
                activeIcon: CircleAvatar(
                  radius: 22.r,
                  backgroundColor: MyColors.appColor1,
                  child: SvgPicture.asset(
                    AppAssets.docSvgIcon,
                    colorFilter:
                        const ColorFilter.mode(MyColors.white, BlendMode.srcIn),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.profileSvgIcon,
                  colorFilter: const ColorFilter.mode(
                      MyColors.bodyTextColor, BlendMode.srcIn),
                ),
                activeIcon: CircleAvatar(
                  radius: 22.r,
                  backgroundColor: MyColors.appColor1,
                  child: SvgPicture.asset(
                    AppAssets.profileSvgIcon,
                    colorFilter:
                        const ColorFilter.mode(MyColors.white, BlendMode.srcIn),
                  ),
                ),
                label: '',
              ),
            ],
            backgroundColor: MyColors.white,
            elevation: 10,
            onTap: (index) {
              mainMenuCtr.setIndex(index);
              mainMenuCtr.pageController.jumpToPage(index);
              // pageController.jumpToPage(tabIndex);
            },
          ),
        ),
      ),
      body: PageView(
        controller: mainMenuCtr.pageController,
        onPageChanged: (v) {
          mainMenuCtr.setIndex(v);
        },
        children: [mainMenuCtr.screens[mainMenuCtr.index]],
      ),
    );
  }
}

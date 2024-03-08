import 'package:doctor_app/commons/common_imports/common_libs.dart';

import '../../utils/constants/assets_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? appbarColor;

  const CustomAppBar({
    Key? key,
    required this.onPressed,
    required this.title,
    this.appbarColor,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appbarColor,
      leading: IconButton(
        key: const Key('outerCustomAppBarIconButton'),
        onPressed: onPressed,
        icon: IconButton(
          key: const Key('innerCustomAppBarIconButton'),
          onPressed: onPressed,
          icon: Image.asset(
            AppAssets.backArrowIcon,
            width: 20.w,
            height: 20.h,
            color: context.whiteColor,
          ),
        ),
      ),
      title: Text(
        title,
        style: getMediumStyle(
            color: context.whiteColor,
            fontSize: MyFonts.size18),
      ),
    );
  }
}

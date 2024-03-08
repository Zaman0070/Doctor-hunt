

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        padding16,
        Text(
          title,
          style: getRegularStyle(
              color: context.bodyTextColor, fontSize: MyFonts.size14),
        ),
        padding4,
        Text(
          value,
          style: getSemiBoldStyle(
              color: context.whiteColor, fontSize: MyFonts.size16),
        ),
      ],
    );
  }
}

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/features/chat/widgets/community_bottom_field.dart';
import 'package:doctor_app/features/chat/widgets/community_chat_list.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunityMessageScreen extends ConsumerWidget {
  const CommunityMessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            AppAssets.backArrowIcon,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            SvgPicture.asset(
              AppAssets.linkSvgIcon,
              width: 36,
              height: 36,
            ),
            padding12,
            Text(
              'Community Chat',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size16),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: const CommunityChatList(),
          ),
          CommunityBottomChatField(),
        ],
      ),
    );
  }
}

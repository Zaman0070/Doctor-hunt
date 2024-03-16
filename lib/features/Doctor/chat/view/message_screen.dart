import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/features/Doctor/chat/widgets/bottom_chat_field.dart';
import 'package:doctor_app/features/Doctor/chat/widgets/chat_list.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  const MobileChatScreen(
      {super.key,
      required this.name,
      required this.uid,
      required this.isGroupChat});

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
        title: StreamBuilder<UserModel>(
            stream:
                ref.watch(authControllerProvider.notifier).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return Row(
                children: [
                  CachedRectangularNetworkImageWidget(
                      image: snapshot.data!.profileImage,
                      width: 36,
                      height: 36,
                      name: name),
                  padding12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: getMediumStyle(
                            color: MyColors.black, fontSize: MyFonts.size16),
                      ),
                      Text(
                        snapshot.data!.isOnline ? 'online' : 'offline',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              );
            }),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(receiverUserId: uid, isGroupChat: isGroupChat),
          ),
          BottomChatField(
            receiverUserId: uid,
            recieverName: name,
            isGroupChat: isGroupChat,
          ),
        ],
      ),
    );
  }
}

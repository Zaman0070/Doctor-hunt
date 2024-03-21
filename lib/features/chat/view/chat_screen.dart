import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/features/User/main_menu/controller/u_main_menu_controller.dart';
import 'package:doctor_app/features/chat/controller/chat_Controller.dart';
import 'package:doctor_app/features/chat/widgets/chat_appbar.dart';
import 'package:doctor_app/models/message/chat_contact.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key, required this.side});
  final String side;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: MasterScafold(
        child: Column(
          children: [
            padding12,
            side == "Patient"
                ? AppBar(
                    backgroundColor: Colors.transparent,
                    leading: Consumer(builder: (context, ref, child) {
                      return IconButton(
                        onPressed: () {
                          final mainMenuCtr = ref.read(usermainMenuProvider);
                          mainMenuCtr.setIndex(0);
                        },
                        icon: Image.asset(
                          AppAssets.backArrowIcon,
                          width: 30.w,
                          height: 30.h,
                        ),
                      );
                    }),
                    title: Text(
                      'Chats',
                      style: getBoldStyle(
                          color: MyColors.black, fontSize: MyFonts.size18),
                    ),
                  )
                : const ChatAppbar(),
            padding8,
            Expanded(
              child: StreamBuilder<List<ChatContact>>(
                  stream: ref.watch(chatControllerProvider).chatContacts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 100),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  'No chats yet! Start a chat With a\nDoctor Consultation',
                                  style: getMediumStyle(
                                      color: MyColors.bodyTextColor,
                                      fontSize: MyFonts.size14)),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(top: 20.h, bottom: 60.h),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var chatContactData = snapshot.data![index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ListTile(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.messageScreen,
                                            arguments: {
                                              'name': chatContactData.name,
                                              'uid': chatContactData.contactId,
                                              'isGroupChat': false,
                                            });
                                      },
                                      title: Text(chatContactData.name,
                                          style: getSemiBoldStyle(
                                              color: MyColors.black,
                                              fontSize: MyFonts.size18)),
                                      subtitle: Text(
                                          chatContactData.lastMessage,
                                          style: getRegularStyle(
                                              color: MyColors.lightGreyColor)),
                                      leading:
                                          CachedRectangularNetworkImageWidget(
                                        height: 48,
                                        width: 48,
                                        image: chatContactData.profilePic,
                                        name: chatContactData.name,
                                      ),
                                      trailing: Text(
                                        DateFormat("h:m a")
                                            .format(chatContactData.timeSent),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: const Divider(
                                        color: MyColors.lightGreyColor),
                                  ),
                                ],
                              );
                            },
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

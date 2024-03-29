import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/core/enums/message_enum.dart';
import 'package:doctor_app/core/provider/message_replay_provider.dart';
import 'package:doctor_app/features/chat/controller/chat_Controller.dart';
import 'package:doctor_app/features/chat/widgets/comm_sender_msg.dart';
import 'package:doctor_app/features/chat/widgets/delete_dialog.dart';
import 'package:doctor_app/features/chat/widgets/my_message_card.dart';
import 'package:doctor_app/models/message/comm_chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CommunityChatList extends ConsumerStatefulWidget {
  const CommunityChatList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<CommunityChatList> {
  final ScrollController _messageController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref
        .read(messageReplyProvider.notifier)
        .update((state) => MessageReply(message, isMe, messageEnum));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CommunityChatModels>>(
        //receiverId is groupId indeed if its group chat
        stream: ref.read(chatControllerProvider).communityChatStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _messageController
                .jumpTo(_messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);

              // to set message seen if receiver sees the msg.
              if (!messageData.isSeen &&
                  messageData.receiverId ==
                      FirebaseAuth.instance.currentUser!.uid) {}
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  delete: () {
                    showGeneralDialog(
                      barrierLabel: "Label",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.6),
                      transitionDuration: const Duration(milliseconds: 700),
                      context: context,
                      pageBuilder: (context, anim1, anim2) {
                        return Consumer(
                          builder: (context, ref, child) {
                            return Align(
                                alignment: Alignment.center,
                                child: DeleteDialog(
                                  id: messageData.messageId,
                                  recieverId: messageData.receiverId,
                                ));
                          },
                        );
                      },
                      transitionBuilder: (context, anim1, anim2, child) {
                        return SlideTransition(
                          position: Tween(
                                  begin: const Offset(1, 0),
                                  end: const Offset(0, 0))
                              .animate(anim1),
                          child: child,
                        );
                      },
                    );
                  },
                  message: messageData.text,
                  date: timeSent,
                  type: messageData.type,
                  repliedText: messageData.repliedMessage,
                  repliedMessageType: messageData.repliedMessageType,
                  username: messageData.repliedTo,
                  isSeen: messageData.isSeen,
                  onLeftSwipe: (detail) {
                    return onMessageSwipe(
                        messageData.text, true, messageData.type);
                  },
                );
              }
              return CommunitySenderMessageCard(
                message: messageData.text,
                date: timeSent,
                type: messageData.type,
                repliedText: messageData.repliedMessage,
                repliedMessageType: messageData.repliedMessageType,
                username: messageData.repliedTo,
                onRightSwipe: (details) {
                  return onMessageSwipe(
                      messageData.text, false, messageData.type);
                },
                userImage: messageData.senderPic,
                userName: messageData.senderName,
              );
            },
          );
        });
  }
}

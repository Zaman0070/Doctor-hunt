import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/core/enums/message_enum.dart';
import 'package:doctor_app/core/provider/message_replay_provider.dart';
import 'package:doctor_app/features/Doctor/chat/controller/chat_Controller.dart';
import 'package:doctor_app/features/Doctor/chat/widgets/my_message_card.dart';
import 'package:doctor_app/features/Doctor/chat/widgets/sender_message_card.dart';
import 'package:doctor_app/models/message/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverUserId;
  final bool isGroupChat;
  const ChatList(
      {required this.isGroupChat, required this.receiverUserId, Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
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
    return StreamBuilder<List<ChatModels>>(
        //receiverId is groupId indeed if its group chat
        stream: widget.isGroupChat
            ? ref
                .read(chatControllerProvider)
                .groupChatStream(widget.receiverUserId)
            : ref
                .read(chatControllerProvider)
                .chatStream(widget.receiverUserId),
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
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                    context, widget.receiverUserId, messageData.messageId);
              }
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
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
              return SenderMessageCard(
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
              );
            },
          );
        });
  }
}

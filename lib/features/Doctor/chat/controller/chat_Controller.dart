import 'dart:io';

import 'package:doctor_app/core/enums/message_enum.dart';
import 'package:doctor_app/core/provider/message_replay_provider.dart';
import 'package:doctor_app/features/Doctor/chat/repository/chat_repository.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/models/message/chat_contact.dart';
import 'package:doctor_app/models/message/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});

  void sendTextMessage(
    BuildContext context,
    String text,
    String receiverUserId,
    bool isGroupChat,
  ) {
    try {
      final messageReply = ref.read(messageReplyProvider);
      ref.read(userDataAuthProvider).whenData(
            (value) => chatRepository.sendTextMessage(
              context: context,
              text: text,
              receiverUserId: receiverUserId,
              senderUser: value!,
              messageReply: messageReply,
              isGroupChat: isGroupChat,
            ),
          );
      ref.read(messageReplyProvider.notifier).update((state) => null);
    } catch (e) {
      print(e.toString() + 'khdfjkdhfjkd');
    }
  }

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContact();
  }

  Stream<List<ChatModels>> chatStream(String receiverUserId) {
    return chatRepository.getChatStream(receiverUserId);
  }

  Stream<List<ChatModels>> groupChatStream(String groupId) {
    return chatRepository.getGroupChatStream(groupId);
  }

  void sendFileMessage(
    BuildContext context,
    File file,
    String receiverUserId,
    MessageEnum messageEnum,
    bool isGroupChat,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    ref
        .read(userDataAuthProvider)
        .whenData((value) => chatRepository.sendFileMessage(
              context: context,
              file: file,
              receiverUserId: receiverUserId,
              senderUserData: value!,
              ref: ref,
              messageEnum: messageEnum,
              messageReply: messageReply,
              isGroupChat: isGroupChat,
            ));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String receiverUserId,
    bool isGroupChat,
  ) {
    //https://giphy.com/gifs/abcnetwork-steve-harvey-judge-judgesteveharveyabc-SwpfkMlXB3FoTbrrF4
    //https://i.giphy.com/media/SwpfkMlXB3FoTbrrF4/200.gif
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newGifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
    final messageReply = ref.read(messageReplyProvider);
    ref
        .read(userDataAuthProvider)
        .whenData((value) => chatRepository.sendGIFMessage(
              context: context,
              gifURL: newGifUrl,
              receiverUserId: receiverUserId,
              senderUser: value!,
              messageReply: messageReply,
              isGroupChat: isGroupChat,
            ));
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) {
    chatRepository.setChatMessageSeen(context, recieverUserId, messageId);
  }
}

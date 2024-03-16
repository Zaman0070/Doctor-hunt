import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/commons/common_providers/common_firebse_storage.dart';
import 'package:doctor_app/commons/common_widgets/show_toast.dart';
import 'package:doctor_app/core/constants/firebase_constants.dart';
import 'package:doctor_app/core/enums/message_enum.dart';
import 'package:doctor_app/core/provider/message_replay_provider.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/models/message/chat_contact.dart';
import 'package:doctor_app/models/message/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  Stream<List<ChatModels>> getChatStream(String receiverUserId) {
    return firestore
        .collection(FirebaseConstants.userCollection)
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<ChatModels> messages = [];
      for (var document in event.docs) {
        messages.add(ChatModels.fromMap(document.data()));
      }
      return messages;
    });
  }

  Stream<List<ChatModels>> getGroupChatStream(String groupId) {
    return firestore
        .collection('groups')
        .doc(groupId)
        .collection('chats')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<ChatModels> messages = [];
      for (var document in event.docs) {
        messages.add(ChatModels.fromMap(document.data()));
      }
      return messages;
    });
  }

  Stream<List<ChatContact>> getChatContact() {
    return firestore
        .collection(FirebaseConstants.userCollection)
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection(FirebaseConstants.userCollection)
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(
          ChatContact(
            name: user.name,
            profilePic: user.profileImage,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel? receiverUserData,
    String text,
    DateTime timeSent,
    String receiverUserId,
    bool isGroupChat,
  ) async {
    //users => receiver id => chats => curr user id => set data

    if (isGroupChat) {
      await firestore.collection('groups').doc(receiverUserId).update({
        'lastMessage': text,
        'timeSent': DateTime.now().microsecondsSinceEpoch,
      });
    } else {
      var receiverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.profileImage,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text,
      );
      await firestore
          .collection(FirebaseConstants.userCollection)
          .doc(receiverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .set(receiverChatContact.toMap());

      //users =>  curr user id=> chats  =>receiver id => set data
      var senderChatContact = ChatContact(
        name: receiverUserData!.name,
        profilePic: receiverUserData.profileImage,
        contactId: receiverUserData.uid,
        timeSent: timeSent,
        lastMessage: text,
      );
      await firestore
          .collection(FirebaseConstants.userCollection)
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverUserId)
          .set(senderChatContact.toMap());
    }
  }

  void _saveMessageToMessageSubcollection(
      {required String receiverUserId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String username,
      required MessageEnum messageType,
      required MessageReply? messageReply,
      required String senderUsername,
      required String? recieverUsername,
      required bool isGroupChat}) async {
    final message = ChatModels(
      senderId: auth.currentUser!.uid,
      receiverId: receiverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: messageReply == null ? '' : messageReply.message,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isME
              ? senderUsername
              : recieverUsername ?? '',
      repliedMessageType:
          messageReply == null ? MessageEnum.text : messageReply.messageEnum,
    );

    if (isGroupChat) {
      //group => group Id =>  -> chat -> message id -> store message
      await firestore
          .collection('groups')
          .doc(receiverUserId)
          .collection('chats')
          .doc(messageId)
          .set(
            message.toMap(),
          );
    } else {
      //user => sender Id => receiver id -> messages -> message id -> store message
      firestore
          .collection(FirebaseConstants.userCollection)
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverUserId)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());
      //user =>receiver id -> sender Id =>  messages -> message id -> store message
      firestore
          .collection(FirebaseConstants.userCollection)
          .doc(receiverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());
    }
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? receiverUserData;
      if (!isGroupChat) {
        var userDataMap = await firestore
            .collection(FirebaseConstants.userCollection)
            .doc(receiverUserId)
            .get();
        receiverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      //users => receiver id => chats => curr user id => set
      _saveDataToContactsSubcollection(
        senderUser,
        receiverUserData,
        text,
        timeSent,
        receiverUserId,
        isGroupChat,
      );

      var messageId = const Uuid().v1();
      _saveMessageToMessageSubcollection(
        receiverUserId: receiverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUser.name,
        messageType: MessageEnum.text,
        messageReply: messageReply,
        senderUsername: senderUser.name,
        recieverUsername: receiverUserData?.name,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      print(e.toString() + 'ndmfndfdb');
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required UserModel senderUserData,
    required ProviderRef ref,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      String fileUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
              'chat/${messageEnum.type}/${senderUserData.uid}/$receiverUserId/$messageId',
              file);

      UserModel? receiverUserData;
      if (!isGroupChat) {
        var userDataMap = await firestore
            .collection(FirebaseConstants.userCollection)
            .doc(receiverUserId)
            .get();
        receiverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      String contactMsg;
      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📹 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }
      _saveDataToContactsSubcollection(
        senderUserData,
        receiverUserData,
        contactMsg,
        timeSent,
        receiverUserId,
        isGroupChat,
      );
      _saveMessageToMessageSubcollection(
          receiverUserId: receiverUserId,
          text: fileUrl,
          timeSent: timeSent,
          messageId: messageId,
          username: senderUserData.name,
          messageType: messageEnum,
          messageReply: messageReply,
          recieverUsername: receiverUserData?.name,
          senderUsername: senderUserData.name,
          isGroupChat: isGroupChat);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void sendGIFMessage({
    required BuildContext context,
    required String gifURL,
    required String receiverUserId,
    required UserModel senderUser,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? receiverUserData;

      if (!isGroupChat) {
        var userDataMap = await firestore
            .collection(FirebaseConstants.userCollection)
            .doc(receiverUserId)
            .get();
        receiverUserData = UserModel.fromMap(userDataMap.data()!);
      }

      //users => receiver id => chats => curr user id => set
      _saveDataToContactsSubcollection(senderUser, receiverUserData, 'GIF',
          timeSent, receiverUserId, isGroupChat);

      var messageId = const Uuid().v1();
      _saveMessageToMessageSubcollection(
        receiverUserId: receiverUserId,
        text: gifURL,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUser.name,
        messageType: MessageEnum.gif,
        messageReply: messageReply,
        recieverUsername: receiverUserData?.name,
        senderUsername: senderUser.name,
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) async {
    try {
      //user => sender Id => receiver id -> messages -> message id -> store message
      firestore
          .collection(FirebaseConstants.userCollection)
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});
      //user =>receiver id -> sender Id =>  messages -> message id -> store message
      firestore
          .collection(FirebaseConstants.userCollection)
          .doc(recieverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

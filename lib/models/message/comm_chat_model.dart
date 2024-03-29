// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:doctor_app/core/enums/message_enum.dart';

class CommunityChatModels {
  final String senderId;
  final String senderName;
  final String senderPic;
  final String text;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String receiverId;
  final MessageEnum type;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;
  CommunityChatModels({
    required this.senderId,
    required this.senderName,
    required this.senderPic,
    required this.text,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.receiverId,
    required this.type,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  CommunityChatModels copyWith({
    String? senderId,
    String? senderName,
    String? senderPic,
    String? text,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
    String? receiverId,
    MessageEnum? type,
    String? repliedMessage,
    String? repliedTo,
    MessageEnum? repliedMessageType,
  }) {
    return CommunityChatModels(
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderPic: senderPic ?? this.senderPic,
      text: text ?? this.text,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      repliedTo: repliedTo ?? this.repliedTo,
      repliedMessageType: repliedMessageType ?? this.repliedMessageType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderName': senderName,
      'senderPic': senderPic,
      'receiverId': receiverId,
      'text': text,
      'type': type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.type,
    };
  }

  factory CommunityChatModels.fromMap(Map<String, dynamic> map) {
    return CommunityChatModels(
        senderId: map['senderId'] as String,
        senderName: map['senderName'] as String,
        senderPic: map['senderPic'] as String,
        receiverId: map['receiverId'] ?? '',
        text: map['text'] ?? '',
        type: (map['type'] as String).toEnum(),
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        messageId: map['messageId'] ?? '',
        isSeen: map['isSeen'] ?? '',
        repliedTo: map['repliedTo'] ?? '',
        repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
        repliedMessage: map['repliedMessage'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory CommunityChatModels.fromJson(String source) =>
      CommunityChatModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommunityChatModels(senderId: $senderId, senderName: $senderName, senderPic: $senderPic, text: $text, timeSent: $timeSent, messageId: $messageId, isSeen: $isSeen, receiverId: $receiverId, type: $type, repliedMessage: $repliedMessage, repliedTo: $repliedTo, repliedMessageType: $repliedMessageType)';
  }

  @override
  bool operator ==(covariant CommunityChatModels other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.senderName == senderName &&
        other.senderPic == senderPic &&
        other.text == text &&
        other.timeSent == timeSent &&
        other.messageId == messageId &&
        other.isSeen == isSeen &&
        other.receiverId == receiverId &&
        other.type == type &&
        other.repliedMessage == repliedMessage &&
        other.repliedTo == repliedTo &&
        other.repliedMessageType == repliedMessageType;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        senderName.hashCode ^
        senderPic.hashCode ^
        text.hashCode ^
        timeSent.hashCode ^
        messageId.hashCode ^
        isSeen.hashCode ^
        receiverId.hashCode ^
        type.hashCode ^
        repliedMessage.hashCode ^
        repliedTo.hashCode ^
        repliedMessageType.hashCode;
  }
}

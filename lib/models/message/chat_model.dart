import 'package:doctor_app/core/enums/message_enum.dart';

class ChatModels {
  final String senderId;
  final String receiverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;
  ChatModels({
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
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

  factory ChatModels.fromMap(Map<String, dynamic> map) {
    return ChatModels(
        senderId: map['senderId'] ?? '',
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
}
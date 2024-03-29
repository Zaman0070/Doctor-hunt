import 'package:doctor_app/core/enums/message_enum.dart';
import 'package:flutter/material.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayTextImageGIF(
      {Key? key, required this.message, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}

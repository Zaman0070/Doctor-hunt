import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/core/enums/message_enum.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/features/chat/controller/chat_Controller.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/models/message/comm_chat_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityBottomChatField extends ConsumerStatefulWidget {
  const CommunityBottomChatField({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CommunityBottomChatField> createState() =>
      _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<CommunityBottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  bool isRecorderInit = false;
  bool isRecording = false;
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    _messageController.dispose();
    isRecorderInit = false;
    super.dispose();
  }

  void sendTextMessage() async {
    if (_messageController.text != '') {
      UserModel userModel = ref.read(authNotifierCtr).userModel!;
      ref.read(chatControllerProvider).sendCommunityTextMessage(
          CommunityChatModels(
              text: _messageController.text,
              senderId: userModel.uid,
              repliedMessage: '',
              repliedTo: '',
              repliedMessageType: MessageEnum.text,
              receiverId: '',
              type: MessageEnum.text,
              timeSent: DateTime.now(),
              messageId: '',
              isSeen: false,
              senderName: userModel.name,
              senderPic: userModel.profileImage));
    }

    setState(() {
      _messageController.text = '';
    });
  }

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppConstants.padding, vertical: 12),
        child: Column(
          children: [
            // isShowMessageReply
            //     ? MessageReplayPreview(recieverName: widget.recieverName)
            //     : const SizedBox.shrink(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: MyColors.lightContainerColor,
                      ),
                    ),
                    child: TextFormField(
                      style: getRegularStyle(
                          color: MyColors.black, fontSize: MyFonts.size16),
                      onTap: () {
                        hideEmojiContainer();
                      },
                      focusNode: focusNode,
                      controller: _messageController,
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          setState(() {
                            isShowSendButton = true;
                          });
                        } else {
                          setState(() {
                            isShowSendButton = false;
                          });
                        }
                      },
                      cursorColor: MyColors.appColor1,
                      decoration: InputDecoration(
                        hintStyle: getRegularStyle(
                            color: MyColors.lightContainerColor,
                            fontSize: MyFonts.size16),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: IconButton(
                            onPressed: toggleEmojiKeyboardContainer,
                            icon: const Icon(
                              Icons.emoji_emotions,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        hintText: 'Type a message!',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(11),
                      ),
                    ),
                  ),
                ),
                padding8,
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 2.0, right: 2, left: 2),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF128C7E),
                    radius: 25,
                    child: GestureDetector(
                      onTap: sendTextMessage,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isShowEmojiContainer
                ? SizedBox(
                    height: 310,
                    child: EmojiPicker(
                      onEmojiSelected: ((category, emoji) {
                        setState(() {
                          _messageController.text =
                              _messageController.text + emoji.emoji;
                        });
                        if (!isShowSendButton) {
                          setState(() {
                            isShowSendButton = true;
                          });
                        }
                      }),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

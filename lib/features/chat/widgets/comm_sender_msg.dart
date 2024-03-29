import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/core/enums/message_enum.dart';
import 'package:doctor_app/features/chat/widgets/display_text_image_gif.dart';
import 'package:swipe_to/swipe_to.dart';

class CommunitySenderMessageCard extends StatelessWidget {
  const CommunitySenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onRightSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
    required this.userName,
    required this.userImage,
  }) : super(key: key);
  final String message;
  final String date;
  final MessageEnum type;
  final Function(DragUpdateDetails details) onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;
  final String userName;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;
    return SwipeTo(
      onRightSwipe: onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            padding12,
            CachedCircularNetworkImageWidget(
              image: userImage,
              size: 40,
              name: userName,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 55,
              ),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: const Color(0xffEBF1F9),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: type == MessageEnum.text
                          ? const EdgeInsets.only(
                              left: 10,
                              right: 16,
                              top: 5,
                              bottom: 10,
                            )
                          : const EdgeInsets.only(
                              left: 5,
                              right: 5,
                              top: 5,
                              bottom: 25,
                            ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isReplying) ...[
                            Text(
                              username,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: MyColors.bgColor2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: DisplayTextImageGIF(
                                message: repliedText,
                                type: repliedMessageType,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                userName,
                                style: getSemiBoldStyle(
                                    color: MyColors.black,
                                    fontSize: MyFonts.size14),
                              ),
                              padding4,
                              Text(
                                date,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              )
                            ],
                          ),
                          DisplayTextImageGIF(
                            message: message,
                            type: type,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

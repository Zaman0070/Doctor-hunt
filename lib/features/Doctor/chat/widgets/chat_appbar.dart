import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/display_first_name.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const ChatAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Hi',
                style: getLightStyle(
                    color: MyColors.black, fontSize: MyFonts.size20),
              ),
              const DisplayFirstName(),
            ],
          ),
          padding2,
          Text(
            'Patients Chats',
            style:
                getBoldStyle(color: MyColors.black, fontSize: MyFonts.size24),
          ),
        ],
      ),
      actions: [
        ref.watch(userStateStreamProvider).when(
          data: (user) {
            return ref.watch(currentAuthUserinfoStreamProvider(user!.uid)).when(
              data: (userModel) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CachedCircularNetworkImageWidget(
                    image: userModel.profileImage,
                    size: 50,
                    name: userModel.name,
                  ),
                );
              },
              error: (err, stack) {
                debugPrintStack(stackTrace: stack);
                debugPrint(err.toString());
                return const SizedBox();
              },
              loading: () {
                return const SizedBox();
              },
            );
          },
          error: (err, stack) {
            debugPrintStack(stackTrace: stack);
            debugPrint(err.toString());
            return const SizedBox();
          },
          loading: () {
            return const SizedBox();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

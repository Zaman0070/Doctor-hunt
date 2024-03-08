// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../common_imports/common_libs.dart';

// class DisplayFirstName extends StatelessWidget {
//   const DisplayFirstName({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (BuildContext context, WidgetRef ref, Widget? child) {
//         return ref.watch(userStateStreamProvider).when(
//           data: (user) {
//             return ref.watch(currentAuthUserinfoStreamProvider(user!.uid)).when(
//               data: (userModel) {
//                 return Text(
//                   ', ${userModel.firstName.capitalize()}',
//                   style: getSemiBoldStyle(
//                       color: context.bodyTextColor, fontSize: MyFonts.size16),
//                 );
//               },
//               error: (err, stack) {
//                 debugPrintStack(stackTrace: stack);
//                 debugPrint(err.toString());
//                 return const SizedBox();
//               },
//               loading: () {
//                 return const SizedBox();
//               },
//             );
//           },
//           error: (err, stack) {
//             debugPrintStack(stackTrace: stack);
//             debugPrint(err.toString());
//             return const SizedBox();
//           },
//           loading: () {
//             return const SizedBox();
//           },
//         );
//       },
//     );
//   }
// }

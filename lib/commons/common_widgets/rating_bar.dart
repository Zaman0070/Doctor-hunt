// ignore: depend_on_referenced_packages
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommonRatingBar extends StatelessWidget {
  const CommonRatingBar({super.key, required this.rating, this.size = 14,required this.ignoreGestures});
  final double rating;
  final double size;
  final bool ignoreGestures;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: ignoreGestures,
      initialRating: rating,
      minRating: 1,
      itemSize: size.r,
      unratedColor: MyColors.lightGreyColor,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
        size: 14,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}

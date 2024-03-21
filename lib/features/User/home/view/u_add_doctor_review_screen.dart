import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/rating_bar.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAddDoctorReviewScreen extends ConsumerStatefulWidget {
  const UserAddDoctorReviewScreen({super.key, required this.doctorModel});
  final DoctorModel doctorModel;

  @override
  ConsumerState<UserAddDoctorReviewScreen> createState() =>
      _UserAddReviewScreenState();
}

class _UserAddReviewScreenState
    extends ConsumerState<UserAddDoctorReviewScreen> {
  final reviewController = TextEditingController();

  double rating = 5;
  double productRating = 0;
  double proRating = 0;

  findRating() async {
    final result = await ref
        .read(homeControllerProvider.notifier)
        .findRatingDoctor(doctorId: widget.doctorModel.doctorId);
    setState(() {
      productRating = result;
      proRating = proRating = (productRating + rating) / 2;

      print(productRating);
    });
  }

  @override
  void initState() {
    findRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    AppAssets.backArrowIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
                title: Text(
                  'Add Review',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size18),
                ),
              ),
              Consumer(builder: (context, ref, child) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppConstants.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        padding18,
                        Center(
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundColor:
                                MyColors.appColor1.withOpacity(0.15),
                            child: CachedCircularNetworkImageWidget(
                              image: widget.doctorModel.imageUrl,
                              size: 105,
                              name: widget.doctorModel.name,
                            ),
                          ),
                        ),
                        padding18,
                        Text(
                            textAlign: TextAlign.center,
                            "How was your experience\n with Dr. ${widget.doctorModel.name}?",
                            style: getBoldStyle(
                                color: MyColors.black,
                                fontSize: MyFonts.size18)),
                        padding12,
                        CommonRatingBar(
                          size: 32,
                          rating: rating,
                          ignoreGestures: false,
                          onChange: (ratings) {
                            setState(() {
                              rating = ratings;
                              proRating = (productRating + rating) / 2;
                            });
                          },
                        ),
                        padding56,
                        CustomButton(
                          onPressed: submitRewiew,
                          buttonText: 'Submit Review',
                          backColor: MyColors.appColor1,
                          buttonHeight: 54.h,
                          buttonWidth: 270.w,
                          borderRadius: 6.r,
                        )
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  submitRewiew() async {
    await ref.watch(homeControllerProvider.notifier).addDoctorReview(
          rating: proRating,
          doctorId: widget.doctorModel.doctorId,
          context: context,
        );
  }
}

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/rating_bar.dart';
import 'package:doctor_app/features/User/pharmacy/controller/u_pharmacy_controller.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/models/review/review_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAddReviewScreen extends ConsumerStatefulWidget {
  const UserAddReviewScreen({super.key, this.productId});
  final String? productId;

  @override
  ConsumerState<UserAddReviewScreen> createState() =>
      _UserAddReviewScreenState();
}

class _UserAddReviewScreenState extends ConsumerState<UserAddReviewScreen> {
  final reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double rating = 5;
  double productRating = 0;
  double proRating = 0;

  findRating() async {
    final result = await ref
        .read(userPharmacyControllerProvider.notifier)
        .findRating(productId: widget.productId!);
    setState(() {
      productRating = result;
      proRating = proRating = (productRating + rating) / 2;
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
                  'Write Review',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size18),
                ),
              ),
              Consumer(builder: (context, ref, child) {
                UserModel userModel = ref.watch(authNotifierCtr).userModel!;

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppConstants.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Please write Overall level of satisfaction with the product",
                            style: getBoldStyle(
                                color: MyColors.black,
                                fontSize: MyFonts.size14)),
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
                        padding18,
                        Text(
                          'Write Your Review',
                          style: getBoldStyle(
                              color: MyColors.black, fontSize: MyFonts.size14),
                        ),
                        padding18,
                        Form(
                          key: _formKey,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                  color:
                                      MyColors.bodyTextColor.withOpacity(0.5),
                                  width: 1),
                            ),
                            height: 160.h,
                            child: TextFormField(
                              validator: (value) => value!.isEmpty
                                  ? 'Please write your review'
                                  : null,
                              controller: reviewController,
                              maxLines: 5,
                              style: getRegularStyle(
                                  color: context.whiteColor,
                                  fontSize: MyFonts.size13),
                              decoration: InputDecoration(
                                hintText: 'Write your review here',
                                hintStyle: getSemiBoldStyle(
                                    color: MyColors.lightContainerColor,
                                    fontSize: MyFonts.size13),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 10.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        padding18,
                        padding100,
                        CustomButton(
                          isLoading: ref.watch(userPharmacyControllerProvider),
                          onPressed: () {
                            submitRewiew(userModel);
                          },
                          buttonText: 'Submit Review',
                          backColor: MyColors.appColor1,
                          buttonHeight: 50.h,
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

  submitRewiew(UserModel userModel) async {
    if (_formKey.currentState!.validate()) {
      await ref.watch(userPharmacyControllerProvider.notifier).addReview(
          rating: proRating,
          model: ReviewModel(
              productId: widget.productId!,
              review: reviewController.text,
              rating: rating,
              createdAt: DateTime.now(),
              userName: userModel.name,
              userImage: userModel.profileImage,
              uid: userModel.uid),
          productId: widget.productId!,
          context: context);
    }
  }
}

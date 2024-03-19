import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class UFindDoctorCard extends ConsumerStatefulWidget {
  const UFindDoctorCard({super.key, required this.model});
  final DoctorModel model;

  @override
  ConsumerState<UFindDoctorCard> createState() => _UFindDoctorCardState();
}

class _UFindDoctorCardState extends ConsumerState<UFindDoctorCard> {
  String calculateAvailabilityStatus() {
    DateTime now = DateTime.now();
    DateTime fromTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        widget.model.from.hour,
        widget.model.from.minute,
        widget.model.from.second);
    DateTime toTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        widget.model.to.hour,
        widget.model.to.minute,
        widget.model.to.second);

    if (now.isBefore(fromTime)) {
      return "Today available At ${DateFormat('hh:mm a').format(widget.model.from)}";
    } else if (now.isAfter(toTime)) {
      return "Next availability on  ${DateFormat('ddd, yy MMM  hh:mm a').format(widget.model.from)}";
    } else {
      return "Available";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          Container(
            height: 170.h,
            width: 335.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: MyColors.white,
              boxShadow: [
                BoxShadow(
                  color: MyColors.lightGreyColor.withOpacity(0.4),
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CachedRectangularNetworkImageWidget(
                          name: widget.model.name,
                          image: widget.model.imageUrl,
                          width: 92,
                          height: 87),
                      padding12,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.model.name,
                              style: getMediumStyle(
                                  color: MyColors.black,
                                  fontSize: MyFonts.size18)),
                          padding2,
                          Text(widget.model.speciality,
                              style: getRegularStyle(
                                  color: MyColors.appColor1,
                                  fontSize: MyFonts.size13)),
                          padding2,
                          Text(
                              '${widget.model.totalExperience} years Experience',
                              style: getLightStyle(
                                  color: MyColors.black,
                                  fontSize: MyFonts.size12)),
                        ],
                      ),
                    ],
                  ),
                  padding12,
                  Text(
                    'Next Available',
                    style: getMediumStyle(
                        color: MyColors.appColor1, fontSize: MyFonts.size13),
                  ),
                  // i want if check time is avaiable the show avail
                  padding4,
                  Text(
                    calculateAvailabilityStatus().toString(),
                    style: getLightStyle(
                      color: MyColors.bodyTextColor,
                      fontSize: MyFonts.size12,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 25,
            child: CustomButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, AppRoutes.userSelectTimeDoctorScreen,
                    arguments: {'model': widget.model});
              },
              buttonText: 'Book Now',
              buttonHeight: 30.h,
              buttonWidth: 112.w,
              backColor: MyColors.appColor1,
              borderRadius: 4.r,
              fontSize: MyFonts.size12,
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: IconButton(
                onPressed: () {
                  ref.watch(homeControllerProvider.notifier).likeDislikeDoctor(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      docId: widget.model.doctorId);
                },
                icon: Icon(
                  widget.model.favorite
                          .contains(FirebaseAuth.instance.currentUser!.uid)
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: widget.model.favorite
                          .contains(FirebaseAuth.instance.currentUser!.uid)
                      ? MyColors.red
                      : MyColors.lightContainerColor,
                  size: 24.r,
                )),
          ),
        ],
      ),
    );
  }
}

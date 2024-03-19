import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';

class UDoctorDetailCard extends ConsumerStatefulWidget {
  const UDoctorDetailCard({super.key, required this.model});
  final DoctorModel model;

  @override
  ConsumerState<UDoctorDetailCard> createState() => _UFindDoctorCardState();
}

class _UFindDoctorCardState extends ConsumerState<UDoctorDetailCard> {
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
                  Center(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.messageScreen,
                            arguments: {
                              "isGroupChat": false,
                              "name": widget.model.name,
                              "uid": widget.model.doctorId,
                            });
                      },
                      buttonText: 'Chat with Doctor',
                      buttonHeight: 32.h,
                      buttonWidth: 140.w,
                      backColor: MyColors.appColor1,
                      borderRadius: 4.r,
                      fontSize: MyFonts.size12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

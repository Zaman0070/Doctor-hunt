import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/features/User/home/widgets/u_select_time_doctor_card.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class UserSelectTimeDoctorScreen extends ConsumerStatefulWidget {
  const UserSelectTimeDoctorScreen({super.key, required this.model});
  final DoctorModel model;

  @override
  ConsumerState<UserSelectTimeDoctorScreen> createState() =>
      _UserFindDoctorScreenState();
}

class _UserFindDoctorScreenState
    extends ConsumerState<UserSelectTimeDoctorScreen> {
  bool isExistConverstion = false;
  @override
  void initState() {
    initialization();
    super.initState();
  }

  initialization() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref
          .watch(homeControllerProvider.notifier)
          .checkExistConverstion(doctorId: widget.model.doctorId)
          .listen((event) {
        setState(() {
          isExistConverstion = event;
        });
      });
    });
  }

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
      return "Next availability\non ${DateFormat('ddd, yy MMM  hh:mm a').format(widget.model.from)}";
    } else {
      return "Available";
    }
  }

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
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
              'Select Time',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                USelectTimeDoctorCard(model: widget.model),
                padding12,
                Text(
                  'Previous Consultations',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size16),
                ),
                Consumer(builder: (context, ref, child) {
                  return Text(
                      isExistConverstion
                          ? 'You have a previous consultation with this doctor'
                          : 'You have no previous consultation with this doctor',
                      style: getMediumStyle(
                          color: isExistConverstion
                              ? MyColors.green
                              : MyColors.red,
                          fontSize: MyFonts.size14));
                }),
                padding32,
                Center(
                  child: CustomButton(
                      buttonHeight: 54.h,
                      buttonWidth: 306.w,
                      borderRadius: 6.r,
                      backColor: MyColors.appColor1,
                      onPressed: () {},
                      fontSize: MyFonts.size14,
                      buttonText: calculateAvailabilityStatus()),
                ),
                padding12,
                Center(
                  child: Text(
                    'OR',
                    style: getRegularStyle(
                        color: MyColors.bodyTextColor,
                        fontSize: MyFonts.size14),
                  ),
                ),
                padding12,
                Center(
                  child: CustomButton(
                      buttonHeight: 54.h,
                      buttonWidth: 306.w,
                      borderRadius: 6.r,
                      borderColor: MyColors.appColor1,
                      backColor: MyColors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.messageScreen,
                            arguments: {
                              "isGroupChat": false,
                              "name": widget.model.name,
                              "uid": widget.model.doctorId,
                            });
                      },
                      textColor: MyColors.appColor1,
                      buttonText: 'Contact Clinic'),
                ),
                Center(
                  child: CustomButton(
                      buttonHeight: 54.h,
                      buttonWidth: 306.w,
                      borderRadius: 6.r,
                      borderColor: MyColors.appColor1,
                      backColor: MyColors.white,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.userAddDoctorReviewScreen,
                            arguments: {
                              "doctorModel": widget.model,
                            });
                      },
                      textColor: MyColors.appColor1,
                      buttonText: 'Add Review'),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

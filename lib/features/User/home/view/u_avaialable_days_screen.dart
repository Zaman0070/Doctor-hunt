import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/available_card.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/features/Doctor/profile/controller/profile_controller.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class UAvaiableDayScreen extends ConsumerStatefulWidget {
  const UAvaiableDayScreen({super.key, required this.model});
  final DoctorModel model;

  @override
  ConsumerState<UAvaiableDayScreen> createState() =>
      _UserFindDoctorScreenState();
}

class _UserFindDoctorScreenState extends ConsumerState<UAvaiableDayScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(dprofileNotifierCtr);

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
              'Doctor Availability',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Availabity Days',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size16),
                ),
                padding12,
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.model.avaialbleDays.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: AvailableCards(
                          isChecked: true,
                          onTap: () {},
                          title: controller.availableDays[index],
                        ),
                      );
                    }),
                padding18,
                Text(
                  'Availabity Time',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size16),
                ),
                padding12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: MyColors.lightGreyColor)),
                      child: Center(
                          child: Text(
                        'From: ${DateFormat("hh : mm a").format(widget.model.from)}',
                        style: getMediumStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size15),
                      )),
                    ),
                    Container(
                      height: 45.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: MyColors.lightGreyColor)),
                      child: Center(
                          child: Text(
                        'To: ${DateFormat("hh : mm a").format(widget.model.to)}',
                        style: getMediumStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size15),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

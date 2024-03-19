import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/features/User/home/widgets/u_doctor_detail_card.dart';
import 'package:doctor_app/models/doctor/doctor_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDoctorDetailScreen extends ConsumerStatefulWidget {
  const UserDoctorDetailScreen({super.key, required this.model});
  final DoctorModel model;

  @override
  ConsumerState<UserDoctorDetailScreen> createState() =>
      _UserFindDoctorScreenState();
}

class _UserFindDoctorScreenState extends ConsumerState<UserDoctorDetailScreen> {
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
              'Doctor Details',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UDoctorDetailCard(model: widget.model),
                padding12,
                Text(
                  'About details',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size18),
                ),
                padding8,
                Text(
                  widget.model.details,
                  style: getRegularStyle(
                      color: MyColors.bodyTextColor, fontSize: MyFonts.size13),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

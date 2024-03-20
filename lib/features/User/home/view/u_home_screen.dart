import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/commons/common_widgets/u_custom_appbar.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/features/User/home/widgets/offering_widget.dart';
import 'package:doctor_app/features/User/home/widgets/popular_doctor.dart';
import 'package:doctor_app/features/User/home/widgets/u_home_banner.dart';
import 'package:doctor_app/features/User/home/widgets/u_record_card.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_svg/svg.dart';

class UserHomeScreen extends ConsumerStatefulWidget {
  const UserHomeScreen({super.key});

  @override
  ConsumerState<UserHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends ConsumerState<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScafold(
      child: Column(
        children: [
          UCustomAppBar(
            title: 'Find Your Doctor',
            onPress: () {
              Navigator.pushNamed(context, AppRoutes.userFindDoctorScreen);
            },
            onMenuPress: () {
              Navigator.pushNamed(context, AppRoutes.userProfileScreen);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding12,
                  const OfferingWidget(),
                  const UHomeBannerSection(),
                  const PopularDoctorWidget(),
                  Padding(
                    padding: EdgeInsets.all(AppConstants.padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Record History Here',
                          style: getMediumStyle(
                              color: MyColors.black, fontSize: MyFonts.size18),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.userRecordScreen);
                          },
                          child: Row(
                            children: [
                              Text(
                                'See all',
                                style: getLightStyle(
                                    color: MyColors.bodyTextColor,
                                    fontSize: MyFonts.size12),
                              ),
                              padding6,
                              SvgPicture.asset(
                                AppAssets.farArrowSvgIcon,
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer(builder: (context, ref, child) {
                    final recordStream = ref.watch(
                        watchAllMedRecordStreamProvider(
                            FirebaseAuth.instance.currentUser!.uid));
                    return recordStream.when(
                      data: (record) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(
                              bottom: 150.h, left: 18, right: 18),
                          itemCount: record.length,
                          itemBuilder: (context, index) {
                            final data = record[index];
                            return InkWell(
                                onTap: () => Navigator.pushNamed(context,
                                        AppRoutes.userRecorDetailScreen,
                                        arguments: {
                                          'model': data,
                                        }),
                                child: URecordCard(model: data));
                          },
                        );
                      },
                      error: (error, stackTrace) => Center(
                        child: Text('Error: $error'),
                      ),
                      loading: () {
                        return const Loader();
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/features/Pharmacist/main_menu/controller/p_main_menu_controller.dart';
import 'package:doctor_app/features/Pharmacist/profile/widgets/detail_card.dart';
import 'package:doctor_app/features/auth/controller/auth_controller.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/models/auth/user_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter/cupertino.dart';

class PProfileScreen extends ConsumerWidget {
  const PProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: Consumer(builder: (context, ref, child) {
          return IconButton(
            onPressed: () {
              final mainMenuCtr = ref.read(pmainMenuProvider);
              mainMenuCtr.setIndex(0);
            },
            icon: Image.asset(
              AppAssets.backArrowIcon,
              width: 30.w,
              height: 30.h,
            ),
          );
        }),
        title: Text(
          'Pharmacist Profile',
          style:
              getBoldStyle(color: MyColors.appColor1, fontSize: MyFonts.size18),
        ),
      ),
      body: MasterScafold(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              UserModel userModel = ref.watch(authNotifierCtr).userModel!;
              final pharmacyInfo = ref.watch(currentPharmacyInfoStreamProvider);
              return pharmacyInfo.when(data: (pharmacyInfo) {
                return Padding(
                  padding: EdgeInsets.all(AppConstants.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          padding16,
                          Row(
                            children: [
                              Container(
                                height: 110.h,
                                width: 110.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: MyColors.appColor1),
                                ),
                                child: CachedRectangularNetworkImageWidget(
                                  image: userModel.profileImage,
                                  name: userModel.name,
                                  width: 110,
                                  height: 110,
                                ),
                              ),
                              SizedBox(width: 18.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailCard(
                                    title: 'Owner Name',
                                    value: userModel.name,
                                  ),
                                  padding6,
                                  DetailCard(
                                    title: 'Pharmacy Name',
                                    value: pharmacyInfo.pharmacyName,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      padding28,
                      DetailCard(
                        title: 'Email ID',
                        value: userModel.email,
                      ),
                      padding6,
                      DetailCard(
                          title: 'Open Time . Close Time',
                          value:
                              '${pharmacyInfo.pharmacyOpenTime} - ${pharmacyInfo.pharmacyCloseTime}'),
                      padding6,
                      DetailCard(
                        title: 'Phone Numer',
                        value: pharmacyInfo.pharmacyPhone,
                      ),
                      padding6,
                      DetailCard(
                        title: 'Address',
                        value: pharmacyInfo.pharmacyAddress,
                      ),
                      padding56,
                      Center(
                        child: CustomButton(
                          borderRadius: 6.r,
                          backColor: MyColors.appColor1,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.userProfileScreen,
                                arguments: {
                                  'userModel': userModel,
                                  'pharmacyInfoModel': pharmacyInfo
                                });
                          },
                          buttonText: 'Edit',
                          buttonHeight: 35.h,
                          buttonWidth: 164.w,
                        ),
                      ),
                    ],
                  ),
                );
              }, loading: () {
                return const Center(child: CupertinoActivityIndicator());
              }, error: (error, stack) {
                return Center(child: Text(error.toString()));
              });
            },
          ),
        ),
      ),
    );
  }
}

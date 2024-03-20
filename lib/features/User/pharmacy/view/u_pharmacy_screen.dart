import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/commons/common_widgets/u_custom_appbar.dart';
import 'package:doctor_app/features/User/pharmacy/controller/u_pharmacy_controller.dart';
import 'package:doctor_app/features/User/pharmacy/widgets/u_product_card.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_svg/svg.dart';

class UserPharmacyScreen extends ConsumerStatefulWidget {
  const UserPharmacyScreen({super.key});

  @override
  ConsumerState<UserPharmacyScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends ConsumerState<UserPharmacyScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScafold(
      child: Column(
        children: [
          UCustomAppBar(
            title: 'Find Your Medicine',
            onPress: () {
              Navigator.pushNamed(context, AppRoutes.pharmacyFindMedScreen);
            },
            onMenuPress: () {
              Navigator.pushNamed(context, AppRoutes.userProfileScreen);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(AppConstants.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Products',
                          style: getMediumStyle(
                              color: MyColors.black, fontSize: MyFonts.size18),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.pharmacyFindMedScreen);
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
                    padding18,
                    Consumer(builder: (context, ref, child) {
                      final products = ref.watch(watchAllProducts);
                      return products.when(data: (products) {
                        return GridView.builder(
                            padding: const EdgeInsets.only(bottom: 100),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 260.h),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return UProductCard(
                                model: products[index],
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.userOrderScreen,
                                      arguments: {
                                        "productModel": products[index]
                                      });
                                },
                              );
                            });
                      }, loading: () {
                        return const Center(
                          child: Loader(),
                        );
                      }, error: (error, stackTrace) {
                        return Center(
                          child: Text('Error: $error'),
                        );
                      });
                    })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

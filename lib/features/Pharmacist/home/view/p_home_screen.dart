import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/features/Pharmacist/home/controller/pharmacy_controller.dart';
import 'package:doctor_app/features/Pharmacist/home/widgets/p_delete_product_dialog.dart';
import 'package:doctor_app/features/Pharmacist/home/widgets/p_product_card.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PHomeScreen extends StatelessWidget {
  const PHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 90.h),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: MyColors.appColor1,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.pharmacyAddProductScreen,
                  arguments: {
                    'type': 'add',
                    'model': null,
                  });
            },
            child: SvgPicture.asset(AppAssets.addSvgIcon),
          ),
        ),
        body: MasterScafold(
            child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padding16,
                Text(
                  'Products List',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size18),
                ),
                padding12,
                Consumer(builder: (context, ref, child) {
                  final products = ref.watch(watchAllProductByIdProvider(
                      FirebaseAuth.instance.currentUser!.uid));
                  return products.when(data: (products) {
                    return Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 305.h),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return PProductCard(
                              model: products[index],
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.pharmacyAddProductScreen,
                                    arguments: {
                                      'type': 'edit',
                                      'model': products[index],
                                    });
                              },
                              delete: () {
                                showGeneralDialog(
                                  barrierLabel: "Label",
                                  barrierDismissible: true,
                                  barrierColor: Colors.black.withOpacity(0.6),
                                  transitionDuration:
                                      const Duration(milliseconds: 700),
                                  context: context,
                                  pageBuilder: (context, anim1, anim2) {
                                    return Consumer(
                                      builder: (context, ref, child) {
                                        return Align(
                                            alignment: Alignment.center,
                                            child: PProductDeleteDialog(
                                              id: products[index].productId!,
                                            ));
                                      },
                                    );
                                  },
                                  transitionBuilder:
                                      (context, anim1, anim2, child) {
                                    return SlideTransition(
                                      position: Tween(
                                              begin: const Offset(1, 0),
                                              end: const Offset(0, 0))
                                          .animate(anim1),
                                      child: child,
                                    );
                                  },
                                );
                              },
                            );
                          }),
                    );
                  }, loading: () {
                    return const Center(
                      child: CupertinoActivityIndicator(),
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
        )));
  }
}

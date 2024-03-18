import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/features/User/pharmacy/controller/u_pharmacy_controller.dart';
import 'package:doctor_app/features/User/profile/widgets/your_orders_widget.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class YourOrderScreen extends StatelessWidget {
  const YourOrderScreen({super.key});

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
                'Your Orders',
                style: getMediumStyle(
                    color: MyColors.black, fontSize: MyFonts.size18),
              ),
            ),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final orders = ref.watch(yourOrderStreamProvider);
                return orders.when(data: (order) {
                  return Padding(
                    padding: EdgeInsets.all(AppConstants.padding),
                    child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 100),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 260.h),
                        itemCount: order.length,
                        itemBuilder: (context, index) {
                          return UYourOrderWidget(
                            model: order[index],
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.userAddReviewScreen,
                                  arguments: {
                                    'productId': order[index].productId
                                  });
                            },
                          );
                        }),
                  );
                }, loading: () {
                  return const Center(
                    child: Loader(),
                  );
                }, error: (error, stackTrace) {
                  return Center(
                    child: Text('Error: $error'),
                  );
                });
              }),
            )
          ],
        ),
      ),
    );
  }
}

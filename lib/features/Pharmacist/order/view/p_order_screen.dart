import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/features/Pharmacist/main_menu/controller/p_main_menu_controller.dart';
import 'package:doctor_app/features/Pharmacist/order/widgets/p_all_order_widget.dart';
import 'package:doctor_app/features/Pharmacist/order/widgets/p_canceled_oder_widget.dart';
import 'package:doctor_app/features/Pharmacist/order/widgets/p_delivered_oder_widget.dart';
import 'package:doctor_app/features/Pharmacist/order/widgets/p_processing_order_widget.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PharmistOrderScreen extends ConsumerStatefulWidget {
  const PharmistOrderScreen({super.key});

  @override
  ConsumerState<PharmistOrderScreen> createState() => _OrderScreeState();
}

class _OrderScreeState extends ConsumerState<PharmistOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: MasterScafold(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: Consumer(builder: (context, ref, clid) {
                  return IconButton(
                    onPressed: () {
                      ref.watch(pmainMenuProvider).setIndex(0);
                    },
                    icon: Image.asset(
                      AppAssets.backArrowIcon,
                      width: 30.w,
                      height: 30.h,
                    ),
                  );
                }),
                title: Text(
                  'Orders',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size18),
                ),
              ),
              padding18,
              Expanded(
                child: Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r)),
                      boxShadow: const [
                        BoxShadow(
                          color: MyColors.lightContainerColor,
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0, 0),
                        )
                      ]),
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: MyColors.appColor1,
                        indicatorColor: MyColors.appColor1,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: getSemiBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size12),
                        unselectedLabelStyle: getMediumStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size12),
                        tabs: const [
                          Tab(text: 'All Orders'),
                          Tab(text: 'Processing'),
                          Tab(text: 'Delivered'),
                          Tab(text: 'Cancelled'),
                        ],
                      ),
                      const Expanded(
                          child: TabBarView(children: [
                        PAllOrderWidget(),
                        PProcessingOrderWidget(),
                        PDeliveredOrderWidget(),
                        PCanncelledOrderWidget(),
                      ]))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

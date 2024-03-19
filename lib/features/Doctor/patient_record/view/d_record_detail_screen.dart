import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:doctor_app/models/med_record/med_record_model.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:intl/intl.dart';

class DoctorRecordDetailScreen extends StatefulWidget {
  const DoctorRecordDetailScreen({super.key, required this.model});
  final MedRecordModel model;

  @override
  State<DoctorRecordDetailScreen> createState() =>
      _DoctorRecordDetailScreenState();
}

class _DoctorRecordDetailScreenState extends State<DoctorRecordDetailScreen> {
  List<String> recordImage = [
    AppAssets.report,
    AppAssets.pres,
  ];

  List<String> titleRecor = [
    'Report',
    'Prescription',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                'Records details',
                style: getMediumStyle(
                    color: MyColors.black, fontSize: MyFonts.size18),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// multipale image show use for loop
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var image in widget.model.recImageUrl!)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.viewImageScreen,
                                    arguments: {'imgUrl': image});
                              },
                              child: CachedRectangularNetworkImageWidget(
                                  image: image, width: 100, height: 125),
                            ),
                          )
                      ],
                    ),
                  ),
                  padding24,
                  Text(
                    'Record for',
                    style: getRegularStyle(
                        color: MyColors.black, fontSize: MyFonts.size16),
                  ),
                  padding8,
                  Text(
                    widget.model.userName,
                    style: getMediumStyle(
                        color: MyColors.appColor1, fontSize: MyFonts.size18),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                        color: MyColors.bluishTextColor.withOpacity(0.3)),
                  ),
                  Text(
                    'Record type',
                    style: getRegularStyle(
                        color: MyColors.black, fontSize: MyFonts.size16),
                  ),
                  padding18,
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                        itemCount: recordImage.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  recordImage[index],
                                  height: 22.h,
                                  width: 17.w,
                                  color:
                                      widget.model.recType == titleRecor[index]
                                          ? MyColors.appColor1
                                          : MyColors.bodyTextColor,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  titleRecor[index],
                                  style: getRegularStyle(
                                      color: widget.model.recType ==
                                              titleRecor[index]
                                          ? MyColors.appColor1
                                          : MyColors.bodyTextColor,
                                      fontSize: MyFonts.size13),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                        color: MyColors.bluishTextColor.withOpacity(0.3)),
                  ),
                  Text(
                    'Record created on',
                    style: getRegularStyle(
                        color: MyColors.black, fontSize: MyFonts.size16),
                  ),
                  padding8,
                  Text(
                    DateFormat('dd MMM, yyyy')
                        .format(widget.model.recCreatedOn),
                    style: getMediumStyle(
                        color: MyColors.appColor1, fontSize: MyFonts.size18),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                        color: MyColors.bluishTextColor.withOpacity(0.3)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

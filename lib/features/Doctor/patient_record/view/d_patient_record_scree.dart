import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/loader.dart';
import 'package:doctor_app/features/Doctor/main_menu/controller/d_main_menu_controller.dart';
import 'package:doctor_app/features/Doctor/patient_record/controller/patient_record_controller.dart';
import 'package:doctor_app/features/Doctor/patient_record/widgets/d_record_card.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class DoctorPatientRecordScreen extends ConsumerStatefulWidget {
  const DoctorPatientRecordScreen({super.key});

  @override
  ConsumerState<DoctorPatientRecordScreen> createState() =>
      _UserFindDoctorScreenState();
}

class _UserFindDoctorScreenState
    extends ConsumerState<DoctorPatientRecordScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
          child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leading: Consumer(builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  ref.read(dmainMenuProvider).setIndex(0);
                },
                icon: Image.asset(
                  AppAssets.backArrowIcon,
                  width: 30.w,
                  height: 30.h,
                ),
              );
            }),
            title: Text(
              'Patients Records',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Consumer(builder: (context, ref, child) {
                final recordStream = ref.watch(
                    watchAllPatientRecordStreamProvider(
                        FirebaseAuth.instance.currentUser!.uid));
                return recordStream.when(
                  data: (record) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 100.h),
                      itemCount: record.length,
                      itemBuilder: (context, index) {
                        final data = record[index];
                        return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.doctorRecordDetailScreen,
                                  arguments: {
                                    'model': data,
                                  });
                            },
                            child: DRecordCard(model: data));
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
            ),
          ),
        ],
      )),
    );
  }
}

import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/d_custom_appbar.dart';
import 'package:doctor_app/features/Doctor/home/widgets/d_offering_widget.dart';
import 'package:doctor_app/features/User/home/widgets/u_home_banner.dart';

class DoctorHomeScreen extends ConsumerStatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  ConsumerState<DoctorHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends ConsumerState<DoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScafold(
      child: Column(
        children: [
          const DCustomAppBar(
            title: 'Welcome to Doctor',
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding12,
                  const DOfferingWidget(),
                  const UHomeBannerSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

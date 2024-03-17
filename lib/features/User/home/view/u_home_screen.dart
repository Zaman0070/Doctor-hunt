import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/u_custom_appbar.dart';
import 'package:doctor_app/features/User/home/widgets/offering_widget.dart';
import 'package:doctor_app/features/User/home/widgets/popular_doctor.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHomeScreen extends ConsumerStatefulWidget {
  const UserHomeScreen({super.key});

  @override
  ConsumerState<UserHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends ConsumerState<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScafold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            padding12,
            const OfferingWidget(),
            const PopularDoctorWidget(),
          ],
        ),
      ),
    );
  }
}

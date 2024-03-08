import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/u_custom_appbar.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientHomeScreen extends ConsumerStatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  ConsumerState<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends ConsumerState<PatientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  MasterScafold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UCustomAppBar(
              onPress: () {},
            ),
            padding12,
            Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We are offering multiple consultation modes',
                    style: getMediumStyle(
                        color: MyColors.black, fontSize: MyFonts.size13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

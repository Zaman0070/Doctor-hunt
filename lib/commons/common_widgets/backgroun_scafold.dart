import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class MasterScafold extends StatelessWidget {
  const MasterScafold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
          color: MyColors.white,
          image: DecorationImage(
            image: AssetImage(AppAssets.bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
    
  }
}

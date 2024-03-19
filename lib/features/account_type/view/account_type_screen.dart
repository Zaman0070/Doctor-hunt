import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/features/account_type/widget/account_type_card.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 41.h,
              ),
              Text(
                'Type of Account',
                style: getSemiBoldStyle(
                    color: MyColors.black, fontSize: MyFonts.size24),
              ),
              SizedBox(
                height: 44.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTypeCard(
                    image: AppAssets.pateintSvgIcon,
                    title: 'Patient',
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    selectIndex: index,
                    index: 0,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  AccountTypeCard(
                    image: AppAssets.doctorSvgIcon,
                    title: 'Doctor',
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    selectIndex: index,
                    index: 1,
                  ),
                ],
              ),
              padding18,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccountTypeCard(
                    image: AppAssets.pharmacySvgIcon,
                    title: 'Pharmacist',
                    onTap: () {
                      setState(() {
                        index = 2;
                      });
                    },
                    selectIndex: index,
                    index: 2,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(width: 134.w)
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signInScreen,
                        arguments: {
                          'accountType': index == 0
                              ? 'Patient'
                              : index == 1
                                  ? 'Doctor'
                                  : 'Pharmacist'
                        });
                  },
                  buttonText: 'Done',
                  fontSize: MyFonts.size18,
                  borderRadius: 12,
                  backColor: MyColors.appColor1,
                ),
              ),
              SizedBox(
                height: 55.h,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

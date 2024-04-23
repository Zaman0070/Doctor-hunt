import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';

class AvailabiltyScreen extends ConsumerStatefulWidget {
  const AvailabiltyScreen({super.key});

  @override
  ConsumerState<AvailabiltyScreen> createState() => _AvailabiltyScreenState();
}

class _AvailabiltyScreenState extends ConsumerState<AvailabiltyScreen> {
  @override
  Widget build(BuildContext context) {
    final ctr = ref.watch(authNotifierCtr);
    return Scaffold(
      body: SafeArea(
        child: MasterScafold(
            child: Padding(
          padding: EdgeInsets.all(AppConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              padding40,
              Center(
                child: Text(
                  'Availability',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size24),
                ),
              ),
              padding40,
              AvailableCard(
                name: 'Monday',
                onPressed: () {
                  ref.read(authNotifierCtr).addDays('Monday');
                },
              ),
              padding18,
              AvailableCard(
                name: 'Tuesday',
                onPressed: () {
                  ref.read(authNotifierCtr).addDays('Tuesday');
                },
              ),
              padding18,
              AvailableCard(
                name: 'Wednesday',
                onPressed: () {
                  ref.read(authNotifierCtr).addDays('Wednesday');
                },
              ),
              padding18,
              AvailableCard(
                name: 'Thursday',
                onPressed: () {
                  ref.read(authNotifierCtr).addDays('Thursday');
                },
              ),
              padding18,
              AvailableCard(
                name: 'Friday',
                onPressed: () {
                  ref.read(authNotifierCtr).addDays('Friday');
                },
              ),
              padding18,
              AvailableCard(
                name: 'Saturday',
                onPressed: () {
                  ref.read(authNotifierCtr).addDays('Saturday');
                },
              ),
              padding18,
              AvailableCard(
                name: 'Sunday',
                onPressed: () {
                  ref.read(authNotifierCtr).addDays('Sunday');
                },
              ),
              padding40,
              Text(
                'Choose Time',
                style: getSemiBoldStyle(
                    color: MyColors.black, fontSize: MyFonts.size16),
              ),
              padding16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      ctr.selectTimeFrom(context);
                    },
                    child: Container(
                      height: 45.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: MyColors.lightGreyColor)),
                      child: Center(
                          child: Text(
                        'From: ${ctr.from.format(context)}',
                        style: getMediumStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size15),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ctr.selectTimeTo(context);
                    },
                    child: Container(
                      height: 45.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: MyColors.lightGreyColor)),
                      child: Center(
                          child: Text(
                        'To: ${ctr.to.format(context)}',
                        style: getMediumStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size15),
                      )),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Center(
                  child: CustomButton(
                    buttonWidth: 295.w,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.specialityScreen,
                          arguments: {
                            'availableDays':
                                ref.watch(authNotifierCtr).availableDays,
                            'from': ctr.from,
                            'to': ctr.to,
                          });
                    },
                    buttonText: 'Done',
                    borderRadius: 12.h,
                    backColor: MyColors.appColor1,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class AvailableCard extends ConsumerWidget {
  const AvailableCard({super.key, required this.name, required this.onPressed});
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            height: 20.h,
            width: 20.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(
                  color: ref.watch(authNotifierCtr).availableDays.contains(name)
                      ? MyColors.appColor1
                      : MyColors.bodyTextColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundColor:
                    ref.watch(authNotifierCtr).availableDays.contains(name)
                        ? MyColors.appColor1
                        : Colors.transparent,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Text(
            name,
            style: getMediumStyle(
                color: MyColors.bodyTextColor, fontSize: MyFonts.size18),
          ),
        ],
      ),
    );
  }
}

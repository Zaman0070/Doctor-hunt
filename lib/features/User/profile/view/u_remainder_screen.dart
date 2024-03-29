import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/features/User/profile/controller/profile_controller.dart';
import 'package:doctor_app/firebase_messaging/service/notification_service.dart';
import 'package:doctor_app/services/shar_pref_servies.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:load_switch/load_switch.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

class UserRemainderScreen extends ConsumerStatefulWidget {
  const UserRemainderScreen({super.key});

  @override
  ConsumerState<UserRemainderScreen> createState() =>
      _UserRemainderScreenState();
}

class _UserRemainderScreenState extends ConsumerState<UserRemainderScreen> {
  SharePref sharePre = SharePref();
  bool isEnable = false;
  int mHour = 0;
  int mMinute = 0;
  int eHour = 0;
  int eMinute = 0;
  TimeOfDay? morningTime;
  TimeOfDay? eveningTime;

  checkEnable() async {
    isEnable = await sharePre.getRemainder('isEnable');
    setState(() {});
  }

  void getScheduledTime() async {
    final List<String> morning = await sharePre.getMorningTime('morning');
    final List<String> evening = await sharePre.getEveningTime('evening');

    setState(() {
      mHour = int.parse(morning[0]);
      mMinute = int.parse(morning[1]);
      eHour = int.parse(evening[0]);
      eMinute = int.parse(evening[1]);
      morningTime = TimeOfDay(hour: mHour, minute: mMinute);
      eveningTime = TimeOfDay(hour: eHour, minute: eMinute);
    });
  }

  @override
  void initState() {
    LocalNotificationService.requestPermission(Permission.notification);
    LocalNotificationService.initialize();
    tz.initializeTimeZones();
    checkEnable();
    getScheduledTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ctr = ref.watch(uprofileNotifierCtr);
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
              'Remainder',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Column(
              children: [
                padding24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Set Remainder',
                      style: getMediumStyle(
                          color: MyColors.black, fontSize: MyFonts.size16),
                    ),
                    LoadSwitch(
                      height: 23.h,
                      width: 38.33.w,
                      value: isEnable,
                      future: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        return true;
                      },
                      spinColor: (v) => MyColors.appColor1,
                      switchDecoration: (bool value, bool value2) =>
                          BoxDecoration(
                        color: value
                            ? MyColors.appColor1
                            : MyColors.lightContainerColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      style: SpinStyle.material,
                      onChange: (v) async {
                        setState(() {
                          isEnable = isEnable ? false : true;
                        });
                        await sharePre.isRemainder(isEnable, 'isEnable');
                        await sharePre.saveMorningTime([
                          ctr.from.hour.toString(),
                          ctr.from.minute.toString()
                        ], 'morning');
                        await sharePre.saveEveningTime(
                            [ctr.to.hour.toString(), ctr.to.minute.toString()],
                            'evening');
                      },
                      onTap: (v) {
                        print('Tapping while value is $v');
                      },
                    ),
                  ],
                ),
                padding32,
                isEnable
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              ctr
                                  .selectTimeFrom(context)
                                  .whenComplete(() => setState(() {
                                        morningTime = ctr.from;
                                      }));

                              await sharePre.updateMorningTime([
                                ctr.from.hour.toString(),
                                ctr.from.minute.toString()
                              ], 'morning');
                            },
                            child: Container(
                              height: 45.h,
                              width: 165.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(
                                      color: MyColors.lightGreyColor)),
                              child: Center(
                                  child: Text(
                                'Morning: ${morningTime != null ? morningTime!.format(context) : ctr.from.format(context)}',
                                style: getMediumStyle(
                                    color: MyColors.bodyTextColor,
                                    fontSize: MyFonts.size15),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              ctr
                                  .selectTimeTo(context)
                                  .whenComplete(() => setState(() {
                                        eveningTime = ctr.to;
                                      }));

                              await sharePre.updateEveningTime([
                                ctr.to.hour.toString(),
                                ctr.to.minute.toString()
                              ], 'evening');
                            },
                            child: Container(
                              height: 45.h,
                              width: 165.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(
                                      color: MyColors.lightGreyColor)),
                              child: Center(
                                  child: Text(
                                'Evening: ${eveningTime != null ? eveningTime!.format(context) : ctr.to.format(context)}',
                                style: getMediumStyle(
                                    color: MyColors.bodyTextColor,
                                    fontSize: MyFonts.size15),
                              )),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

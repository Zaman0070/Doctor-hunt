import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/features/User/home/controller/home_notify.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TagDoctorPage extends ConsumerStatefulWidget {
  const TagDoctorPage({super.key});

  @override
  ConsumerState<TagDoctorPage> createState() => _TagDoctorPageState();
}

class _TagDoctorPageState extends ConsumerState<TagDoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
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
                  'tag Doctor',
                  style: getMediumStyle(
                      color: MyColors.black, fontSize: MyFonts.size18),
                ),
              ),
              Consumer(builder: (context, ref, child) {
                final ctr = ref.watch(userHomeNotifier);
                return CustomTextField(
                  borderColor: MyColors.bodyTextColor.withOpacity(0.6),
                  controller: ctr.tagController,
                  onChanged: (query) {
                    ref.read(findAllDoctorStreamProvider(query));
                    ctr.updateTagField(query);
                  },
                  hintText: 'Search for users',
                  label: '',
                  borderRadius: 16.r,
                  leadingIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      AppAssets.searchtf,
                      height: 13.h,
                      width: 13.w,
                    ),
                  ),
                  tailingIcon: ctr.isTagFieldEmpty()
                      ? null
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              ctr.updateTagField('');
                              ref.read(findAllDoctorStreamProvider(''));
                            },
                            child: SvgPicture.asset(
                              AppAssets.closeSvgIcon,
                            ),
                          ),
                        ),
                );
              }),
              Expanded(
                child: Consumer(builder: (context, ref, child) {
                  final ctr = ref.watch(userHomeNotifier);
                  final userStream = ref.watch(
                      findAllDoctorStreamProvider(ctr.tagController.text));
                  return userStream.when(
                    data: (users) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                final doctor = users[index];
                                return ListTile(
                                  onTap: () {
                                    ctr.addTag(doctor.name, doctor.doctorId);
                                  },
                                  leading: CircleAvatar(
                                      child: Stack(
                                    children: [
                                      CachedCircularNetworkImageWidget(
                                        image: doctor.imageUrl,
                                        name: doctor.name,
                                        size: 50,
                                      ),
                                      ctr.tags == doctor.name
                                          ? Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: SvgPicture.asset(
                                                  AppAssets.taggsSvgIcon))
                                          : Container(),
                                    ],
                                  )),
                                  title: Text(doctor.name),
                                  subtitle: Text(
                                    '@${doctor.name}',
                                    style: getRegularStyle(
                                        color: context.bodyTextColor),
                                  ),
                                );
                              },
                            ),
                          ),
                          Center(
                            child: CustomButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              buttonText: 'Done',
                              buttonHeight: 54.h,
                              buttonWidth: 270.w,
                              borderRadius: 6.r,
                              backColor: MyColors.appColor1,
                            ),
                          ),
                          padding56,
                        ],
                      );
                    },
                    error: (error, stackTrace) => Center(
                      child: Text('Error: $error'),
                    ),
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

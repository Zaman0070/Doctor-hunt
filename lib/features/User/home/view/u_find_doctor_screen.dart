import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/cached_circular_network_image.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class UserFindDoctorScreen extends ConsumerStatefulWidget {
  const UserFindDoctorScreen({super.key});

  @override
  ConsumerState<UserFindDoctorScreen> createState() =>
      _UserFindDoctorScreenState();
}

class _UserFindDoctorScreenState extends ConsumerState<UserFindDoctorScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              'Find Doctors',
              style: getMediumStyle(
                  color: MyColors.appColor1, fontSize: MyFonts.size18),
            ),
          ),
          Consumer(builder: (context, ref, child) {
            return CustomTextField(
              filled: true,
              controller: searchController,
              onChanged: (query) {
                ref.read(findAllDoctorStreamProvider(searchController.text));
                setState(() {
                  searchController.text = query;
                });
              },
              hintText: 'Search for users',
              label: '',
              borderRadius: 6.r,
              leadingIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  AppAssets.searchtf,
                  width: 15.w,
                  height: 15.h,
                ),
              ),
              tailingIcon: searchController.text.isEmpty
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          searchController.clear();
                          setState(() {
                            ref.read(watchAllFavDoctorStreamProvider(''));
                          });
                        },
                        child: Image.asset(
                          AppAssets.cancel,
                          width: 12.w,
                          height: 12.h,
                        ),
                      ),
                    ),
            );
          }),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final userStream =
                  ref.watch(findAllDoctorStreamProvider(searchController.text));
              return userStream.when(
                data: (doctor) {
                  return ListView.builder(
                    itemCount: doctor.length,
                    itemBuilder: (context, index) {
                      final data = doctor[index];
                      return ListTile(
                        onTap: () {
                          // ctr.addTag(
                          //     '@${user.firstName} ${user.lastName}');
                        },
                        leading: CircleAvatar(
                            child: Stack(
                          children: [
                            CachedCircularNetworkImageWidget(
                              image: data.imageUrl,
                              size: 50,
                            ),
                          ],
                        )),
                        title: Text('${data.name}'),
                        subtitle: Text(
                          '@${data.name} ',
                          style: getRegularStyle(color: context.bodyTextColor),
                        ),
                      );
                    },
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
      )),
    );
  }
}

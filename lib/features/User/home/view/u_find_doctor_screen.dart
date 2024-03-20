import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/features/User/home/widgets/u_find_card.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
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
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: Consumer(builder: (context, ref, child) {
              return CustomTextField(
                filled: true,
                controller: searchController,
                onChanged: (query) {
                  ref.read(findAllDoctorStreamProvider(searchController.text));
                  setState(() {
                    searchController.text = query;
                  });
                },
                hintText: 'Search for doctors',
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
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Consumer(builder: (context, ref, child) {
                final userStream = ref
                    .watch(findAllDoctorStreamProvider(searchController.text));
                return userStream.when(
                  data: (doctor) {
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100.h),
                      itemCount: doctor.length,
                      itemBuilder: (context, index) {
                        final data = doctor[index];
                        return UFindDoctorCard(model: data);
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
          ),
        ],
      )),
    );
  }
}

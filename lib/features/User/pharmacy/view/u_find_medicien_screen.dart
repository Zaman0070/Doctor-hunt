import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_text_fields.dart';
import 'package:doctor_app/features/User/home/controller/home_controller.dart';
import 'package:doctor_app/features/User/pharmacy/widgets/u_find_med_card.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';

class PharmistFindMedScreen extends ConsumerStatefulWidget {
  const PharmistFindMedScreen({super.key});

  @override
  ConsumerState<PharmistFindMedScreen> createState() =>
      _UserFindDoctorScreenState();
}

class _UserFindDoctorScreenState extends ConsumerState<PharmistFindMedScreen> {
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
              'Find Medicine',
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
                  ref.read(findAllMedStreamProvider(searchController.text));
                  setState(() {
                    searchController.text = query;
                  });
                },
                hintText: 'Search for medicine',
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
                              ref.read(findAllMedStreamProvider(''));
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
                    .watch(findAllMedStreamProvider(searchController.text));
                return userStream.when(
                  data: (mde) {
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100.h),
                      itemCount: mde.length,
                      itemBuilder: (context, index) {
                        final data = mde[index];
                        return UFindMedCard(model: data);
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

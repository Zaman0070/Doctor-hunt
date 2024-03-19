import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/routes/route_manager.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import '../../../commons/common_imports/common_libs.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController();

  final List<String> pageContentString = [
    'Welcome to Doc Pharma',
    'About Diabetes',
    'Explore features',
  ];
  final List<String> pageContentDes = [
    'Consult with doctors, order prescriptions, and stay updated on healthcare news. Plus, anticipate diabetes Type 1 with our prediction feature.',
    'Introducing our groundbreaking diabetes Type 1 prediction feature: revolutionizing how you manage your health.',
    "Discover a world of convenience with our app's doctor consultation, online pharmacy, and news updates. Stay proactive with our advanced prediction feature, revolutionizing how you manage your health.",
  ];
  final List<String> pageContentSvg = [
    AppAssets.intro1,
    AppAssets.intro2,
    AppAssets.intro3,
  ];

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPageIndex = _pageController.page!.round();
      });
    });
  }

  void next() {
    if (currentPageIndex == 2) {
      Navigator.pushReplacementNamed(context, AppRoutes.accountTypeScreen);
      return;
    }
    setState(() {
      currentPageIndex++;
    });
    _pageController.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: MasterScafold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 630.h,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return buildPage(index);
                },
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: CustomButton(
                backColor: MyColors.appColor1,
                borderRadius: 10.r,
                onPressed: next,
                buttonText: currentPageIndex == 2 ? 'Get Started' : 'Next',
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            if (!(currentPageIndex == 2)) ...[
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.accountTypeScreen, (route) => false);
                  },
                  child: Text(
                    'Skip',
                    style: getRegularStyle(
                        color: MyColors.bodyTextColor,
                        fontSize: MyFonts.size14),
                  )),
            ],
            if (currentPageIndex == 2) ...[
              SizedBox(
                height: 48.h,
              )
            ],
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage(int index) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          pageContentSvg[index],
          height: 447.h,
          width: 460.w,
        ),
        padding40,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Text(
            pageContentString[index],
            textAlign: TextAlign.center,
            style:
                getMediumStyle(color: MyColors.black, fontSize: MyFonts.size28),
          ),
        ),
        padding8,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Text(
            pageContentDes[index],
            textAlign: TextAlign.center,
            style: getRegularStyle(
                color: MyColors.bodyTextColor, fontSize: MyFonts.size14),
          ),
        ),
      ],
    );
  }
}

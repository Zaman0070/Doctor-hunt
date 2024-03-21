import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/apis_commons.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/commons/common_widgets/custom_button.dart';
import 'package:doctor_app/features/User/pharmacy/controller/u_pharmacy_controller.dart';
import 'package:doctor_app/models/order/order_model.dart';
import 'package:doctor_app/models/product/products_model.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserEnableLocationScreen extends ConsumerStatefulWidget {
  const UserEnableLocationScreen(
      {super.key,
      required this.productModel,
      required this.patientName,
      required this.patientPhone,
      required this.patientEmail,
      required this.patientAge,
      required this.patientGender,
      required this.imageUrls});
  final ProductModel productModel;
  final String patientName;
  final String patientPhone;
  final String patientEmail;
  final String patientAge;
  final String patientGender;
  final List<String> imageUrls;

  @override
  ConsumerState<UserEnableLocationScreen> createState() =>
      _UserEnableLocationScreenState();
}

class _UserEnableLocationScreenState
    extends ConsumerState<UserEnableLocationScreen> {
  String? _currentAddress;
  Position? _currentPosition;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.country}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MasterScafold(
            child: Column(children: [
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
          'Enable Location Services',
          style:
              getMediumStyle(color: MyColors.black, fontSize: MyFonts.size18),
        ),
      ),
      Expanded(
          child: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.locationsIcon,
              width: 214.w,
              height: 214.h,
            ),
            padding24,
            Text(
              'Enable Location Services',
              style: getMediumStyle(
                  color: MyColors.black, fontSize: MyFonts.size18),
            ),
            padding12,
            Text(
              'To get the best experience, please enable location services.',
              style: getRegularStyle(
                  color: MyColors.bodyTextColor, fontSize: MyFonts.size14),
              textAlign: TextAlign.center,
            ),
            padding32,
            CustomButton(
              onPressed: () {
                _getAddressFromLatLng(_currentPosition!);
              },
              buttonText: 'Enable Location',
              buttonHeight: 45.h,
              buttonWidth: 270.w,
              borderRadius: 6.r,
              backColor: MyColors.bodyTextColor,
            ),
            padding56,
            CustomButton(
              isLoading: ref.watch(userPharmacyControllerProvider),
              onPressed: _currentAddress != null
                  ? insertOrder
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please enable location services')));
                    },
              buttonText: 'Buy Now',
              buttonHeight: 54.h,
              buttonWidth: 270.w,
              borderRadius: 6.r,
              backColor: _currentAddress == null
                  ? MyColors.lightGreyColor
                  : MyColors.appColor1,
            ),
          ],
        ),
      )),
    ])));
  }

  insertOrder() async {
    await ref.watch(userPharmacyControllerProvider.notifier).insertOrder(
          model: OrderModel(
              productName: widget.productModel.productName,
              productUuid: widget.productModel.uid,
              productId: widget.productModel.productId,
              productPrice: widget.productModel.productPrice,
              productDescription: widget.productModel.productDescription,
              productImage: widget.productModel.productImage,
              rating: widget.productModel.rating,
              createdAt: DateTime.now(),
              deliveredDate: DateTime.now(),
              uid: FirebaseAuth.instance.currentUser!.uid,
              userName: widget.patientName,
              userPhone: widget.patientPhone,
              userEmail: widget.patientEmail,
              userAge: widget.patientAge,
              userGender: widget.patientGender,
              userAddress: _currentAddress,
              orderStatus: "Pending",
              reportImages: widget.imageUrls),
          context: context,
        );
  }
}

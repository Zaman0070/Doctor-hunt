import 'package:doctor_app/commons/common_functions/padding.dart';
import 'package:doctor_app/commons/common_imports/common_libs.dart';
import 'package:doctor_app/commons/common_widgets/backgroun_scafold.dart';
import 'package:doctor_app/utils/constants/app_constants.dart';
import 'package:doctor_app/utils/constants/assets_manager.dart';
import 'package:flutter/material.dart';

class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({super.key});

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

List<String> respo = [
  "Users must provide accurate and up-to-date information during registration and use of the App.",
  "Users are solely responsible for the security of their login credentials and must not share them with third parties.",
  "Users agree to use the App for its intended purposes and in compliance with applicable laws and regulations."
];
List<String> medical = [
  "The App provides informational content and tools for educational and support purposes only and should not be considered a substitute for professional medical advice, diagnosis, or treatment.",
  "Users are advised to consult with qualified healthcare professionals for personalized medical advice and treatment recommendations."
];

List<String> ttol = [
  "The predictive tool provided by the App is based on algorithms and user-provided data and should be considered as a preliminary assessment only.",
  "The predictive tool does not guarantee the accuracy of results and should not be used as the sole basis for diagnosing diabetes or making treatment decisions."
];

List<String> serv = [
  "The App facilitates communication between users and healthcare professionals specializing in diabetes care.",
  "Users understand that consultations with healthcare professionals are subject to availability and may require additional fees."
];

List<String> schedule = [
  "Users can schedule appointments with healthcare professionals through the App's booking system.",
  "Appointments are subject to availability and may be rescheduled or canceled based on the healthcare professional's discretion."
];

List<String> prescription = [
  "Users may request prescription fulfillment services through the App, which facilitates communication with partnering pharmacies.",
  "Users understand that pharmacies have their own policies and procedures for dispensing medications and may require additional information or verification."
];

List<String> dataPriv = [
  "DiaPredict respects user privacy and adheres to applicable data protection laws and regulations.",
  "User data collected by the App is used solely for the purpose of providing services and improving user experience.",
  "DiaPredict may collect, store, and process user data in accordance with its Privacy Policy."
];

List<String> property = [
  "The App and its content, including but not limited to text, graphics, logos, and images, are protected by copyright and other intellectual property laws.",
  "Users may not reproduce, modify, distribute, or exploit any part of the App without prior written consent from DiaPredict."
];

List<String> modification = [
  "DiaPredict reserves the right to modify or update these terms and conditions at any time without prior notice.",
  "Users are responsible for reviewing the terms and conditions periodically to stay informed of any changes."
];

List<String> terminater = [
  "DiaPredict reserves the right to terminate or suspend access to the App for any user who violates these terms and conditions or engages in unlawful or unauthorized activities."
];

List<String> law = [
  "These terms and conditions shall be governed by and construed in accordance with the laws of the Pakistan.",
  "Any disputes arising out of or relating to these terms and conditions shall be resolved through arbitration or litigation in the courts of Pakistan."
];

class _TermConditionScreenState extends State<TermConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScafold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                'Terms & Conditions',
                style: getMediumStyle(
                    color: MyColors.black, fontSize: MyFonts.size18),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(AppConstants.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DiaPredict App Terms and Conditions',
                        style: getBoldStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size18),
                      ),
                      padding24,
                      Text(
                        '1. Introduction',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      Text(
                        'DiaPredict is a mobile application designed to assist users in predicting the likelihood of having Type 1 Diabetes, consulting with medical professionals specialized in diabetes care, scheduling appointments, and facilitating prescription fulfillment through pharmacies. By accessing or using the App, you agree to comply with and be bound by the following terms and conditions.',
                        style: getLightStyle(
                            color: MyColors.bodyTextColor,
                            fontSize: MyFonts.size13),
                      ),
                      padding24,
                      Text(
                        '2. User Responsibilities',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: respo.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    respo[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text(
                        '3. Medical Disclaimer',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: medical.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    medical[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text(
                        '4. Predictive Tool',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: ttol.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    ttol[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text(
                        '5. Consultation Services',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: serv.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    serv[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text(
                        '6. Appointment Scheduling',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: schedule.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    schedule[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text(
                        '7. Prescription Fulfillment',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: prescription.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    prescription[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text(
                        '8. Data Privacy',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: dataPriv.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    dataPriv[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text(
                        '9. Intellectual Property',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: property.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    property[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text(
                        '10. Modifications',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: modification.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    modification[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text(
                        '11. Termination',
                        style: getBoldStyle(
                            color: MyColors.appColor1,
                            fontSize: MyFonts.size16),
                      ),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: terminater.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    terminater[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text("12. Governing Law",
                          style: getBoldStyle(
                              color: MyColors.appColor1,
                              fontSize: MyFonts.size16)),
                      padding12,
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: law.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: MyColors.appColor1,
                                  ),
                                ),
                                padding16,
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 0.95.sw - 50.w,
                                      maxHeight: 100.h),
                                  child: Text(
                                    law[index],
                                    style: getLightStyle(
                                        color: MyColors.bodyTextColor,
                                        fontSize: MyFonts.size13),
                                  ),
                                ),
                              ],
                            );
                          }),
                      padding24,
                      Text.rich(TextSpan(
                          text: 'Note: ',
                          style: getBoldStyle(
                              color: MyColors.red, fontSize: MyFonts.size14),
                          children: [
                            TextSpan(
                              text:
                                  'By using DiaPredict, you acknowledge that you have read, understood, and agreed to these terms and conditions. If you do not agree with any part of these terms, you should not use the App.',
                              style: getRegularStyle(
                                  color: MyColors.bodyTextColor,
                                  fontSize: MyFonts.size12),
                            )
                          ])),
                      padding16,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

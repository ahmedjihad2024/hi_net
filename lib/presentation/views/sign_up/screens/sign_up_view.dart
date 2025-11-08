import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_form_field/simple_form.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/common/ui_components/default_app_bar.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/translations_manager.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header with back button and "Sign In" title
                DefaultAppBar(
                  titleTextAlign: TextAlign.right,
                  titleAlignment: Alignment.centerRight,
                  hideBackButton: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.w,
                  ),
                  actionButtons: [
                    CustomInkButton(
                      onTap: () {},
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      child: Text(
                        Translation.sign_up.tr,
                        style: context.bodyLarge,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        // Welcome Aboard Title
                        Text(
                          Translation.welcome_aboard.tr,
                          style: context.titleLarge.copyWith(
                            fontWeight: FontWeightM.bold,
                            fontSize: 28.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // Subtitle
                        Text(
                          Translation.create_account_subtitle.tr,
                          style: context.bodyMedium.copyWith(
                            color: context.bodyMedium.color!.withValues(
                              alpha: .5,
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        // Full Name Input Container
                        SimpleForm(
                          hintText: Translation.full_name.tr,
                          keyboardType: TextInputType.text,
                          controller: fullNameController,
                        ),
                        SizedBox(height: 16.h),
                        // Phone Number Input Container with Flag
                        Container( 
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 12.w),
                                child: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    color: Colors.grey[200],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '🇦🇪', // UAE flag emoji (replace with your custom widget)
                                      style: TextStyle(fontSize: 24.sp),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.sp,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0,
                                      vertical: 16.h,
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              SizedBox(width: 12.w),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h),
                        // Sign Up Button Container
                        Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF007AFF), // iOS Blue
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF007AFF).withOpacity(0.3),
                                blurRadius: 12.r,
                                offset: Offset(0, 4.h),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // Handle button tap
                              },
                              borderRadius: BorderRadius.circular(12.r),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // Terms and Privacy Policy
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                              children: [
                                TextSpan(
                                  text: 'By continuing, you agree to HiNet\'s ',
                                ),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(
                                    color: Color(0xFF007AFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: TextStyle(
                                    color: Color(0xFF007AFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Home Indicator
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 134.w,
                  height: 5.h,
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2.5.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

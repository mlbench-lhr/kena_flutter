import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kena/app/components/my_button.dart';
import 'package:kena/app/components/my_form_text_field.dart';
import 'package:kena/app/components/my_scaffold.dart';
import 'package:kena/app/utils/extensions/context_extensions.dart';
import 'package:kena/app/utils/extensions/validations_exception.dart';
import 'package:kena/generated/assets/assets.gen.dart';
import 'package:kena/view/auth/widgets/social_login_btn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    // required this.isRecruiter
  });
  // final bool isRecruiter;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final AuthService _authService = AuthService();
  // final OAuthService _oAuthService = OAuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  bool isLoading = false;
  bool get _isFormFilled =>
      emailController.text.trim().isNotEmpty &&
      passwordController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    // fillFormForTesting();
    emailController.addListener(_onTextChange);
    passwordController.addListener(_onTextChange);
  }

  void _onTextChange() {
    if (mounted) setState(() {});
  }

  // void fillFormForTesting() {
  //   if (kDebugMode) {
  //     emailController.text = widget.isVendor
  //         ? 'mtalha2410+4dec0@gmail.com'
  //         : 'mtalha2410+USER5dec0@gmail.com';
  //     passwordController.text = 'Pakistan@123';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 24.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back',
                    style: context.typography.title.copyWith(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                    ),
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      style: context.typography.subtitle.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: "Start building, matching, and hiring with ",
                          style: context.typography.subtitle.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "AI.",
                          style: context.typography.subtitle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   color: Colors.green,
                  //   child: Assets.icons.wavingHand.svg(),
                  // ),
                ],
              ),
              SizedBox(height: 40.h),
              Text(
                'Email',
                style: context.typography.title.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 6.h),
              MyFormTextField(
                prefixIcon: Icon(
                  Icons.mail_outline_rounded,
                  color: context.colors.textSecondary,
                ),
                hint: 'Enter your email',
                controller: emailController,
                textCapitalization: TextCapitalization.none,
                readOnly: isLoading,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required.';
                  } else if (!value.emailValidator()) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24.h),
              Text(
                'Password',
                style: context.typography.title.copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: 6.h),
              MyFormTextField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Assets.icons.lock.svg(),
                ),
                obscureText: hidePassword,
                controller: passwordController,
                hint: 'Enter your password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  child: Icon(
                    hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: context.colors.textSecondary,
                  ),
                ),
                textCapitalization: TextCapitalization.none,
                readOnly: isLoading,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required.';
                  } else if (!value.passwordValidator()) {
                    return 'Password must contain at least one uppercase letter, one number, and one special character.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // AuthService.gotoForgotPassword(
                      //   context,
                      //   // isVendor: widget.isVendor,
                      // );
                    },
                    child: Text(
                      'Forgot password?',
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              MyButton(
                // label: context.l10n.login_button,
                label: 'Log In',
                isLoading: isLoading,
                onPressed: _isFormFilled && !isLoading
                    ? () async {
                        // if (!_formKey.currentState!.validate()) return;
                        // if (mounted) {
                        //   setState(() => isLoading = true);
                        // }
                        // await (widget.isVendor
                        //     ? _authService.vendorLogin(
                        //         context,
                        //         email: emailController.text.trim(),
                        //         password: passwordController.text.trim(),
                        //       )
                        //     : _authService.userLogin(
                        //         context,
                        //         email: emailController.text.trim(),
                        //         password: passwordController.text.trim(),
                        //       ));
                        // if (mounted) setState(() => isLoading = false);
                      }
                    : null,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: Container(color: Colors.white70, height: 1.5.h),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Log In With',
                    style: context.typography.bodySmall.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(color: Colors.white70, height: 1.5.h),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //show Apple login only on iOS
                  if (Platform.isIOS) ...[
                    SocialLoginBtn(
                      type: 'apple',
                      onTap: () async {
                        // debugPrint('apple btn pressed');
                        // setState(() {
                        //   isLoading = true;
                        // });
                        // await _oAuthService.appleAuth(
                        //   context,
                        //   isVendor: widget.isVendor,
                        // );
                        // setState(() {
                        //   isLoading = false;
                        // });
                      },
                    ),
                    SizedBox(width: 16.w),
                  ],
                  SocialLoginBtn(
                    type: 'google',
                    onTap: () async {
                      // debugPrint('google btn pressed from login screen');
                      // setState(() {
                      //   isLoading = true;
                      // });
                      // await _oAuthService.googleAuth(
                      //   context,
                      //   isVendor: widget.isVendor,
                      // );
                      // setState(() {
                      //   isLoading = false;
                      // });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account?",
                    style: context.typography.bodySmall.copyWith(),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: () {
                      // AuthService.gotoSignup(context, widget.isVendor);
                    },
                    child: Text(
                      'Sign Up',
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colors.buttonPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'package:kena/app/routes/routes_name.dart';
import 'package:kena/view/auth/forgot_password/new_password.dart';
import 'package:kena/view/auth/login.dart';
import 'package:kena/view/auth/no_connection.dart';
import 'package:kena/view/auth/profile_type.dart';
import 'package:kena/view/auth/user/user_signup.dart';
import 'package:kena/view/auth/vendor/vendor_signup.dart';
import 'package:kena/view/auth/welcome.dart';
import 'package:kena/view/home/onboarding_screen.dart';
import 'package:kena/view/home/recuriter/recuriter_home.dart';
import 'package:kena/view/home/user/user_home.dart';
import 'package:kena/view/notifications/notifications_screen.dart';
import 'package:kena/view/auth/change_password.dart/change_password.dart';
import 'package:kena/view/profile/choose_activity.dart';
import 'package:kena/view/profile/select_emotions.dart';
import 'package:kena/view/splash/splash_view.dart';
import 'package:kena/app/routes/unknown_page.dart';
import 'package:flutter/material.dart';
import 'package:kena/view/auth/forgot_password/forgot_password.dart';

class Routes {
  static String initialRoute() => RoutesName.userSignup;
  // static String initialRoute() => RoutesName.noConnection;
  static final Map<String, WidgetBuilder> _routes = {
    RoutesName.splash: (_) => const SplashView(),
    RoutesName.welcome: (_) => const WelcomeScreen(),
    RoutesName.profileTypeSelection: (_) => const ProfileTypeSelectionScreen(),
    RoutesName.noConnection: (_) => const NoConnectionScreen(),
    RoutesName.userSignup: (_) => const UserSignupScreen(),
    RoutesName.vendorSignup: (_) => const VendorSignupScreen(),
    RoutesName.changePassword: (_) => const ChangePasswordScreen(),
    RoutesName.notificationScreen: (_) => const NotificationsScreen(),
    RoutesName.userHome: (_) => const UserHome(),
    RoutesName.recruiterHome: (_) => const RecuriterHome(),
    RoutesName.login: (_) => const LoginScreen(),
    RoutesName.chooseActivity: (_) => const ChooseActivity(),
    RoutesName.onboardingScreen: (_) => const OnboardingScreen(),
    RoutesName.selectEmotions: (_) => const SelectEmotions(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    log(
      'Navigating to: ${settings.name}\t - ${settings.arguments}',
      name: 'RouteGenerator',
    );
    switch (settings.name) {
      // case RoutesName.doctorOnboarding:
      //   final args = _getArgs(settings, requiredKeys: ['showBack']);
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         DoctorOnboardingFlowScreen(showBack: args['showBack'] as bool),
      //   );

      case RoutesName.login:
        final args = _getArgs(settings, requiredKeys: ['isVendor']);
        return MaterialPageRoute(
          builder: (_) => LoginScreen(
            // isVendor: args['isVendor'] as bool
          ),
        );

      case RoutesName.forgotPassword:
        final args = _getArgs(settings, requiredKeys: ['isVendor']);
        return MaterialPageRoute(
          builder: (_) =>
              ForgotPasswordScreen(isVendor: args['isVendor'] as bool),
        );

      case RoutesName.newPassword:
        final args = _getArgs(
          settings,
          requiredKeys: ['email', 'otp', 'is_user'],
        );
        return MaterialPageRoute(
          builder: (_) => NewPasswordScreen(
            email: args['email'] as String,
            otp: args['otp'],
            isVendor: !(args['is_user'] as bool),
          ),
        );

      default:
        final builder = _routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder, settings: settings);
        }
        return MaterialPageRoute(builder: (_) => const UnknownRouteScreen());
    }
  }

  static Map<String, dynamic> _getArgs(
    RouteSettings settings, {
    required List<String> requiredKeys,
  }) {
    try {
      final args = settings.arguments! as Map<String, dynamic>;
      for (final key in requiredKeys) {
        if (!args.containsKey(key)) {
          throw ArgumentError('Missing required key: $key');
        }
      }
      return args;
    } catch (e) {
      throw ArgumentError('Invalid arguments for route ${settings.name}');
    }
  }
}

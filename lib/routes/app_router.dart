import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/login/presentation/screens/login_page.dart';
import 'package:cricklo/features/login/presentation/screens/otp_page.dart';
import 'package:cricklo/features/login/presentation/screens/player_type_onboarding.dart';
import 'package:cricklo/features/login/presentation/screens/player_type_onboarding_two.dart';
import 'package:cricklo/features/login/presentation/screens/profile_setup_page.dart';
import 'package:cricklo/features/login/presentation/screens/set_pin.dart';
import 'package:cricklo/features/mainapp/presentation/screens/main_app.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: Routes.mainAppScreen,
        path: Routes.mainAppScreen,
        pageBuilder: (context, state) {
          final currUser = state.extra as UserEntity?;
          return MaterialPage(child: ContentView(currUser: currUser));
        },
      ),
      GoRoute(
        name: Routes.loginPage,
        path: Routes.loginPage,
        pageBuilder: (context, state) => MaterialPage(child: LoginPage()),
      ),
      GoRoute(
        name: Routes.otpPage,
        path: Routes.otpPage,
        pageBuilder: (context, state) {
          final phoneNumber = state.extra as String?;
          return MaterialPage(
            child: OtpPage(phoneNumber: phoneNumber ?? "1234567890"),
          );
        },
      ),
      GoRoute(
        name: Routes.completeProfileScreen,
        path: Routes.completeProfileScreen,
        pageBuilder: (context, state) {
          final phoneNumber = state.extra as String?;
          return MaterialPage(
            child: ProfileSetupPage(phoneNumber: phoneNumber ?? "123456"),
          );
        },
      ),
      GoRoute(
        name: Routes.onboardingScreenOne,
        path: Routes.onboardingScreenOne,
        pageBuilder: (context, state) {
          final user = state.extra as UserEntity;
          return MaterialPage(child: PlayerTypeOnboarding(user: user));
        },
      ),
      GoRoute(
        name: Routes.onboardingScreenTwo,
        path: Routes.onboardingScreenTwo,
        pageBuilder: (context, state) {
          final user = state.extra as UserEntity;
          return MaterialPage(child: PlayerTypeOnboardingTwo(user: user));
        },
      ),
      GoRoute(
        name: Routes.setPin,
        path: Routes.setPin,
        pageBuilder: (context, state) {
          final params = state.extra as List<dynamic>;
          final phoneNumber = params[0] as String?;
          final loginPin = params.length == 1
              ? false
              : params[1] as bool? ?? false;
          return MaterialPage(
            child: SetPinPage(
              phoneNumber: phoneNumber ?? "1234567890",
              loginPin: loginPin,
            ),
          );
        },
      ),
    ],
  );
}

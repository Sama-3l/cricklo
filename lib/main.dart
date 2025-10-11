import 'package:cricklo/features/login/presentation/blocs/cubits/OtpPageCubit/otp_page_cubit.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/SetPinCubit/set_pin_cubit.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/OnboardingPageCubit/onboarding_page_cubit.dart';
import 'package:cricklo/features/notifications/presentation/blocs/blocs/NotificationBloc/notification_bloc.dart';
import 'package:cricklo/injection_container.dart';
import 'package:cricklo/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> hasInternet() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  print(connectivityResult);
  if (connectivityResult == ConnectivityResult.none) {
    // No network (Wi-Fi or mobile)
    return false;
  }

  // Optional: ping a real server to confirm actual internet access
  try {
    final result = await Uri.parse('https://google.com').resolve('').toString();
    // or use http.get(Uri.parse('https://google.com'))
    print(result);
    return true;
  } catch (_) {
    return false;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await DotEnv().load(fileName: ".env");
  hasInternet();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final fakeStream = Stream.periodic(const Duration(seconds: 5));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<OtpPageCubit>()),
        BlocProvider(create: (context) => sl<SetPinCubit>()),
        // BlocProvider(create: (_) => sl<AccountCubit>()),
        BlocProvider(create: (_) => sl<OnboardingPageCubit>()),
        BlocProvider(create: (context) => NotificationBloc(fakeStream)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter().router,
      ),
    );
  }
}

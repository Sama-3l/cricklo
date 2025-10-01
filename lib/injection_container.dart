import 'package:cookie_jar/cookie_jar.dart';
import 'package:cricklo/features/login/data/datasource/login_remote_datasource.dart';
import 'package:cricklo/features/login/data/repo/auth_repo_impl.dart';
import 'package:cricklo/features/login/data/usecases/login_usecase.dart';
import 'package:cricklo/features/login/data/usecases/onboarding_usecase.dart';
import 'package:cricklo/features/login/data/usecases/register_usecase.dart';
import 'package:cricklo/features/login/data/usecases/set_pin_usecase.dart';
import 'package:cricklo/features/login/data/usecases/verify_otp_usecase.dart';
import 'package:cricklo/features/login/domain/repo/auth_repo.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/LoginPageCubit/login_page_cubit.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/OtpPageCubit/otp_page_cubit.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/SetPinCubit/set_pin_cubit.dart';
import 'package:cricklo/features/login/presentation/blocs/cubits/cubit/onboarding_page_cubit.dart';
import 'package:cricklo/features/mainapp/data/datasource/main_app_remote_datasource.dart';
import 'package:cricklo/features/mainapp/data/repo/main_app_repo_impl.dart';
import 'package:cricklo/features/mainapp/data/usecases/get_current_user_usecase.dart';
import 'package:cricklo/features/mainapp/data/usecases/logout_usecase.dart';
import 'package:cricklo/features/mainapp/domain/repo/main_app_repo.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final cookiePath = '${appDocDir.path}/.cookies';

  // Create a single cookie jar instance
  final cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

  // Register cookieJar in DI so we can query JWT later if needed
  sl.registerLazySingleton<PersistCookieJar>(() => cookieJar);

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {"Content-Type": "application/json"},
      ),
    );

    // Attach cookie manager (will persist cookies automatically)
    dio.interceptors.add(CookieManager(cookieJar));

    // Debug logging
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    return dio;
  });

  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  _authDependencies();
  _mainAppDependencies();
}

void _authDependencies() {
  // data-source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiService>()),
  );
  // repo
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );
  //use-cases
  sl.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<VerifyOtpUsecase>(
    () => VerifyOtpUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SetPinUsecase>(
    () => SetPinUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<OnboardingUseCase>(
    () => OnboardingUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(sl<AuthRepository>()),
  );
  //cubits
  sl.registerFactory<LoginPageCubit>(
    () => LoginPageCubit(sl<RegisterUsecase>()),
  );
  sl.registerFactory<OtpPageCubit>(() => OtpPageCubit(sl<VerifyOtpUsecase>()));
  sl.registerFactory<SetPinCubit>(
    () => SetPinCubit(sl<SetPinUsecase>(), sl<LoginUsecase>()),
  );
  sl.registerFactory<OnboardingPageCubit>(
    () => OnboardingPageCubit(sl<OnboardingUseCase>()),
  );
}

void _mainAppDependencies() {
  // data-source
  sl.registerLazySingleton<MainAppRemoteDatasource>(
    () => MainAppRemoteDatasourceImpl(sl<ApiService>()),
  );
  // repo
  sl.registerLazySingleton<MainAppRepository>(
    () => MainAppRepoImpl(sl<MainAppRemoteDatasource>()),
  );
  //use-cases
  sl.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(sl<MainAppRepository>()),
  );
  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(sl<MainAppRepository>()),
  );
  //cubits
  sl.registerFactory<MainAppCubit>(
    () => MainAppCubit(sl<GetCurrentUserUsecase>(), sl<LogoutUsecase>()),
  );
}

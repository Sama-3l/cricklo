import 'package:cookie_jar/cookie_jar.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/features/account/data/usecases/get_teams_usecase.dart';
import 'package:cricklo/features/account/presentation/blocs/cubits/AccountPageCubit/account_page_cubit.dart';
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
import 'package:cricklo/features/login/presentation/blocs/cubits/OnboardingPageCubit/onboarding_page_cubit.dart';
import 'package:cricklo/features/mainapp/data/datasource/main_app_remote_datasource.dart';
import 'package:cricklo/features/mainapp/data/repo/main_app_repo_impl.dart';
import 'package:cricklo/features/mainapp/data/repo/socket_auth_repo_impl.dart';
import 'package:cricklo/features/mainapp/data/usecases/fetch_notifications_usecase.dart';
import 'package:cricklo/features/mainapp/data/usecases/get_current_user_usecase.dart';
import 'package:cricklo/features/mainapp/data/usecases/get_user_matches_usecase.dart';
import 'package:cricklo/features/mainapp/data/usecases/logout_usecase.dart';
import 'package:cricklo/features/mainapp/domain/repo/main_app_repo.dart';
import 'package:cricklo/features/mainapp/domain/repo/socket_auth_repo.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/features/matches/data/datasource/match_datasource_remote.dart';
import 'package:cricklo/features/matches/data/repo/match_repo_impl.dart';
import 'package:cricklo/features/matches/data/usecases/create_match_usecase.dart';
import 'package:cricklo/features/matches/data/usecases/search_teams_usecase.dart';
import 'package:cricklo/features/matches/domain/repo/match_repo.dart';
import 'package:cricklo/features/matches/presentation/blocs/cubits/CreateMatchCubit/create_match_cubit.dart';
import 'package:cricklo/features/matches/presentation/blocs/cubits/SearchTeamCubit/search_team_cubit.dart';
import 'package:cricklo/features/notifications/data/datasource/notification_datasource.dart';
import 'package:cricklo/features/notifications/data/repo/notification_repo_impl.dart';
import 'package:cricklo/features/notifications/data/usecases/get_notification_usecase.dart';
import 'package:cricklo/features/notifications/data/usecases/team_response_invite_usecase.dart';
import 'package:cricklo/features/notifications/domain/repo/notification_repo.dart';
import 'package:cricklo/features/notifications/presentation/blocs/blocs/NotificationBloc/notification_bloc.dart';
import 'package:cricklo/features/notifications/presentation/blocs/cubits/NotificationCubit/notification_cubit.dart';
import 'package:cricklo/features/teams/data/datasource/team_datasource_remote.dart';
import 'package:cricklo/features/teams/data/repo/team_repo_impl.dart';
import 'package:cricklo/features/teams/data/usecases/create_team_usecase.dart';
import 'package:cricklo/features/teams/data/usecases/get_team_details_usecase.dart';
import 'package:cricklo/features/teams/data/usecases/invite_player_usecase.dart';
import 'package:cricklo/features/teams/data/usecases/search_players_usecase.dart';
import 'package:cricklo/features/teams/domain/repo/team_repo.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/AddPlayersCubit/add_players_cubit.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/CreateTeamCubit/create_team_cubit.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/SearchPlayersCubit/search_players_cubit.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/services/api_service.dart';
import 'package:cricklo/services/auth_helper.dart';
import 'package:cricklo/services/socket_service.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalVariables.setNavigatorKey(navigatorKey);
  final appDocDir = await getApplicationDocumentsDirectory();
  final cookiePath = '${appDocDir.path}/.cookies';
  final cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

  sl.registerLazySingleton<PersistCookieJar>(() => cookieJar);

  // 🔹 Dio setup
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.add(CookieManager(cookieJar));
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

  // 🔹 Auth dependencies
  final authHelper = AuthCookieHelper(
    cookieJar,
    'https://cricklo.onrender.com',
  );
  sl.registerLazySingleton<AuthCookieHelper>(() => authHelper);
  sl.registerLazySingleton<IAuthRepository>(
    () => IAuthRepositoryImpl(authHelper),
  );

  // 🔹 Socket service
  sl.registerLazySingleton<SocketService>(() => SocketService());

  // Attempt connection only if token exists
  final token = await sl<IAuthRepository>().getAuthToken();
  if (token != null) {
    await sl<SocketService>().connect();
  } else {
    print("⚠️ No token found — socket connection skipped");
  }

  // 🔹 Other services
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  _authDependencies();
  _mainAppDependencies();
  _teamDependencies();
  _notificationDependencies();
  _matchDependencies();
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
    () => MainAppCubit(
      sl<GetCurrentUserUsecase>(),
      sl<LogoutUsecase>(),
      sl<GetUserMatchesUsecase>(),
    ),
  );
}

void _teamDependencies() {
  // data-source
  sl.registerLazySingleton<TeamDatasourceRemote>(
    () => TeamDatasourceRemoteImpl(sl<ApiService>()),
  );
  // repo
  sl.registerLazySingleton<TeamRepo>(
    () => TeamRepoImpl(sl<TeamDatasourceRemote>()),
  );
  //use-cases
  sl.registerLazySingleton<CreateTeamUsecase>(
    () => CreateTeamUsecase(sl<TeamRepo>()),
  );
  sl.registerLazySingleton<SearchPlayersUsecase>(
    () => SearchPlayersUsecase(sl<TeamRepo>()),
  );
  sl.registerLazySingleton<InvitePlayerUsecase>(
    () => InvitePlayerUsecase(sl<TeamRepo>()),
  );
  sl.registerLazySingleton<GetTeamsUsecase>(
    () => GetTeamsUsecase(sl<TeamRepo>()),
  );
  sl.registerLazySingleton<SearchTeamsUseCase>(
    () => SearchTeamsUseCase(sl<TeamRepo>()),
  );
  sl.registerLazySingleton<GetTeamDetailsUsecase>(
    () => GetTeamDetailsUsecase(sl<TeamRepo>()),
  );
  //cubits
  sl.registerFactory<CreateTeamCubit>(
    () => CreateTeamCubit(sl<CreateTeamUsecase>()),
  );
  sl.registerFactory<SearchPlayersCubit>(
    () => SearchPlayersCubit(sl<SearchPlayersUsecase>()),
  );
  sl.registerFactory<AddPlayersCubit>(
    () => AddPlayersCubit(sl<InvitePlayerUsecase>()),
  );
  sl.registerFactory<AccountCubit>(() => AccountCubit(sl<GetTeamsUsecase>()));
  sl.registerFactory<SearchTeamCubit>(
    () => SearchTeamCubit(sl<SearchTeamsUseCase>()),
  );
  sl.registerFactory<TeamPageCubit>(
    () => TeamPageCubit(sl<GetTeamDetailsUsecase>()),
  );
}

void _notificationDependencies() {
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(
      sl<ApiService>(),
      socketService: sl<SocketService>(),
    ),
  );
  // repo
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      remoteDataSource: sl<NotificationRemoteDataSource>(),
    ),
  );
  //use-cases
  sl.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<FetchNotificationsUsecase>(
    () => FetchNotificationsUsecase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<TeamResponseInviteUsecase>(
    () => TeamResponseInviteUsecase(sl<NotificationRepository>()),
  );
  //cubits
  sl.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      sl<GetNotificationsUseCase>(),
      GlobalVariables.navigatorKey!,
    ),
  );
  sl.registerFactory<NotificationCubit>(
    () => NotificationCubit(
      sl<FetchNotificationsUsecase>(),
      sl<TeamResponseInviteUsecase>(),
    ),
  );
}

void _matchDependencies() {
  sl.registerLazySingleton<MatchDatasourceRemote>(
    () => MatchDatasourceRemoteImpl(sl<ApiService>()),
  );
  // repo
  sl.registerLazySingleton<MatchRepo>(
    () => MatchRepoImpl(sl<MatchDatasourceRemote>()),
  );
  //use-cases
  sl.registerLazySingleton<CreateMatchUsecase>(
    () => CreateMatchUsecase(sl<MatchRepo>()),
  );
  sl.registerLazySingleton<GetUserMatchesUsecase>(
    () => GetUserMatchesUsecase(sl<MatchRepo>()),
  );
  //cubits
  sl.registerFactory<CreateMatchCubit>(
    () => CreateMatchCubit(sl<CreateMatchUsecase>()),
  );
}

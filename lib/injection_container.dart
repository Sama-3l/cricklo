import 'package:cookie_jar/cookie_jar.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/features/account/data/usecases/get_profile_usecase.dart';
import 'package:cricklo/features/account/data/usecases/get_teams_usecase.dart';
import 'package:cricklo/features/account/presentation/blocs/cubits/AccountPageCubit/account_page_cubit.dart';
import 'package:cricklo/features/account/presentation/blocs/cubits/ProfilePageCubit/profile_page_cubit.dart';
import 'package:cricklo/features/follow/data/datasource/follow_datasource_remote.dart';
import 'package:cricklo/features/follow/data/repo/follow_repo_impl.dart';
import 'package:cricklo/features/follow/data/usecases/follow_usecase.dart';
import 'package:cricklo/features/follow/data/usecases/get_followers_usecase.dart';
import 'package:cricklo/features/follow/data/usecases/unfollow_usecase.dart';
import 'package:cricklo/features/follow/domain/repo/follow_repo.dart';
import 'package:cricklo/features/follow/presentation/blocs/cubits/cubit/followers_page_cubit.dart';
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
import 'package:cricklo/features/mainapp/data/usecases/get_all_tournaments_usecase.dart';
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
import 'package:cricklo/features/notifications/data/usecases/match_response_invite_usecase.dart';
import 'package:cricklo/features/notifications/data/usecases/team_response_invite_usecase.dart';
import 'package:cricklo/features/notifications/data/usecases/tournament_response_invite_usecase.dart';
import 'package:cricklo/features/notifications/domain/repo/notification_repo.dart';
import 'package:cricklo/features/notifications/presentation/blocs/blocs/NotificationBloc/notification_bloc.dart';
import 'package:cricklo/features/notifications/presentation/blocs/cubits/NotificationCubit/notification_cubit.dart';
import 'package:cricklo/features/scorer/data/datasource/scorer_datasource.dart';
import 'package:cricklo/features/scorer/data/repo/scorer_repo_impl.dart';
import 'package:cricklo/features/scorer/data/usecases/get_match_state_usecase.dart';
import 'package:cricklo/features/scorer/data/usecases/listen_to_match_usecase.dart';
import 'package:cricklo/features/scorer/data/usecases/scorer_innings_change_usecase.dart';
import 'package:cricklo/features/scorer/data/usecases/scorer_match_complete_usecase.dart';
import 'package:cricklo/features/scorer/data/usecases/scorer_over_end_usecase.dart';
import 'package:cricklo/features/scorer/data/usecases/scorer_update_usecase.dart';
import 'package:cricklo/features/scorer/data/usecases/start_match_usecase.dart';
import 'package:cricklo/features/scorer/domain/repo/scorer_repo.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
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
import 'package:cricklo/features/tournament/data/datasource/tournament_datasource_remote.dart';
import 'package:cricklo/features/tournament/data/repo/tournament_repo_impl.dart';
import 'package:cricklo/features/tournament/data/usecases/add_team_to_group_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/apply_tournament_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/create_group_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/create_tournament_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/delete_group_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/edit_group_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/get_tournament_details_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/invite_moderators_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/invite_teams_usecase.dart';
import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/CreateTournamentCubit/create_tournament_cubit.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/FetchUserTeamsCubit/fetch_user_teams_cubit.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
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
  _scorerMatchDependencies();
  _tournamentDependencies();
  _followDependencies();
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
  sl.registerLazySingleton<GetProfileUsecase>(
    () => GetProfileUsecase(sl<MainAppRepository>()),
  );
  //cubits
  sl.registerFactory<MainAppCubit>(
    () => MainAppCubit(
      sl<GetCurrentUserUsecase>(),
      sl<LogoutUsecase>(),
      sl<GetUserMatchesUsecase>(),
      sl<GetAllTournamentsUsecase>(),
    ),
  );
  sl.registerFactory<ProfilePageCubit>(
    () => ProfilePageCubit(
      sl<GetTeamsUsecase>(),
      sl<GetProfileUsecase>(),
      sl<FollowUsecase>(),
      sl<UnFollowUsecase>(),
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
    () => TeamPageCubit(
      sl<GetTeamDetailsUsecase>(),
      sl<FollowUsecase>(),
      sl<UnFollowUsecase>(),
    ),
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
  sl.registerLazySingleton<MatchResponseInviteUsecase>(
    () => MatchResponseInviteUsecase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<TournamentResponseInviteUsecase>(
    () => TournamentResponseInviteUsecase(sl<NotificationRepository>()),
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
      sl<MatchResponseInviteUsecase>(),
      sl<TournamentResponseInviteUsecase>(),
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

void _scorerMatchDependencies() {
  sl.registerLazySingleton<ScorerDatasourceRemote>(
    () => ScorerDatasourceRemoteImpl(sl<ApiService>(), sl<SocketService>()),
  );
  // repo
  sl.registerLazySingleton<ScorerRepo>(
    () => ScorerRepoImpl(sl<ScorerDatasourceRemote>()),
  );
  //use-cases
  sl.registerLazySingleton<ListenToMatchStreamUsecase>(
    () => ListenToMatchStreamUsecase(sl<ScorerRepo>()),
  );
  sl.registerLazySingleton<GetMatchStateUsecase>(
    () => GetMatchStateUsecase(sl<ScorerRepo>()),
  );

  sl.registerLazySingleton<ScorerInningsChangeUsecase>(
    () => ScorerInningsChangeUsecase(sl<ScorerRepo>()),
  );

  sl.registerLazySingleton<ScorerCompleteUsecase>(
    () => ScorerCompleteUsecase(sl<ScorerRepo>()),
  );

  sl.registerLazySingleton<ScorerOverEndUsecase>(
    () => ScorerOverEndUsecase(sl<ScorerRepo>()),
  );

  sl.registerLazySingleton<ScorerUpdateUsecase>(
    () => ScorerUpdateUsecase(sl<ScorerRepo>()),
  );

  sl.registerLazySingleton<StartMatchUsecase>(
    () => StartMatchUsecase(sl<ScorerRepo>()),
  );

  //cubits
  sl.registerFactory<ScorerMatchCenterCubit>(
    () => ScorerMatchCenterCubit(
      sl<ListenToMatchStreamUsecase>(),
      sl<GetMatchStateUsecase>(),
      sl<ScorerInningsChangeUsecase>(),
      sl<ScorerCompleteUsecase>(),
      sl<ScorerOverEndUsecase>(),
      sl<ScorerUpdateUsecase>(),
      sl<StartMatchUsecase>(),
    ),
  );
}

void _tournamentDependencies() {
  sl.registerLazySingleton<TournamentDatasourceRemote>(
    () => TournamentDatasourceRemoteImpl(sl<ApiService>()),
  );
  // repo
  sl.registerLazySingleton<TournamentRepo>(
    () => TournamentRepoImpl(sl<TournamentDatasourceRemote>()),
  );
  //use-cases
  sl.registerLazySingleton<CreateTournamentUsecase>(
    () => CreateTournamentUsecase(sl<TournamentRepo>()),
  );
  sl.registerLazySingleton<GetAllTournamentsUsecase>(
    () => GetAllTournamentsUsecase(sl<TournamentRepo>()),
  );
  sl.registerLazySingleton<InviteModeratorsUsecase>(
    () => InviteModeratorsUsecase(sl<TournamentRepo>()),
  );
  sl.registerLazySingleton<InviteTeamsUsecase>(
    () => InviteTeamsUsecase(sl<TournamentRepo>()),
  );
  sl.registerLazySingleton<ApplyTournamentUsecase>(
    () => ApplyTournamentUsecase(sl<TournamentRepo>()),
  );
  sl.registerLazySingleton<GetTournamentDetailsUsecase>(
    () => GetTournamentDetailsUsecase(sl<TournamentRepo>()),
  );
  sl.registerLazySingleton<CreateGroupUsecase>(
    () => CreateGroupUsecase(sl<TournamentRepo>()),
  );
  sl.registerLazySingleton<AddTeamToGroupUsecase>(
    () => AddTeamToGroupUsecase(sl<TournamentRepo>()),
  );
  sl.registerLazySingleton<DeleteGroupUsecase>(
    () => DeleteGroupUsecase(sl<TournamentRepo>()),
  );
  sl.registerLazySingleton<EditGroupUsecase>(
    () => EditGroupUsecase(sl<TournamentRepo>()),
  );
  //cubits
  sl.registerFactory<CreateTournamentCubit>(
    () => CreateTournamentCubit(sl<CreateTournamentUsecase>()),
  );
  sl.registerFactory<TournamentCubit>(
    () => TournamentCubit(
      sl<InviteModeratorsUsecase>(),
      sl<InviteTeamsUsecase>(),
      sl<ApplyTournamentUsecase>(),
      sl<GetTournamentDetailsUsecase>(),
      sl<CreateGroupUsecase>(),
      sl<AddTeamToGroupUsecase>(),
      sl<DeleteGroupUsecase>(),
      sl<EditGroupUsecase>(),
    ),
  );
  sl.registerFactory<FetchUserTeamsCubit>(
    () => FetchUserTeamsCubit(sl<GetTeamsUsecase>()),
  );
}

void _followDependencies() {
  sl.registerLazySingleton<FollowDatasourceRemote>(
    () => FollowDatasourceRemoteImpl(sl<ApiService>()),
  );
  // repo
  sl.registerLazySingleton<FollowRepo>(
    () => FollowRepoImpl(sl<FollowDatasourceRemote>()),
  );
  //use-cases
  sl.registerLazySingleton<FollowUsecase>(
    () => FollowUsecase(sl<FollowRepo>()),
  );
  sl.registerLazySingleton<UnFollowUsecase>(
    () => UnFollowUsecase(sl<FollowRepo>()),
  );
  sl.registerLazySingleton<GetFollowersUsecase>(
    () => GetFollowersUsecase(sl<FollowRepo>()),
  );
  //cubit
  sl.registerFactory<FollowerPageCubit>(
    () => FollowerPageCubit(sl<GetFollowersUsecase>()),
  );
}

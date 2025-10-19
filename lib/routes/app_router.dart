import 'package:cricklo/core/utils/constants/dummy_data.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/login/presentation/screens/login_page.dart';
import 'package:cricklo/features/login/presentation/screens/otp_page.dart';
import 'package:cricklo/features/login/presentation/screens/player_type_onboarding.dart';
import 'package:cricklo/features/login/presentation/screens/player_type_onboarding_two.dart';
import 'package:cricklo/features/login/presentation/screens/profile_setup_page.dart';
import 'package:cricklo/features/login/presentation/screens/set_pin.dart';
import 'package:cricklo/features/mainapp/presentation/screens/main_app.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/matches/presentation/screens/create_match.dart';
import 'package:cricklo/features/notifications/presentation/screens/notifications_screens.dart';
import 'package:cricklo/features/scorer/presentation/screens/match_result_screen.dart';
import 'package:cricklo/features/scorer/presentation/screens/scorer_match_center.dart';
import 'package:cricklo/features/scorer/presentation/screens/scorer_match_initial_screen.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/presentation/screens/add_players_screen.dart';
import 'package:cricklo/features/teams/presentation/screens/create_team_screen.dart';
import 'package:cricklo/features/teams/presentation/screens/team_page.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/presentation/screens/add_moderators.dart';
import 'package:cricklo/features/tournament/presentation/screens/add_venues.dart';
import 'package:cricklo/features/tournament/presentation/screens/create_tournament.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    navigatorKey: GlobalVariables.navigatorKey,
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
      GoRoute(
        name: Routes.createTeam,
        path: Routes.createTeam,
        pageBuilder: (context, state) {
          final user = state.extra as UserEntity? ?? dummyCurrUser;
          return MaterialPage(child: CreateTeamScreen(user: user));
        },
      ),
      GoRoute(
        name: Routes.addPlayersToTeam,
        path: Routes.addPlayersToTeam,
        pageBuilder: (context, state) {
          final team = state.extra as TeamEntity? ?? dummyTeam;
          return MaterialPage(child: AddPlayersScreen(team: team));
        },
      ),
      GoRoute(
        name: Routes.teamPage,
        path: Routes.teamPage,
        pageBuilder: (context, state) {
          final extras = state.extra as List<dynamic>;
          final team = extras[0] as TeamEntity? ?? dummyTeam;
          final matches = extras[1] as List<MatchEntity>? ?? [];
          return MaterialPage(
            child: TeamPage(team: team, userMatches: matches),
          );
        },
      ),
      GoRoute(
        name: Routes.createMatch,
        path: Routes.createMatch,
        pageBuilder: (context, state) {
          final function = state.extra as Function(MatchEntity match);
          return MaterialPage(
            child: CreateMatch(onComplete: (match) => function(match)),
          );
        },
      ),
      GoRoute(
        name: Routes.notifications,
        path: Routes.notifications,
        pageBuilder: (context, state) {
          return MaterialPage(child: NotificationsScreens());
        },
      ),
      GoRoute(
        name: Routes.scorerInitialPage,
        path: Routes.scorerInitialPage,
        pageBuilder: (context, state) {
          final match = state.extra as MatchEntity? ?? dummyMatchScheduled;
          return MaterialPage(
            child: ScorerMatchInitialScreen(matchEntity: match),
          );
        },
      ),
      GoRoute(
        name: Routes.scorerMatchCenter,
        path: Routes.scorerMatchCenter,
        pageBuilder: (context, state) {
          final extras = state.extra as List<dynamic>;
          final match = extras[0] as MatchEntity? ?? dummyMatchTossDone;
          final spectator = extras[1] as bool? ?? true;
          return MaterialPage(
            child: ScorerMatchCenter(match: match, spectator: spectator),
          );
        },
      ),
      GoRoute(
        name: Routes.scorerMatchComplete,
        path: Routes.scorerMatchComplete,
        pageBuilder: (context, state) {
          final extras = state.extra as List<dynamic>;
          final logo = extras[0] as String;
          final name = extras[1] as String;
          final resultMessage = extras[2] as String;
          return MaterialPage(
            child: MatchResultScreen(
              teamLogo: logo,
              teamName: name,
              resultMessage: resultMessage,
            ),
          );
        },
      ),
      GoRoute(
        name: Routes.createTournament,
        path: Routes.createTournament,
        pageBuilder: (context, state) {
          final function =
              state.extra as Function(TournamentEntity match)? ??
              (tournament) => {};
          return MaterialPage(
            child: CreateTournament(onCreate: (match) => function(match)),
          );
        },
      ),
      GoRoute(
        name: Routes.addTournamentVenues,
        path: Routes.addTournamentVenues,
        pageBuilder: (context, state) {
          final tournament = state.extra as TournamentEntity;
          return MaterialPage(child: AddVenuesPage(tournament: tournament));
        },
      ),
      GoRoute(
        name: Routes.addTournamentModerators,
        path: Routes.addTournamentModerators,
        pageBuilder: (context, state) {
          final tournament = state.extra as TournamentEntity;
          return MaterialPage(child: AddModeratorsPage(tournament: tournament));
        },
      ),
    ],
  );
}

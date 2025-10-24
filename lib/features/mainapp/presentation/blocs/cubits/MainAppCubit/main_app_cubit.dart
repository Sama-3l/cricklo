import 'package:bloc/bloc.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/mainapp/data/usecases/get_all_tournaments_usecase.dart';
import 'package:cricklo/features/mainapp/data/usecases/get_current_user_usecase.dart';
import 'package:cricklo/features/mainapp/data/usecases/get_user_matches_usecase.dart';
import 'package:cricklo/features/mainapp/data/usecases/logout_usecase.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/injection_container.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  final GetCurrentUserUsecase _currentUserUsecase;
  final GetUserMatchesUsecase _getUserMatchesUsecase;
  final GetAllTournamentsUsecase _getAllTournamentsUsecase;
  final LogoutUsecase _logoutUsecase;

  MainAppCubit(
    this._currentUserUsecase,
    this._logoutUsecase,
    this._getUserMatchesUsecase,
    this._getAllTournamentsUsecase,
  ) : super(
        UpdateIndex(
          matchLoading: false,
          tournamentLoading: false,
          currentIndex: 0,
          showOptions: false,
          matches: [],
          tournaments: [],
        ),
      );

  logout(BuildContext context) async {
    emit(
      UpdateIndex(
        matchLoading: false,
        tournamentLoading: false,
        tournaments: state.tournaments,
        currentIndex: 0,
        showOptions: false,
        user: state.user,
        loading: true,
        matches: state.matches,
      ),
    );
    final response = await _logoutUsecase(NoParams());
    response.fold(
      (_) {
        emit(
          UpdateIndex(
            matchLoading: false,
            tournamentLoading: false,
            tournaments: state.tournaments,
            currentIndex: 0,
            showOptions: false,
            user: state.user,
            loading: false,
            matches: state.matches,
          ),
        );
      },
      (response) {
        if (response.success) {
          final dio = sl<Dio>();
          if (dio.interceptors.any((i) => i is CookieManager)) {
            final cookieManager =
                dio.interceptors.firstWhere((i) => i is CookieManager)
                    as CookieManager;
            cookieManager.cookieJar.deleteAll();
          }
          emit(
            UpdateIndex(
              matchLoading: false,
              tournamentLoading: false,
              tournaments: [],
              matches: [],
              currentIndex: 0,
              showOptions: false,
              user: null,
              loading: false,
            ),
          );
        } else {
          emit(
            UpdateIndex(
              matchLoading: false,
              tournamentLoading: false,
              tournaments: state.tournaments,
              matches: state.matches,
              currentIndex: 0,
              showOptions: false,
              user: state.user,
              loading: false,
            ),
          );
        }
      },
    );
  }

  readNotifications() {
    emit(
      UpdateIndex(
        matchLoading: state.matchLoading,
        tournamentLoading: state.tournamentLoading,
        tournaments: state.tournaments,
        currentIndex: state.currentIndex,
        showOptions: state.showOptions,
        matches: state.matches,
        user: state.user?.copyWith(unreadNotifications: 0),
        loading: false,
      ),
    );
  }

  Future<void> getUserMatches() async {
    emit(
      UpdateIndex(
        matchLoading: true,
        tournamentLoading: true,
        tournaments: state.tournaments,
        currentIndex: state.currentIndex,
        showOptions: state.showOptions,
        matches: state.matches,
        user: state.user?.copyWith(unreadNotifications: 0),
        loading: false,
      ),
    );
    getTournaments();
    final response = await _getUserMatchesUsecase(NoParams());
    response.fold(
      (_) {
        ScaffoldMessenger.of(
          GlobalVariables.navigatorKey!.currentContext!,
        ).showSnackBar(
          SnackBar(
            // behavior: SnackBarBehavior.floating,
            backgroundColor: ColorsConstants.defaultBlack,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            content: Text(
              "Couldn't load matches",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultWhite,
              ),
            ),
          ),
        );
        emit(
          UpdateIndex(
            matchLoading: false,
            tournamentLoading: state.tournamentLoading,
            tournaments: state.tournaments,
            currentIndex: state.currentIndex,
            showOptions: state.showOptions,
            matches: state.matches,
            user: state.user?.copyWith(unreadNotifications: 0),
            loading: false,
          ),
        );
      },
      (response) {
        if (response.success) {
          response.matches.removeWhere(
            (e) =>
                e.teamA.inviteStatus == "DENIED" ||
                e.teamB.inviteStatus == "DENIED" ||
                e.scorer["inviteStatus"] == "DENIED",
          );

          emit(
            UpdateIndex(
              matchLoading: false,
              tournamentLoading: state.tournamentLoading,
              tournaments: state.tournaments,
              currentIndex: state.currentIndex,
              showOptions: state.showOptions,
              matches: response.matches,
              user: state.user?.copyWith(unreadNotifications: 0),
              loading: false,
            ),
          );
        } else {
          emit(
            UpdateIndex(
              matchLoading: false,
              tournamentLoading: state.tournamentLoading,
              tournaments: state.tournaments,
              currentIndex: state.currentIndex,
              showOptions: state.showOptions,
              matches: state.matches,
              user: state.user?.copyWith(unreadNotifications: 0),
              loading: false,
            ),
          );
        }
      },
    );
  }

  Future<void> getTournaments() async {
    final response = await _getAllTournamentsUsecase(NoParams());
    response.fold(
      (_) {
        ScaffoldMessenger.of(
          GlobalVariables.navigatorKey!.currentContext!,
        ).showSnackBar(
          SnackBar(
            // behavior: SnackBarBehavior.floating,
            backgroundColor: ColorsConstants.defaultBlack,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            content: Text(
              "Couldn't load tournaments",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultWhite,
              ),
            ),
          ),
        );
        emit(
          UpdateIndex(
            matchLoading: state.matchLoading,
            tournamentLoading: false,
            tournaments: state.tournaments,
            currentIndex: state.currentIndex,
            showOptions: state.showOptions,
            matches: state.matches,
            user: state.user?.copyWith(unreadNotifications: 0),
            loading: false,
          ),
        );
      },
      (response) {
        if (response.success) {
          emit(
            UpdateIndex(
              matchLoading: state.matchLoading,
              tournamentLoading: false,
              tournaments: response.tournaments ?? [],
              currentIndex: state.currentIndex,
              showOptions: state.showOptions,
              matches: state.matches,
              user: state.user?.copyWith(unreadNotifications: 0),
              loading: false,
            ),
          );
        } else {
          emit(
            UpdateIndex(
              matchLoading: state.matchLoading,
              tournamentLoading: false,
              tournaments: state.tournaments,
              currentIndex: state.currentIndex,
              showOptions: state.showOptions,
              matches: state.matches,
              user: state.user?.copyWith(unreadNotifications: 0),
              loading: false,
            ),
          );
        }
      },
    );
  }

  addMatch(MatchEntity match) {
    state.matches.add(match);
    emit(
      UpdateIndex(
        matchLoading: state.matchLoading,
        tournamentLoading: state.tournamentLoading,
        tournaments: state.tournaments,
        currentIndex: state.currentIndex,
        showOptions: state.showOptions,
        matches: state.matches,
        user: state.user?.copyWith(unreadNotifications: 0),
        loading: state.loading,
      ),
    );
  }

  init(UserEntity? user) async {
    emit(
      UpdateIndex(
        tournaments: state.tournaments,
        matches: state.matches,
        currentIndex: 0,
        showOptions: false,
        user: user,
        loading: false,
        matchLoading: false,
        tournamentLoading: false,
      ),
    );

    if (user == null) {
      final dio = sl<Dio>();
      final cookieManager =
          dio.interceptors.firstWhere((i) => i is CookieManager)
              as CookieManager;

      final cookieJar = cookieManager.cookieJar;

      final uri = Uri.parse(
        "https://cricklo.onrender.com",
      ); // your API base URL
      final cookies = await cookieJar.loadForRequest(uri);

      if (cookies.isNotEmpty) {
        emit(
          UpdateIndex(
            tournaments: state.tournaments,
            matches: state.matches,
            currentIndex: 0,
            showOptions: false,
            user: user,
            loading: true,
            matchLoading: false,
            tournamentLoading: false,
          ),
        );
        final response = await _currentUserUsecase(NoParams());

        getUserMatches();
        response.fold(
          (_) async {
            GlobalVariables.setUser(user);
            emit(
              UpdateIndex(
                tournaments: state.tournaments,
                matches: state.matches,
                currentIndex: 0,
                showOptions: false,
                user: user,
                loading: false,
                matchLoading: state.matchLoading,
                tournamentLoading: state.tournamentLoading,
              ),
            );
          },
          (response) async {
            GlobalVariables.setUser(response);
            emit(
              UpdateIndex(
                tournaments: state.tournaments,
                matches: state.matches,
                currentIndex: 0,
                showOptions: false,
                user: response,
                loading: false,
                matchLoading: state.matchLoading,
                tournamentLoading: state.tournamentLoading,
              ),
            );
            emit(
              UpdateIndex(
                tournaments: state.tournaments,
                matches: state.matches,
                currentIndex: 0,
                showOptions: false,
                user: response,
                loading: false,
                matchLoading: state.matchLoading,
                tournamentLoading: state.tournamentLoading,
              ),
            );
          },
        );
      } else {
        GlobalVariables.setUser(user);
      }
    } else {
      GlobalVariables.setUser(user);
    }
  }

  goToTab(int index, BuildContext context) {
    if (index == 3 && state.user == null) {
      GoRouter.of(context).goNamed(Routes.loginPage);
    } else {
      emit(
        UpdateIndex(
          tournaments: state.tournaments,
          matches: state.matches,
          currentIndex: index,
          showOptions: false,
          user: state.user,
          matchLoading: state.matchLoading,
          tournamentLoading: state.tournamentLoading,
        ),
      );
    }
  }

  showOptions(AnimationController animationController) {
    if (!state.showOptions) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    emit(
      UpdateIndex(
        tournaments: state.tournaments,
        matches: state.matches,
        currentIndex: state.currentIndex,
        showOptions: !state.showOptions,
        user: state.user,
        matchLoading: state.matchLoading,
        tournamentLoading: state.tournamentLoading,
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/mainapp/data/usecases/get_current_user_usecase.dart';
import 'package:cricklo/features/mainapp/data/usecases/logout_usecase.dart';
import 'package:cricklo/injection_container.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'main_app_state.dart';

class MainAppCubit extends Cubit<MainAppState> {
  final GetCurrentUserUsecase _currentUserUsecase;
  final LogoutUsecase _logoutUsecase;

  MainAppCubit(this._currentUserUsecase, this._logoutUsecase)
    : super(UpdateIndex(currentIndex: 0, showOptions: false));

  logout(BuildContext context) async {
    emit(
      UpdateIndex(
        currentIndex: 0,
        showOptions: false,
        user: state.user,
        loading: true,
      ),
    );
    final response = await _logoutUsecase(NoParams());
    response.fold(
      (_) {
        emit(
          UpdateIndex(
            currentIndex: 0,
            showOptions: false,
            user: state.user,
            loading: false,
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
              currentIndex: 0,
              showOptions: false,
              user: null,
              loading: false,
            ),
          );
        } else {
          emit(
            UpdateIndex(
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

  init(UserEntity? user) async {
    emit(
      UpdateIndex(
        currentIndex: 0,
        showOptions: false,
        user: user,
        loading: false,
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
            currentIndex: 0,
            showOptions: false,
            user: user,
            loading: true,
          ),
        );
        final response = await _currentUserUsecase(NoParams());
        response.fold(
          (_) {
            GlobalVariables.setUser(user);
            emit(
              UpdateIndex(
                currentIndex: 0,
                showOptions: false,
                user: user,
                loading: false,
              ),
            );
          },
          (response) {
            GlobalVariables.setUser(response);
            print(GlobalVariables.user);
            emit(
              UpdateIndex(
                currentIndex: 0,
                showOptions: false,
                user: response,
                loading: false,
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
        UpdateIndex(currentIndex: index, showOptions: false, user: state.user),
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
        currentIndex: state.currentIndex,
        showOptions: !state.showOptions,
        user: state.user,
      ),
    );
  }
}

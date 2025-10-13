import 'package:bloc/bloc.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/mainapp/data/usecases/fetch_notifications_usecase.dart';
import 'package:cricklo/features/notifications/data/entities/team_response_invite_usecase_entity.dart';
import 'package:cricklo/features/notifications/data/usecases/team_response_invite_usecase.dart';
import 'package:cricklo/features/notifications/domain/entities/team_notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final FetchNotificationsUsecase _fetchNotifications;
  final TeamResponseInviteUsecase _teamResponseInviteUsecase;
  NotificationCubit(this._fetchNotifications, this._teamResponseInviteUsecase)
    : super(NotificationUpdate(loading: false, teamNotifications: []));

  init() async {
    emit(NotificationUpdate(loading: true, teamNotifications: []));
    await getNotifications();
  }

  Future<void> getNotifications() async {
    final response = await _fetchNotifications(NoParams());
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
        emit(NotificationUpdate(teamNotifications: [], loading: false));
      },
      (response) {
        if (response.success) {
          emit(
            NotificationUpdate(
              teamNotifications: response.teamNotifications,
              loading: false,
            ),
          );
        }
      },
    );
  }

  Future<void> teamInviteAction(
    TeamNotificationEntity team,
    String action,
  ) async {
    final response = await _teamResponseInviteUsecase(
      TeamResponseInviteUsecaseEntity(
        teamId: team.teamId,
        inviteId: team.inviteId,
        action: action,
      ),
    );
    state.teamNotifications.remove(team);
    emit(
      NotificationUpdate(
        teamNotifications: state.teamNotifications,
        loading: false,
      ),
    );
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
              "Couldn't perform action",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultWhite,
              ),
            ),
          ),
        );
        emit(NotificationUpdate(teamNotifications: [], loading: false));
      },
      (response) {
        if (response.success) {}
      },
    );
  }
}

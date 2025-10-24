import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/dummy_data.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:cricklo/features/tournament/data/entities/apply_tournament_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/entities/invite_moderators_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/entities/invite_teams_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/usecases/apply_tournament_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/get_tournament_details_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/invite_moderators_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/invite_teams_usecase.dart';
import 'package:cricklo/features/tournament/domain/entities/group_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';
import 'package:cricklo/features/tournament/presentation/widgets/user_teams_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'tournament_state.dart';

class TournamentCubit extends Cubit<TournamentState> {
  final InviteModeratorsUsecase _inviteModeratorsUsecase;
  final InviteTeamsUsecase _inviteTeamsUsecase;
  final ApplyTournamentUsecase _applyTournamentUsecase;
  final GetTournamentDetailsUsecase _getTournamentDetailsUsecase;
  TournamentCubit(
    this._inviteModeratorsUsecase,
    this._inviteTeamsUsecase,
    this._applyTournamentUsecase,
    this._getTournamentDetailsUsecase,
  ) : super(
        TournamentUpdate(
          tournamentEntity: null,
          selectedMainTab: 0,
          selectedStatsTab: 0,
          selectedStatsTabTableType: 0,
        ),
      );

  init(BuildContext context, TournamentEntity tournamentEntity) async {
    emit(state.copyWith(tournamentEntity: tournamentEntity, loading: true));
    final response = await _getTournamentDetailsUsecase(
      state.tournamentEntity!.id,
    );
    response.fold(
      (_) {
        WidgetDecider.showSnackBar(
          context,
          "Couldn't fetch tournament details",
        );
        emit(
          state.copyWith(
            loading: false,
            tournamentEntity: state.tournamentEntity,
          ),
        );
      },
      (response) {
        if (!response.success) {
          WidgetDecider.showSnackBar(
            context,
            response.errorMessage ?? "Couldn't fetch tournament details",
          );
          emit(
            state.copyWith(
              loading: false,
              tournamentEntity: state.tournamentEntity,
            ),
          );
        } else {
          emit(
            state.copyWith(
              loading: false,
              tournamentEntity: state.tournamentEntity!.copyWith(
                moderators: response.tournamentEntity!.moderators,
                venues: response.tournamentEntity!.venues,
                teams: response.tournamentEntity!.teams,
                groups: response.tournamentEntity!.groups,
                matches: response.tournamentEntity!.matches,
              ),
            ),
          );
        }
      },
    );
  }

  void changeMainTab(int index) {
    emit(state.copyWith(selectedMainTab: index));
  }

  void changeStatsTab(int index) {
    emit(state.copyWith(selectedStatsTab: index, selectedStatsTabTableType: 0));
  }

  void changeStatsTabTable(int index) {
    emit(state.copyWith(selectedStatsTabTableType: index));
  }

  Future<String?> showTeamSelectionSheet({
    required BuildContext context,
  }) async {
    final teamId = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorsConstants.defaultWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return UserTeamsBottomSheet();
      },
    );
    return teamId;
  }

  void applyTournament(BuildContext context) async {
    final teamId = await showTeamSelectionSheet(context: context);
    if (teamId != null) {
      emit(state.copyWith(applied: !state.applied));
      final response = await _applyTournamentUsecase(
        ApplyTournamentUsecaseEntity(
          teamId: teamId,
          tournamentId: state.tournamentEntity!.id,
        ),
      );
      response.fold(
        (_) {
          WidgetDecider.showSnackBar(context, "Couldn't send invites");
          emit(state.copyWith(applied: !state.applied));
        },
        (response) {
          if (!response.success) {
            WidgetDecider.showSnackBar(
              context,
              response.errorMessage ?? "Couldn't send invites",
            );
            emit(state.copyWith(applied: !state.applied));
          } else {}
        },
      );
    }
  }

  void addGroup() {
    state.tournamentEntity!.groups.add(
      GroupEntity(
        teams: [],
        name: "Group ${String.fromCharCode(65 + tournament.groups.length)}",
        matches: [],
      ),
    );
    emit(state.copyWith());
  }

  void removeGroup(int index) {
    state.tournamentEntity!.groups.removeAt(index);
    emit(state.copyWith());
  }

  void addTeamToGroup(List<TournamentTeamEntity> teams, int index) {
    state.tournamentEntity!.groups[index].teams.addAll(teams);
    emit(state.copyWith());
  }

  void inviteTeams(
    BuildContext context,
    List<TournamentTeamEntity> teams,
  ) async {
    state.tournamentEntity!.teams.addAll(teams);
    emit(state.copyWith());
    final response = await _inviteTeamsUsecase(
      InviteTeamsUsecaseEntity(
        teams: teams,
        tournamentId: state.tournamentEntity!.id,
      ),
    );
    response.fold(
      (_) {
        WidgetDecider.showSnackBar(context, "Couldn't send invites");
      },
      (response) {
        if (!response.success) {
          WidgetDecider.showSnackBar(context, "Couldn't send invites");
        }
      },
    );
  }

  void addModerator(
    BuildContext context,
    List<SearchUserEntity> moderators,
  ) async {
    state.tournamentEntity!.moderators.addAll(moderators);
    emit(state.copyWith());
    final response = await _inviteModeratorsUsecase(
      InviteModeratorsUsecaseEntity(
        users: moderators,
        tournamentId: state.tournamentEntity!.id,
      ),
    );
    response.fold(
      (_) {
        WidgetDecider.showSnackBar(context, "Couldn't send invites");
      },
      (response) {
        if (!response.success) {
          WidgetDecider.showSnackBar(context, "Couldn't send invites");
        }
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/follow/data/entities/follow_usecase_entity.dart';
import 'package:cricklo/features/follow/data/usecases/follow_usecase.dart';
import 'package:cricklo/features/follow/data/usecases/unfollow_usecase.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:cricklo/features/tournament/data/entities/add_team_to_group_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/entities/apply_tournament_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/entities/create_group_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/entities/edit_group_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/entities/invite_moderators_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/entities/invite_teams_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/entities/moderator_update_match_usecase_entity.dart';
import 'package:cricklo/features/tournament/data/usecases/add_team_to_group_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/apply_tournament_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/create_group_table_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/create_group_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/delete_group_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/edit_group_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/get_tournament_details_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/invite_moderators_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/invite_teams_usecase.dart';
import 'package:cricklo/features/tournament/data/usecases/moderator_update_match.dart';
import 'package:cricklo/features/tournament/data/usecases/remove_team_from_group_usecase.dart';
import 'package:cricklo/features/tournament/domain/entities/group_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';
import 'package:cricklo/features/tournament/presentation/widgets/user_teams_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'tournament_state.dart';

class TournamentCubit extends Cubit<TournamentState> {
  final InviteModeratorsUsecase _inviteModeratorsUsecase;
  final InviteTeamsUsecase _inviteTeamsUsecase;
  final ApplyTournamentUsecase _applyTournamentUsecase;
  final GetTournamentDetailsUsecase _getTournamentDetailsUsecase;
  final CreateGroupUsecase _createGroupUsecase;
  final AddTeamToGroupUsecase _addTeamToGroupUsecase;
  final DeleteGroupUsecase _deleteGroupUsecase;
  final EditGroupUsecase _editGroupUsecase;
  final FollowUsecase _followUsecase;
  final UnFollowUsecase _unFollowUsecase;
  final CreateGroupTableUsecase _createGroupTableUsecase;
  final RemoveTeamFromGroupUsecase _removeTeamFromGroupUsecase;
  final ModeratorUpdateMatchUsecase _updateMatchUsecase;
  int error = 0;
  TournamentCubit(
    this._inviteModeratorsUsecase,
    this._inviteTeamsUsecase,
    this._applyTournamentUsecase,
    this._getTournamentDetailsUsecase,
    this._createGroupUsecase,
    this._addTeamToGroupUsecase,
    this._deleteGroupUsecase,
    this._editGroupUsecase,
    this._followUsecase,
    this._unFollowUsecase,
    this._createGroupTableUsecase,
    this._removeTeamFromGroupUsecase,
    this._updateMatchUsecase,
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
                groupMatches: response.tournamentEntity!.groupMatches,
                playoffMatches: response.tournamentEntity!.playoffMatches,
                followers: response.tournamentEntity!.followers,
              ),
            ),
          );
        }
      },
    );
  }

  void followButton(BuildContext context) async {
    if (state.tournamentEntity!.userFollow) {
      state.tournamentEntity!.followers--;
    } else {
      state.tournamentEntity!.followers++;
    }
    state.tournamentEntity!.userFollow = !state.tournamentEntity!.userFollow;
    emit(state.copyWith());
    if (state.tournamentEntity!.userFollow) {
      final response = await _followUsecase(
        FollowUsecaseEntity(
          entityType: EntityType.tournament,
          entityId: state.tournamentEntity!.id,
        ),
      );
      response.fold(
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // behavior: SnackBarBehavior.floating,
              backgroundColor: ColorsConstants.defaultBlack,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              content: Text(
                "Something went wrong",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
            ),
          );
          state.tournamentEntity!.followers--;
          state.tournamentEntity!.userFollow =
              !state.tournamentEntity!.userFollow;
          emit(state.copyWith());
        },
        (response) {
          if (!response.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                // behavior: SnackBarBehavior.floating,
                backgroundColor: ColorsConstants.defaultBlack,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                content: Text(
                  "Something went wrong",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultWhite,
                  ),
                ),
              ),
            );
            state.tournamentEntity!.followers--;
            state.tournamentEntity!.userFollow =
                !state.tournamentEntity!.userFollow;
            emit(state.copyWith());
          }
        },
      );
    } else {
      final response = await _unFollowUsecase(
        FollowUsecaseEntity(
          entityType: EntityType.tournament,
          entityId: state.tournamentEntity!.id,
        ),
      );
      response.fold((_) {}, (response) {
        if (!response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // behavior: SnackBarBehavior.floating,
              backgroundColor: ColorsConstants.defaultBlack,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              content: Text(
                "Something went wrong",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
            ),
          );
          state.tournamentEntity!.followers++;
          state.tournamentEntity!.userFollow =
              !state.tournamentEntity!.userFollow;
          emit(state.copyWith());
        }
      });
    }
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

  Future<bool> updateMatchUsecase(
    BuildContext context,
    String matchId,
    Map<String, dynamic> scorer,
    String venueId,
    DateTime date,
    TimeOfDay time,
  ) async {
    final match = state.tournamentEntity!.groupMatches
        .where((e) => e.matchID == matchId)
        .first;
    match.location = state.tournamentEntity!.venues
        .where((e) => e.id == venueId)
        .first;
    match.scorer = scorer;
    final previousDateTime = match.dateAndTime;
    match.dateAndTime = Methods.combineDateAndTime(date, time);
    emit(state.copyWith());
    final response = await _updateMatchUsecase(
      ModeratorUpdateMatchUsecaseEntity(
        tournamentId: state.tournamentEntity!.id,
        matchId: matchId,
        venueId: venueId,
        scorerId: scorer["profileId"],
        date: date,
        time: time,
      ),
    );
    final res = response.fold(
      (_) {
        WidgetDecider.showSnackBar(context, "Couldn't update match");
        match.location = null;
        match.scorer = {};
        match.dateAndTime = previousDateTime;
        emit(state.copyWith());
        return false;
      },
      (response) {
        if (!response.success) {
          WidgetDecider.showSnackBar(
            context,
            response.errorMessage ?? "Couldn't update match",
          );
          match.location = null;
          match.scorer = {};
          match.dateAndTime = previousDateTime;
          emit(state.copyWith());
          return false;
        } else {
          return true;
        }
      },
    );
    return res;
  }

  void editGroup(BuildContext context, int index) async {
    final TextEditingController controller = TextEditingController(
      text: state.tournamentEntity!.groups[index].name,
    );

    final newName = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: ColorsConstants.defaultWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Edit Group Name",
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 16,
              color: ColorsConstants.accentOrange,
              letterSpacing: -0.8,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLength: 12,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: "Enter new name (max 5 chars)",
              counterText: "",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsConstants.accentOrange),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsConstants.accentOrange),
              ),
            ),
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 12,
              color: ColorsConstants.defaultBlack,
              letterSpacing: -0.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(ctx).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsConstants.accentOrange,
                foregroundColor: ColorsConstants.defaultWhite,
                disabledBackgroundColor: ColorsConstants.onSurfaceGrey,
              ),
              onPressed: () {
                if (controller.text.trim().isEmpty) return;
                Navigator.pop(context, controller.text.trim());
              },
              child: Text(
                "Update",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 12,
                  letterSpacing: -0.5,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (newName != null && newName.isNotEmpty) {
      final oldName = state.tournamentEntity!.groups[index].name;
      state.tournamentEntity!.groups[index].name = newName;
      emit(state.copyWith());
      final response = await _editGroupUsecase(
        EditGroupUsecaseEntity(
          oldGroupName: oldName,
          newGroupName: newName,
          tournamentId: state.tournamentEntity!.id,
        ),
      );
      response.fold(
        (_) {
          WidgetDecider.showSnackBar(context, "Couldn't edit group name");
        },
        (response) {
          if (!response.success) {
            WidgetDecider.showSnackBar(
              context,
              response.errorMessage ?? "Couldn't edit group name",
            );
          } else {}
        },
      );
    }
  }

  void addGroup(BuildContext context) async {
    final group = GroupEntity(
      teams: [],
      name:
          "Group ${String.fromCharCode(65 + state.tournamentEntity!.groups.length)}",
      matches: [],
    );
    state.tournamentEntity!.groups.add(group);
    emit(state.copyWith());
    final response = await _createGroupUsecase(
      CreateGroupUsecaseEntity(
        groupName: group.name,
        tournamentId: state.tournamentEntity!.id,
      ),
    );
    response.fold(
      (_) {
        WidgetDecider.showSnackBar(context, "Couldn't add group");
        state.tournamentEntity!.groups.removeLast();
        emit(state.copyWith());
      },
      (response) {
        if (!response.success) {
          WidgetDecider.showSnackBar(
            context,
            response.errorMessage ?? "Couldn't add group",
          );
          state.tournamentEntity!.groups.removeLast();
          emit(state.copyWith());
        } else {}
      },
    );
  }

  void removeGroup(BuildContext context, int index) async {
    final group = state.tournamentEntity!.groups[index];
    state.tournamentEntity!.groups.removeAt(index);

    emit(state.copyWith());
    final response = await _deleteGroupUsecase(
      CreateGroupUsecaseEntity(
        groupName: group.name,
        tournamentId: state.tournamentEntity!.id,
      ),
    );
    response.fold(
      (_) {
        WidgetDecider.showSnackBar(context, "Couldn't delete group");
        state.tournamentEntity!.groups.removeLast();
        emit(state.copyWith());
      },
      (response) {
        if (!response.success) {
          WidgetDecider.showSnackBar(
            context,
            response.errorMessage ?? "Couldn't delete group",
          );
          state.tournamentEntity!.groups.insert(index, group);
          emit(state.copyWith());
        } else {}
      },
    );
  }

  void addTeamToGroupRemote(
    BuildContext context,
    String team,
    String groupName,
  ) async {}

  void addTeamToGroup(
    BuildContext context,
    List<TournamentTeamEntity> teams,
    int index,
  ) async {
    bool hasError = false;
    state.tournamentEntity!.groups[index].teams.addAll(teams);
    emit(state.copyWith());
    for (var team in teams) {
      if (hasError) break;
      final response = await _addTeamToGroupUsecase(
        AddTeamToGroupUsecaseEntity(
          groupName: state.tournamentEntity!.groups[index].name,
          teamId: team.id,
          tournamentId: state.tournamentEntity!.id,
        ),
      );
      response.fold(
        (_) {
          hasError = true;
          WidgetDecider.showSnackBar(context, "Couldn't add team to group");
          state.tournamentEntity!.groups[index].teams.removeLast();
          emit(state.copyWith());
        },
        (response) {
          if (!response.success) {
            hasError = true;
            WidgetDecider.showSnackBar(
              context,
              response.errorMessage ?? "Couldn't add team to group",
            );
            state.tournamentEntity!.groups[index].teams.removeLast();
            emit(state.copyWith());
          } else {}
        },
      );
    }
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

  void removeTeamFromGroup(
    BuildContext context,
    int index,
    TournamentTeamEntity team,
  ) async {
    final response = await showDialog(
      context: context,
      barrierDismissible: false, // prevent accidental close
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              backgroundColor: ColorsConstants.defaultWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                "Remove Team",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Remove Team From Group?",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsConstants.accentOrange,
                        foregroundColor: ColorsConstants.defaultWhite,
                      ),
                      onPressed: () {
                        GoRouter.of(ctx).pop(true);
                      },
                      child: Text(
                        "Yes",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(ctx).pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(24),
                          side: BorderSide(color: ColorsConstants.accentOrange),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
    if (response as bool? ?? false) {
      state.tournamentEntity!.groups[index].teams.remove(team);
      emit(state.copyWith());
      final response = await _removeTeamFromGroupUsecase(
        AddTeamToGroupUsecaseEntity(
          groupName: state.tournamentEntity!.groups[index].name,
          teamId: team.id,
          tournamentId: state.tournamentEntity!.id,
        ),
      );
      response.fold(
        (_) {
          WidgetDecider.showSnackBar(
            context,
            "Couldn't remove team from group",
          );
          state.tournamentEntity!.groups[index].teams.removeLast();
          emit(state.copyWith());
        },
        (response) {
          if (!response.success) {
            WidgetDecider.showSnackBar(
              context,
              response.errorMessage ?? "Couldn't remove team from group",
            );
            state.tournamentEntity!.groups[index].teams.removeLast();
            emit(state.copyWith());
          } else {}
        },
      );
    }
  }

  void createKnockoutMatches(BuildContext context) async {
    final response = await showDialog(
      context: context,
      barrierDismissible: false, // prevent accidental close
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              backgroundColor: ColorsConstants.defaultWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                "Create Matches",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Number of Groups:",
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${state.tournamentEntity!.groups.length}",
                        style: TextStyles.poppinsBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.8,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "You cannot edit groups after this.",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsConstants.accentOrange,
                        foregroundColor: ColorsConstants.defaultWhite,
                      ),
                      onPressed: () {
                        GoRouter.of(ctx).pop(true);
                      },
                      child: Text(
                        "Lock Groups & Create Matches",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(ctx).pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(24),
                          side: BorderSide(color: ColorsConstants.accentOrange),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
    if ((response as bool? ?? false)) {
      final response = await _createGroupTableUsecase(
        state.tournamentEntity!.id,
      );
      response.fold(
        (_) {
          state.tournamentEntity!.groups.clear();
          emit(state.copyWith());
          WidgetDecider.showSnackBar(context, "Couldn't create groups");
        },
        (response) {
          if (!response.success) {
            WidgetDecider.showSnackBar(context, "Couldn't create groups");
          } else {
            for (var group in state.tournamentEntity!.groups) {
              group.matches.addAll(response.groupMatches[group.name]!);
              state.tournamentEntity!.groupMatches.addAll(
                response.groupMatches[group.name]!,
              );
            }
            state.tournamentEntity!.playoffMatches.addAll(response.playoffs);
            emit(state.copyWith());
          }
        },
      );
    }
  }

  void createLeaguePointsTable(BuildContext context) async {
    final response = await showDialog(
      context: context,
      barrierDismissible: false, // prevent accidental close
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              backgroundColor: ColorsConstants.defaultWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                "Create Points Table",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.8,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Number of Participating Teams:",
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${state.tournamentEntity!.teams.where((e) => e.inviteStatus == InviteStatus.accepted).length}",
                        style: TextStyles.poppinsBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.8,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "You cannot add more teams after points table is created",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 12,
                      letterSpacing: -0.5,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsConstants.accentOrange,
                        foregroundColor: ColorsConstants.defaultWhite,
                      ),
                      onPressed: () {
                        GoRouter.of(ctx).pop(true);
                      },
                      child: Text(
                        "Lock Teams & Create Matches",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(ctx).pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(24),
                          side: BorderSide(color: ColorsConstants.accentOrange),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
    if ((response as bool? ?? false)) {
      state.tournamentEntity!.groups.add(
        GroupEntity(
          teams: state.tournamentEntity!.teams
              .where((e) => e.inviteStatus == InviteStatus.accepted)
              .toList(),
          name: "League Group",
          matches: [],
        ),
      );
      emit(state.copyWith());
      final response = await _createGroupTableUsecase(
        state.tournamentEntity!.id,
      );
      response.fold(
        (_) {
          state.tournamentEntity!.groups.clear();
          emit(state.copyWith());
          WidgetDecider.showSnackBar(context, "Couldn't send invites");
        },
        (response) {
          if (!response.success) {
            WidgetDecider.showSnackBar(context, "Couldn't send invites");
          } else {
            state.tournamentEntity!.groups.last.matches.addAll(
              response.groupMatches["League Group"]!,
            );
            state.tournamentEntity!.groupMatches.addAll(
              response.groupMatches["League Group"]!,
            );
            state.tournamentEntity!.playoffMatches.addAll(response.playoffs);
            emit(state.copyWith());
          }
        },
      );
    }
  }
}

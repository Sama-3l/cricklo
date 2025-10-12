import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/matches/data/entities/create_match_usecase_entity.dart';
import 'package:cricklo/features/matches/data/usecases/create_match_usecase.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'create_match_state.dart';

class CreateMatchCubit extends Cubit<CreateMatchState> {
  final CreateMatchUsecase _createMatchUsecase;

  CreateMatchCubit(this._createMatchUsecase) : super(CreateMatchInitial());

  createMatch(
    BuildContext context,
    TeamEntity teamA,
    TeamEntity teamB,
    PlayerEntity scorer,
    LocationEntity location,
    DateTime date,
    TimeOfDay time,
    String format,
    int overs,
    Function(MatchEntity matchEntity) onComplete,
  ) async {
    final response = await _createMatchUsecase(
      CreateMatchUsecaseEntity(
        date: date,
        time: time,
        overs: overs,
        matchType: format,
        teamA: teamA.uuid,
        teamB: teamB.uuid,
        location: location,
        scorer: scorer.id,
      ),
    );
    response.fold((_) {}, (response) {
      if (response.success) {
        final MatchEntity matchEntity = MatchEntity(
          matchID: response.matchId,
          dateAndTime: Methods.combineDateAndTime(date, time),
          overs: overs,
          matchType: MatchType.values.where((e) => e.matchType == format).first,
          teamA: teamA,
          teamB: teamB,
          location: location,
          scorer: scorer,
        );
        onComplete(matchEntity);
        GoRouter.of(context).pop();
      }
    });
  }
}

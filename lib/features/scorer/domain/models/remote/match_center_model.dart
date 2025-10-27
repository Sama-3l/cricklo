// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/innings_model.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_scorer_model.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_team_model.dart';

class MatchCenterModel {
  final String matchID;
  final DateTime dateAndTime;
  final int overs;
  final MatchType matchType;
  final LocationModel location;
  final String? tossWinner; // TeamID
  final TossChoice? tossChoice;
  String? winner;
  bool abandoned;
  final DateTime? endDateTime;
  final MatchTeamModel teamA;
  final MatchTeamModel teamB;
  final MatchScorerModel scorer;
  final List<InningsModel> innings;

  MatchCenterModel({
    required this.matchID,
    required this.dateAndTime,
    required this.overs,
    required this.matchType,
    required this.teamA,
    required this.teamB,
    required this.location,
    required this.scorer,
    this.tossWinner,
    this.tossChoice,
    this.winner,
    this.endDateTime,
    this.abandoned = false,
    required this.innings,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'matchID': matchID,
      'dateAndTime': dateAndTime.toIso8601String(),
      'overs': overs,
      'matchType': matchType.matchType,
      'location': location.toJson(),
      'tossWinner': tossWinner,
      'tossChoice': tossChoice?.name,
      'winner': winner,
      'abandoned': abandoned,
      'endDateTime': endDateTime?.toIso8601String(),
      'teamA': teamA.toJson(),
      'teamB': teamB.toJson(),
      'scorer': scorer.toJson(),
      'innings': innings.map((x) => x.toJson()).toList(),
    };
  }

  MatchCenterEntity toEntity() {
    final teamAEntity = teamA.toEntity();
    final teamBEntity = teamB.toEntity();
    return MatchCenterEntity(
      matchID: matchID,
      dateAndTime: dateAndTime,
      overs: overs,
      matchType: matchType,
      location: location.toEntity(),
      tossWinner: tossWinner,
      tossChoice: tossChoice,
      winner: winner,
      abandoned: abandoned,
      endDateTime: endDateTime,
      teamA: teamAEntity,
      teamB: teamBEntity,
      scorer: scorer.toEntity(),
      innings: innings
          .map((x) => x.toEntity(teamAEntity, teamBEntity))
          .toList(),
    );
  }

  factory MatchCenterModel.fromEntity(MatchCenterEntity entity) {
    return MatchCenterModel(
      matchID: entity.matchID,
      dateAndTime: entity.dateAndTime,
      overs: entity.overs,
      matchType: entity.matchType,
      location: LocationModel.fromEntity(entity.location),
      tossWinner: entity.tossWinner,
      tossChoice: entity.tossChoice,
      winner: entity.winner,
      abandoned: entity.abandoned,
      endDateTime: entity.endDateTime,
      teamA: MatchTeamModel.fromEntity(entity.teamA),
      teamB: MatchTeamModel.fromEntity(entity.teamB),
      scorer: MatchScorerModel.fromEntity(entity.scorer),
      innings: entity.innings.map((x) => InningsModel.fromEntity(x)).toList(),
    );
  }

  factory MatchCenterModel.fromJson(Map<String, dynamic> map) {
    final teamA = MatchTeamModel.fromJson(map['teamA'] as Map<String, dynamic>);
    final teamB = MatchTeamModel.fromJson(map['teamB'] as Map<String, dynamic>);
    final utcDateAndTime = DateTime.parse(map['dateAndTime'] as String);
    final dateAndTime = DateTime(
      utcDateAndTime.year,
      utcDateAndTime.month,
      utcDateAndTime.day,
      utcDateAndTime.hour,
      utcDateAndTime.minute,
      utcDateAndTime.second,
    );
    final utcEndDateAndTime = map['endDateAndTime'] == null
        ? null
        : DateTime.parse(map['endDateAndTime'] as String);

    final endDateAndTime = utcEndDateAndTime == null
        ? null
        : DateTime(
            utcEndDateAndTime.year,
            utcEndDateAndTime.month,
            utcEndDateAndTime.day,
            utcEndDateAndTime.hour,
            utcEndDateAndTime.minute,
            utcEndDateAndTime.second,
          );
    // print(map['matchID'] as String);
    // print(dateAndTime);
    // print(map['overs'] as int);
    // print(
    //   MatchType.values
    //       .where(
    //         (e) =>
    //             e.matchType.toUpperCase() ==
    //             (map['matchType'] as String).toUpperCase(),
    //       )
    //       .first,
    // );
    // print(LocationModel.fromJson(map['location']));
    // print(map['tossWinner'] as String?);
    // print(
    //   map['tossChoice'] != null
    //       ? TossChoice.values.where((e) => e.name == map['tossChoice']).first
    //       : null,
    // );
    // print(map['winner'] as String?);
    // print(map['abandoned'] as bool);
    // print(endDateAndTime);
    // print(teamA);
    // print(teamB);
    // print(MatchScorerModel.fromMap(map['scorer'] as Map<String, dynamic>));
    // print(
    //   (map['innings'] as List<dynamic>)
    //       .map<InningsModel>((x) => InningsModel.fromJson(x, teamA, teamB))
    //       .toList(),
    // );
    return MatchCenterModel(
      matchID: map['matchID'] as String,
      dateAndTime: dateAndTime,
      overs: map['overs'] as int,
      matchType: MatchType.values
          .where(
            (e) =>
                e.matchType.toUpperCase() ==
                (map['matchType'] as String).toUpperCase(),
          )
          .first,
      location: LocationModel.fromJson(map['location']),
      tossWinner: map['tossWinner'] as String?,
      tossChoice: map['tossChoice'] != null
          ? TossChoice.values.where((e) => e.name == map['tossChoice']).first
          : null,
      winner: map['winner'] as String?,
      abandoned: map['abandoned'] as bool,
      endDateTime: endDateAndTime,
      teamA: teamA,
      teamB: teamB,
      scorer: MatchScorerModel.fromMap(map['scorer'] as Map<String, dynamic>),
      innings: (map['innings'] as List<dynamic>)
          .map<InningsModel>((x) => InningsModel.fromJson(x, teamA, teamB))
          .toList(),
    );
  }
}

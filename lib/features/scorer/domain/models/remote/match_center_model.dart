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
      'dateAndTime': dateAndTime.millisecondsSinceEpoch,
      'overs': overs,
      'matchType': matchType.matchType,
      'location': location.toJson(),
      'tossWinner': tossWinner,
      'tossChoice': tossChoice?.name,
      'winner': winner,
      'abandoned': abandoned,
      'endDateTime': endDateTime?.millisecondsSinceEpoch,
      'teamA': teamA.toJson(),
      'teamB': teamB.toJson(),
      'scorer': scorer.toJson(),
      'innings': innings.map((x) => x.toJson()).toList(),
    };
  }

  MatchCenterEntity toEntity() {
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
      teamA: teamA.toEntity(),
      teamB: teamB.toEntity(),
      scorer: scorer.toEntity(),
      innings: innings.map((x) => x.toEntity()).toList(),
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

  factory MatchCenterModel.fromMap(Map<String, dynamic> map) {
    final teamA = MatchTeamModel.fromJson(map['teamA'] as Map<String, dynamic>);
    final teamB = MatchTeamModel.fromJson(map['teamA'] as Map<String, dynamic>);
    final utcTime = DateTime.parse(map['dateAndTime'] as String);
    final dateAndTime = DateTime(
      utcTime.year,
      utcTime.month,
      utcTime.day,
      utcTime.hour,
      utcTime.minute,
      utcTime.second,
    );
    final utcEndDateAndTime = map['endDateAndTime'] == null
        ? null
        : DateTime.parse(map['endDateAndTime'] as String);

    final endDateAndTime = utcEndDateAndTime == null
        ? null
        : DateTime(
            utcTime.year,
            utcTime.month,
            utcTime.day,
            utcTime.hour,
            utcTime.minute,
            utcTime.second,
          );
    return MatchCenterModel(
      matchID: map['matchID'] as String,
      dateAndTime: dateAndTime,
      overs: map['overs'] as int,
      matchType: MatchType.values
          .where((e) => e.matchType == map['matchType'])
          .first,
      location: LocationModel.fromJson(map['location'] as Map<String, dynamic>),
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
          .map<InningsModel>(
            (x) =>
                InningsModel.fromJson(x as Map<String, dynamic>, teamA, teamB),
          )
          .toList(),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/matches/domain/models/remote/overall_score_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';

class MatchModel {
  final String matchID;
  final DateTime dateAndTime;
  final int overs;
  final MatchType matchType;
  final TeamModel teamA;
  bool abandoned;
  bool draw;
  final TeamModel teamB;
  final LocationModel location;
  final Map<String, dynamic> scorer;
  final String? tossWinner; // TeamID
  final TossChoice? tossChoice;
  String? winner;
  final OverallScoreModel? teamAScore;
  final OverallScoreModel? teamBScore;
  final DateTime? endDateTime;

  MatchModel({
    required this.matchID,
    required this.dateAndTime,
    required this.overs,
    this.abandoned = false,
    required this.matchType,
    required this.teamA,
    required this.teamB,
    required this.location,
    required this.scorer,
    this.draw = false,
    this.tossWinner,
    this.tossChoice,
    this.winner,
    this.teamAScore,
    this.teamBScore,
    this.endDateTime,
  });

  MatchModel copyWith({
    String? id,
    String? matchID,
    DateTime? dateAndTime,
    DateTime? endDateTime,
    int? overs,
    MatchType? matchType,
    TeamModel? teamA,
    TeamModel? teamB,
    bool? abandoned,
    bool? draw,
    LocationModel? location,
    Map<String, dynamic>? scorer,
  }) {
    return MatchModel(
      matchID: matchID ?? this.matchID,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      endDateTime: endDateTime ?? this.endDateTime,
      overs: overs ?? this.overs,
      matchType: matchType ?? this.matchType,
      teamA: teamA ?? this.teamA,
      draw: draw ?? this.draw,
      teamB: teamB ?? this.teamB,
      location: location ?? this.location,
      scorer: scorer ?? this.scorer,
      abandoned: abandoned ?? this.abandoned,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'matchID': matchID,
      'dateAndTime': dateAndTime.millisecondsSinceEpoch,
      'overs': overs,
      'matchType': matchType.matchType,
      'teamA': teamA.toJson(),
      'abandoned': abandoned,
      'teamB': teamB.toJson(),
      'location': location.toJson(),
      'scorer': scorer,
      'draw': draw,
      'tossWinner': tossWinner,
      'tossChoice': tossChoice?.name,
      'winner': winner,
      'teamAScore': teamAScore?.toJson(),
      'teamBScore': teamBScore?.toJson(),
      'endDateTime': endDateTime?.millisecondsSinceEpoch,
    };
  }

  MatchEntity toEntity() {
    return MatchEntity(
      matchID: matchID,
      dateAndTime: dateAndTime,
      overs: overs,
      matchType: matchType,
      teamA: teamA.toEntity(),
      draw: draw,
      abandoned: abandoned,
      teamB: teamB.toEntity(),
      location: location.toEntity(),
      scorer: scorer,
      tossWinner: tossWinner,
      tossChoice: tossChoice,
      winner: winner,
      teamAScore: teamAScore?.toEntity(),
      teamBScore: teamBScore?.toEntity(),
      endDateTime: endDateTime,
    );
  }

  factory MatchModel.fromJson(Map<String, dynamic> map) {
    MatchType matchType = MatchType.t10;
    final format = map["matchType"] as String?;
    if (format != null) {
      switch (format) {
        case "T10":
          matchType = MatchType.t10;
          break;
        case "T20":
          matchType = MatchType.t20;
          break;
        case "T30":
          matchType = MatchType.t30;
          break;
        case "ODI":
          matchType = MatchType.odi;
          break;
        case "Test":
          matchType = MatchType.test;
          break;
        default:
          matchType = MatchType.t20;
          break;
      }
    }

    TossChoice? tossChoice;
    final choice = map["tossChoice"] as String?;
    switch (choice?.toLowerCase()) {
      case "batting":
        tossChoice = TossChoice.batting;
        break;
      case "bowling":
        tossChoice = TossChoice.bowling;
        break;
      default:
        tossChoice = null;
    }

    final teamA = TeamModel.fromJson(
      map['teamAEntity'] as Map<String, dynamic>,
    );

    final teamB = TeamModel.fromJson(
      map['teamBEntity'] as Map<String, dynamic>,
    );
    final utcTime = DateTime.parse(map['dateAndTime'] as String);
    final dateAndTime = DateTime(
      utcTime.year,
      utcTime.month,
      utcTime.day,
      utcTime.hour,
      utcTime.minute,
      utcTime.second,
    );
    return MatchModel(
      matchID: map['matchId'] as String,
      dateAndTime: dateAndTime,
      overs: map['overs'] as int,
      draw: map['draw'] as bool? ?? false,
      matchType: matchType,
      teamA: teamA,
      abandoned: map['abandoned'] as bool? ?? false,
      teamB: teamB,
      location: LocationModel.fromJson(map['location'] as Map<String, dynamic>),
      scorer: map['scorerEntity'] as Map<String, dynamic>,
      tossWinner: map['tossWinner'] != null
          ? map['tossWinner'] as String
          : null,
      tossChoice: tossChoice,
      winner: map['winner'] != null ? map['winner'] as String : null,
      teamAScore: map['teamAScore'] != null
          ? OverallScoreModel.fromJson(
              map['teamAScore'] as Map<String, dynamic>,
              teamA,
              teamB,
            )
          : null,
      teamBScore: map['teamBScore'] != null
          ? OverallScoreModel.fromJson(
              map['teamBScore'] as Map<String, dynamic>,
              teamA,
              teamB,
            )
          : null,
      endDateTime: map['endDateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDateTime'] as int)
          : null,
    );
  }
}

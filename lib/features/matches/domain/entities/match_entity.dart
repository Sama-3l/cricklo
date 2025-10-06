// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';

class MatchEntity {
  final String id;
  final String matchID;
  final String name;
  final DateTime dateAndTime;
  final String overs;
  final MatchType matchType;
  final TeamEntity teamA;
  final TeamEntity teamB;
  final LocationEntity location;
  final PlayerEntity scorer1;
  final PlayerEntity scorer2;

  MatchEntity({
    required this.id,
    required this.matchID,
    required this.name,
    required this.dateAndTime,
    required this.overs,
    required this.matchType,
    required this.teamA,
    required this.teamB,
    required this.location,
    required this.scorer1,
    required this.scorer2,
  });

  MatchEntity copyWith({
    String? id,
    String? matchID,
    String? name,
    DateTime? dateAndTime,
    String? overs,
    MatchType? matchType,
    TeamEntity? teamA,
    TeamEntity? teamB,
    LocationEntity? location,
    PlayerEntity? scorer1,
    PlayerEntity? scorer2,
  }) {
    return MatchEntity(
      id: id ?? this.id,
      matchID: matchID ?? this.matchID,
      name: name ?? this.name,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      overs: overs ?? this.overs,
      matchType: matchType ?? this.matchType,
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      location: location ?? this.location,
      scorer1: scorer1 ?? this.scorer1,
      scorer2: scorer2 ?? this.scorer2,
    );
  }
}

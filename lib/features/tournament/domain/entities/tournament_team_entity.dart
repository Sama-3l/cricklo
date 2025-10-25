// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_player_entity.dart';

class TournamentTeamEntity {
  final String id;
  final String name;
  final String teamLogo;
  final String teamBanner;
  final List<TournamentPlayerEntity> players;
  final LocationEntity location;
  final int matches;
  final int won;
  final int loss;
  final int points;
  final double nrr;
  final bool eliminated;
  final InviteStatus inviteStatus;

  TournamentTeamEntity({
    required this.id,
    required this.name,
    required this.teamLogo,
    required this.teamBanner,
    required this.players,
    required this.location,
    required this.matches,
    required this.won,
    required this.loss,
    required this.points,
    required this.nrr,
    this.eliminated = false,
    required this.inviteStatus,
  });

  TournamentTeamEntity copyWith({
    String? id,
    String? name,
    String? teamLogo,
    String? teamBanner,
    List<TournamentPlayerEntity>? players,
    LocationEntity? location,
    int? matches,
    int? won,
    int? loss,
    int? points,
    double? nrr,
    bool? eliminated,
    InviteStatus? inviteStatus,
  }) {
    return TournamentTeamEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      teamLogo: teamLogo ?? this.teamLogo,
      teamBanner: teamBanner ?? this.teamBanner,
      players: players ?? this.players,
      location: location ?? this.location,
      matches: matches ?? this.matches,
      won: won ?? this.won,
      loss: loss ?? this.loss,
      points: points ?? this.points,
      nrr: nrr ?? this.nrr,
      eliminated: eliminated ?? this.eliminated,
      inviteStatus: inviteStatus ?? this.inviteStatus,
    );
  }

  TeamEntity toTeamEntity() {
    return TeamEntity(
      uuid: id,
      followers: 0,
      id: id,
      name: name,
      inviteStatus: inviteStatus.title,
      teamLogo: teamLogo,
      teamBanner: teamBanner,
      players: [],
      location: location,
    );
  }
}

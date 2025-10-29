// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_player_model.dart';

class TournamentTeamModel {
  final String id;
  final String name;
  final String teamLogo;
  final String teamBanner;
  final List<TournamentPlayerModel> players;
  final LocationModel location;
  final int matches;
  final int won;
  final int loss;
  final int points;
  final String nrr;
  final bool eliminated;
  final InviteStatus inviteStatus;
  TournamentTeamModel({
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

  TournamentTeamEntity toEntity() {
    return TournamentTeamEntity(
      matches: matches,
      won: won,
      loss: loss,
      points: points,
      nrr: nrr,
      eliminated: eliminated,
      inviteStatus: inviteStatus,
      id: id,
      name: name,
      teamLogo: teamLogo,
      teamBanner: teamBanner,
      players: players.map((e) => e.toEntity()).toList(),
      location: location.toEntity(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'matches': matches,
      'won': won,
      'loss': loss,
      'points': points,
      'nrr': nrr,
      'eliminated': eliminated,
      'inviteStatus': inviteStatus,
      'id': id,
      'name': name,
      'teamLogo': teamLogo,
      'teamBanner': teamBanner,
      'players': players.map((e) => e.toJson()).toList(),
      'location': location.toJson(),
    };
  }

  factory TournamentTeamModel.fromJson(Map<String, dynamic> map) {
    return TournamentTeamModel(
      matches: map['matchesPlayed'] as int? ?? 0,
      won: map['wins'] as int? ?? 0,
      loss: map['losses'] as int? ?? 0,
      points: map['points'] as int? ?? 0,
      nrr: map['nrr'] as String,
      eliminated: map['eliminated'] as bool? ?? false,
      inviteStatus: InviteStatus.values.firstWhere(
        (e) => e.title.toUpperCase() == map['inviteStatus'],
      ),
      id: map['teamId'] as String,
      name: map['teamName'] as String,
      teamLogo: map['teamLogo'] as String,
      teamBanner: map['teamBanner'] as String,
      players: [],
      location: map["location"] == null
          ? LocationModel(area: "", city: "", state: "", lat: 0, lng: 0)
          : LocationModel.fromJson(map["location"] as Map<String, dynamic>),
    );
  }

  factory TournamentTeamModel.fromEntity(TournamentTeamEntity entity) {
    return TournamentTeamModel(
      matches: entity.matches,
      won: entity.won,
      loss: entity.loss,
      points: entity.points,
      nrr: entity.nrr,
      eliminated: entity.eliminated,
      inviteStatus: entity.inviteStatus,
      id: entity.id,
      name: entity.name,
      teamLogo: entity.teamLogo,
      teamBanner: entity.teamBanner,
      players: entity.players
          .map((e) => TournamentPlayerModel.fromEntity(e))
          .toList(),
      location: LocationModel.fromEntity(entity.location),
    );
  }
}

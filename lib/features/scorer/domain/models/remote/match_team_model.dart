// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/scorer/domain/entities/match_team_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_player_model.dart';
import 'package:cricklo/features/scorer/domain/models/remote/partnership_model.dart';

class MatchTeamModel {
  final String id;
  final String name;
  final String teamLogo;
  final String teamBanner;
  MatchPlayerModel? onStrike;
  List<MatchPlayerModel?> currBatsmen;
  MatchPlayerModel? bowler;
  final List<MatchPlayerModel> players;
  Map<int, MatchPlayerModel> battingOrder;
  final List<PartnershipModel> partnerships;
  final LocationModel location;

  MatchTeamModel({
    required this.id,
    required this.name,
    required this.teamLogo,
    required this.teamBanner,
    this.onStrike,
    required this.currBatsmen,
    this.bowler,
    required this.players,
    required this.battingOrder,
    required this.partnerships,
    required this.location,
  });

  /// SENDING ID ONLY FOR ONSTRIKE, CURRBATSMAN, BOWLER
  /// CHECK IF THIS WORKS OR NOT WHILE PARSING
  /// I DON'T THINK WE NEED INDIVIDUAL STATS HERE AND CAN SIMPLY
  /// FETCH FROM PLAYERS LIST

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'teamLogo': teamLogo,
      'teamBanner': teamBanner,
      'onStrike': onStrike?.playerId,
      'currBatsmen': currBatsmen.map((x) => x?.playerId).toList(),
      'bowler': bowler?.playerId,
      'players': players.map((x) => x.toJson()).toList(),
      'battingOrder': battingOrder.map(
        (key, value) => MapEntry(key.toString(), value.toJson()),
      ),

      'partnerships': partnerships.map((x) => x.toJson()).toList(),
      'location': location.toJson(),
    };
  }

  MatchTeamEntity toEntity() {
    return MatchTeamEntity(
      currBatsmen: currBatsmen.map((e) => e?.toEntity()).toList(),
      id: id,
      name: name,
      teamLogo: teamLogo,
      teamBanner: teamBanner,
      players: players.map((e) => e.toEntity()).toList(),
      location: location.toEntity(),
      battingOrder: battingOrder.map((e, v) => MapEntry(e, v.toEntity())),
      partnerships: partnerships.map((e) => e.toEntity()).toList(),
    );
  }

  factory MatchTeamModel.fromEntity(MatchTeamEntity entity) {
    return MatchTeamModel(
      currBatsmen: entity.currBatsmen
          .map<MatchPlayerModel?>(
            (e) => e == null ? null : MatchPlayerModel.fromEntity(e),
          )
          .toList(),
      id: entity.id,
      name: entity.name,
      teamLogo: entity.teamLogo,
      teamBanner: entity.teamBanner,
      players: entity.players
          .map((e) => MatchPlayerModel.fromEntity(e))
          .toList(),
      location: LocationModel.fromEntity(entity.location),
      battingOrder: entity.battingOrder.map(
        (e, v) => MapEntry(e, MatchPlayerModel.fromEntity(v)),
      ),
      partnerships: entity.partnerships
          .map((e) => PartnershipModel.fromEntity(e))
          .toList(),
    );
  }

  factory MatchTeamModel.fromJson(Map<String, dynamic> map) {
    final players = List<MatchPlayerModel>.from(
      (map['players'] as List<dynamic>).map<MatchPlayerModel>(
        (x) => MatchPlayerModel.fromMap(x),
      ),
    );
    final onStrike = players
        .where((e) => e.playerId == map['onStrike'])
        .firstOrNull;
    final bowler = players
        .where((e) => e.playerId == map['bowler'])
        .firstOrNull;
    final currBatsmen = [
      map["currBatsmen"][0] == null
          ? null
          : players
                .where((e) => e.playerId == map["currBatsmen"][0])
                .firstOrNull,
      map["currBatsmen"][1] == null
          ? null
          : players
                .where((e) => e.playerId == map["currBatsmen"][1])
                .firstOrNull,
    ];
    return MatchTeamModel(
      id: map['id'] as String,
      name: map['name'] as String,
      teamLogo: map['teamLogo'] as String,
      teamBanner: map['teamBanner'] as String,
      onStrike: onStrike,
      currBatsmen: currBatsmen,
      bowler: bowler,
      players: players,
      battingOrder: (map['battingOrder'] as Map<int, dynamic>).map(
        (e, v) => MapEntry(e, MatchPlayerModel.fromMap(v)),
      ),
      partnerships: (map['partnerships'] as List<dynamic>)
          .map((x) => PartnershipModel.fromJson(x))
          .toList(),
      location: LocationModel.fromJson(map['location']),
    );
  }
}

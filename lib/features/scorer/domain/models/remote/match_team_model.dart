// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
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
    final playerEntities = players.map((e) => e.toEntity()).toList();
    final playerById = {for (final p in playerEntities) p.playerId: p};

    MatchPlayerEntity? getEntityByPlayer(MatchPlayerModel? model) {
      if (model == null) return null;
      return playerById[model.playerId];
    }

    final onStrikeEntity = getEntityByPlayer(onStrike);
    final bowlerEntity = getEntityByPlayer(bowler);
    final currBatsmenEntities = currBatsmen
        .map<MatchPlayerEntity?>((e) => getEntityByPlayer(e))
        .toList();

    final battingOrderEntities = battingOrder.map<int, MatchPlayerEntity>(
      (k, v) => MapEntry(k, playerById[v.playerId]!),
    );

    final partnershipsEntities = partnerships.map((p) => p.toEntity()).toList();

    return MatchTeamEntity(
      id: id,
      name: name,
      teamLogo: teamLogo,
      teamBanner: teamBanner,
      players: playerEntities,
      location: location.toEntity(),
      onStrike: onStrikeEntity,
      bowler: bowlerEntity,
      currBatsmen: currBatsmenEntities,
      battingOrder: battingOrderEntities,
      partnerships: partnershipsEntities,
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
      onStrike: entity.onStrike == null
          ? null
          : MatchPlayerModel.fromEntity(entity.onStrike!),
      bowler: entity.bowler == null
          ? null
          : MatchPlayerModel.fromEntity(entity.bowler!),
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
    final players = (map['players'] as List<dynamic>)
        .map<MatchPlayerModel>((x) => MatchPlayerModel.fromMap(x))
        .toList();

    final onStrike = map['onStrike'] == null
        ? null
        : players.firstWhere((e) => e.playerId == map['onStrike']);

    final bowler = map['bowler'] == null
        ? null
        : players.where((e) => e.playerId == map['bowler']).firstOrNull;
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
    final battingOrder = (map['battingOrder'] as Map<dynamic, dynamic>).map(
      (e, v) => MapEntry(
        int.parse(e),
        players.where((e) => e.playerId == v["id"]).first,
      ),
    );
    return MatchTeamModel(
      id: map['id'] as String,
      name: map['name'] as String,
      teamLogo: map['teamLogo'] as String,
      teamBanner: map['teamBanner'] as String,
      onStrike: onStrike,
      currBatsmen: currBatsmen,
      bowler: bowler,
      players: players,
      battingOrder: battingOrder,
      partnerships: (map['partnerships'] as List<dynamic>)
          .map((x) => PartnershipModel.fromJson(x, players))
          .toList(),
      location: LocationModel.fromJson(map['location']),
    );
  }
}

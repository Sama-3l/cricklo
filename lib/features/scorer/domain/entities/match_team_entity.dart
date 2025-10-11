import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/partnership_entity.dart';

class MatchTeamEntity {
  final String id;
  final String name;
  final String teamLogo;
  final String teamBanner;
  MatchPlayerEntity? onStrike;
  List<MatchPlayerEntity?> currBatsmen;
  MatchPlayerEntity? bowler;
  final List<MatchPlayerEntity> players;
  Map<int, MatchPlayerEntity> battingOrder;
  final List<PartnershipEntity> partnerships;
  final LocationEntity location;

  MatchTeamEntity({
    this.bowler,
    this.onStrike,
    required this.currBatsmen,
    required this.id,
    required this.name,
    required this.teamLogo,
    required this.teamBanner,
    required this.players,
    required this.location,
    required this.battingOrder,
    required this.partnerships,
  });
}

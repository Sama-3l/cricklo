// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/scorer/domain/entities/match_team_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';

class InningsEntity {
  int number;
  final MatchTeamEntity battingTeam;
  int runs;
  int wickets;
  String overs;
  double crr;
  int extras;
  final List<OversEntity> oversData;

  InningsEntity({
    required this.battingTeam,
    required this.runs,
    required this.wickets,
    required this.overs,
    required this.number,
    required this.crr,
    required this.extras,
    required this.oversData,
  });
}

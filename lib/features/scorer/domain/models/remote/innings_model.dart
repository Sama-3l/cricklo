// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/features/scorer/domain/entities/innings_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_team_entity.dart';
import 'package:cricklo/features/scorer/domain/models/remote/match_team_model.dart';
import 'package:cricklo/features/scorer/domain/models/remote/overs_model.dart';

class InningsModel {
  int number;
  final MatchTeamModel battingTeam;
  int runs;
  int wickets;
  String overs;
  double crr;
  int extras;
  final List<OversModel> oversData;

  InningsModel({
    required this.battingTeam,
    required this.runs,
    required this.wickets,
    required this.overs,
    required this.number,
    required this.crr,
    required this.extras,
    required this.oversData,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'number': number,
      'battingTeam': battingTeam.id,
      'runs': runs,
      'wickets': wickets,
      'overs': overs,
      'crr': crr,
      'extras': extras,
      'oversData': oversData.map((x) => x.toMap()).toList(),
    };
  }

  InningsEntity toEntity(MatchTeamEntity teamA, MatchTeamEntity teamB) {
    final battingTeamEntity = teamA.id == battingTeam.id ? teamA : teamB;
    return InningsEntity(
      number: number,
      battingTeam: battingTeamEntity,
      runs: runs,
      wickets: wickets,
      overs: overs,
      crr: crr,
      extras: extras,
      oversData: oversData.map((x) => x.toEntity()).toList(),
    );
  }

  factory InningsModel.fromEntity(InningsEntity entity) {
    return InningsModel(
      battingTeam: MatchTeamModel.fromEntity(entity.battingTeam),
      runs: entity.runs,
      wickets: entity.wickets,
      overs: entity.overs,
      number: entity.number,
      crr: entity.crr,
      extras: entity.extras,
      oversData: entity.oversData.map((e) => OversModel.fromEntity(e)).toList(),
    );
  }

  factory InningsModel.fromJson(
    Map<String, dynamic> map,
    MatchTeamModel teamA,
    MatchTeamModel teamB,
  ) {
    final battingTeam = teamA.id == map['battingTeam'] ? teamA : teamB;
    final bowlingTeam = teamA.id == map['battingTeam'] ? teamB : teamA;
    return InningsModel(
      number: map['number'] as int,
      battingTeam: battingTeam,
      runs: map['runs'] as int,
      wickets: map['wickets'] as int,
      overs: map['overs'] as String,
      crr: Methods.toDouble(map['crr']),
      extras: map['extras'] as int,
      oversData: (map['oversData'] as List<dynamic>)
          .map<OversModel>(
            (x) => OversModel.fromJson(
              x,
              battingTeam.players,
              bowlingTeam.players,
            ),
          )
          .toList(),
    );
  }
}

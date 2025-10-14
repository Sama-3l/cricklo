// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_stats_entity.dart';

class MatchPlayerStatsModel {
  int runs;
  int balls;
  int n4s;
  int n6s;
  double sr;
  String overs;
  int runsGiven;
  int maidens;
  int wickets;
  double eco;
  bool out;
  String? bowler; // For WHEN OUT IS TRUE (FOR THE SCORECARD)
  String? fielder; // For WHEN OUT IS TRUE (FOR THE SCORECARD)
  WicketType? wicketType;
  int caught;
  int stumping;
  int runout;

  MatchPlayerStatsModel({
    required this.runs,
    required this.balls,
    required this.n4s,
    required this.n6s,
    required this.sr,
    required this.overs,
    required this.runsGiven,
    required this.maidens,
    required this.wickets,
    required this.eco,
    required this.out,
    this.bowler,
    this.fielder,
    this.wicketType,
    required this.caught,
    required this.stumping,
    required this.runout,
  });

  MatchPlayerStatsEntity toEntity() {
    return MatchPlayerStatsEntity(
      runs: runs,
      balls: balls,
      n4s: n4s,
      n6s: n6s,
      sr: sr,
      overs: overs,
      runsGiven: runsGiven,
      maidens: maidens,
      wickets: wickets,
      eco: eco,
      out: out,
      caught: caught,
      stumping: stumping,
      runout: runout,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'runs': runs,
      'balls': balls,
      'n4s': n4s,
      'n6s': n6s,
      'sr': sr,
      'overs': overs,
      'runsGiven': runsGiven,
      'maidens': maidens,
      'wickets': wickets,
      'eco': eco,
      'out': out,
      'bowler': bowler,
      'fielder': fielder,
      'wicketType': wicketType?.title,
      'caught': caught,
      'stumping': stumping,
      'runout': runout,
    };
  }

  factory MatchPlayerStatsModel.fromEntity(MatchPlayerStatsEntity entity) {
    return MatchPlayerStatsModel(
      runs: entity.runs,
      balls: entity.balls,
      n4s: entity.n4s,
      n6s: entity.n6s,
      sr: entity.sr,
      overs: entity.overs,
      runsGiven: entity.runsGiven,
      maidens: entity.maidens,
      wickets: entity.wickets,
      eco: entity.eco,
      out: entity.out,
      caught: entity.caught,
      stumping: entity.stumping,
      runout: entity.runout,
    );
  }

  factory MatchPlayerStatsModel.fromJson(Map<String, dynamic> map) {
    return MatchPlayerStatsModel(
      runs: map['runs'] as int,
      balls: map['balls'] as int,
      n4s: map['n4s'] as int,
      n6s: map['n6s'] as int,
      sr: map['sr'] as double,
      overs: map['overs'] as String,
      runsGiven: map['runsGiven'] as int,
      maidens: map['maidens'] as int,
      wickets: map['wickets'] as int,
      eco: map['eco'] as double,
      out: map['out'] as bool,
      bowler: map['bowler'] != null ? map['bowler'] as String : null,
      fielder: map['fielder'] != null ? map['fielder'] as String : null,
      wicketType: map['wicketType'] != null
          ? WicketType.values.where((e) => e.title == map['wicketType']).first
          : null,
      caught: map['caught'] as int,
      stumping: map['stumping'] as int,
      runout: map['runout'] as int,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_player_stats_entity.dart';

class TournamentPlayerStatsModel {
  final int runs;
  final int balls;
  final int n4s;
  final int n6s;
  final double sr;
  final String overs;
  final int runsGiven;
  final int maidens;
  final int wickets;
  final double eco;
  final bool out;
  final String? bowler; // For WHEN OUT IS TRUE (FOR THE SCORECARD)
  final String? fielder; // For WHEN OUT IS TRUE (FOR THE SCORECARD)
  final WicketType? wicketType;
  final int caught;
  final int stumping;
  final int runout;

  TournamentPlayerStatsModel({
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

  TournamentPlayerStatsEntity toEntity() {
    return TournamentPlayerStatsEntity(
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
      bowler: bowler,
      fielder: fielder,
      wicketType: wicketType,
      caught: caught,
      stumping: stumping,
      runout: runout,
    );
  }

  factory TournamentPlayerStatsModel.fromJson(Map<String, dynamic> map) {
    return TournamentPlayerStatsModel(
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
          ? WicketType.values
                .where((e) => e.title == map['wicketType'])
                .firstOrNull
          : null,
      caught: map['caught'] as int,
      stumping: map['stumping'] as int,
      runout: map['runout'] as int,
    );
  }

  factory TournamentPlayerStatsModel.fromEntity(
    TournamentPlayerStatsEntity entity,
  ) {
    return TournamentPlayerStatsModel(
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
      bowler: entity.bowler,
      fielder: entity.fielder,
      wicketType: entity.wicketType,
      caught: entity.caught,
      stumping: entity.stumping,
      runout: entity.runout,
    );
  }
}

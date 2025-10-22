// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';

class TournamentPlayerStatsEntity {
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

  TournamentPlayerStatsEntity({
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

  TournamentPlayerStatsEntity copyWith({
    int? runs,
    int? balls,
    int? n4s,
    int? n6s,
    double? sr,
    String? overs,
    int? runsGiven,
    int? maidens,
    int? wickets,
    double? eco,
    bool? out,
    String? bowler,
    String? fielder,
    WicketType? wicketType,
    int? caught,
    int? stumping,
    int? runout,
  }) {
    return TournamentPlayerStatsEntity(
      runs: runs ?? this.runs,
      balls: balls ?? this.balls,
      n4s: n4s ?? this.n4s,
      n6s: n6s ?? this.n6s,
      sr: sr ?? this.sr,
      overs: overs ?? this.overs,
      runsGiven: runsGiven ?? this.runsGiven,
      maidens: maidens ?? this.maidens,
      wickets: wickets ?? this.wickets,
      eco: eco ?? this.eco,
      out: out ?? this.out,
      bowler: bowler ?? this.bowler,
      fielder: fielder ?? this.fielder,
      wicketType: wicketType ?? this.wicketType,
      caught: caught ?? this.caught,
      stumping: stumping ?? this.stumping,
      runout: runout ?? this.runout,
    );
  }
}

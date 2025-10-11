// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';

class MatchPlayerStatsEntity {
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
  String? bowler;
  String? fielder;
  WicketType? wicketType;
  int caught;
  int stumping;
  int runout;

  MatchPlayerStatsEntity({
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
}

part of 'scorer_center_cubit.dart';

class ScoreCenterState {
  final String? onStrikeBatsman;
  final String? offStrikeBatsman;
  final String? currentBowler;
  final int totalRuns;
  final int overs;
  final int balls;
  final int wickets;

  ScoreCenterState({
    this.onStrikeBatsman,
    this.offStrikeBatsman,
    this.currentBowler,
    required this.totalRuns,
    required this.overs,
    required this.balls,
    required this.wickets,
  });

  factory ScoreCenterState.initial() =>
      ScoreCenterState(totalRuns: 0, overs: 0, balls: 0, wickets: 0);

  ScoreCenterState copyWith({
    String? onStrikeBatsman,
    String? offStrikeBatsman,
    String? currentBowler,
    int? totalRuns,
    int? overs,
    int? balls,
    int? wickets,
  }) {
    return ScoreCenterState(
      onStrikeBatsman: onStrikeBatsman ?? this.onStrikeBatsman,
      offStrikeBatsman: offStrikeBatsman ?? this.offStrikeBatsman,
      currentBowler: currentBowler ?? this.currentBowler,
      totalRuns: totalRuns ?? this.totalRuns,
      overs: overs ?? this.overs,
      balls: balls ?? this.balls,
      wickets: wickets ?? this.wickets,
    );
  }
}

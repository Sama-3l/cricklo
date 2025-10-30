import 'package:cricklo/features/teams/domain/entities/team_stats_entity.dart';

class TeamStatsModel {
  final int matches;
  final int wins;
  final int losses;
  final int draws;
  final int abandoned;
  final double nrr;
  final int tossWins;
  final int batFirst;
  final int batFirstWins;
  final int batFirstLoss;
  final int bowlFirst;
  final int bowlFirstWins;
  final int bowlFirstLoss;

  final int highestRunsScored;

  final int lowestRunsScored;

  final int highestRunsConceded;

  final int lowestRunsConceded;

  TeamStatsModel({
    required this.matches,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.abandoned,
    required this.nrr,
    required this.tossWins,
    required this.batFirst,
    required this.batFirstWins,
    required this.batFirstLoss,
    required this.bowlFirst,
    required this.bowlFirstWins,
    required this.bowlFirstLoss,
    required this.highestRunsScored,
    required this.lowestRunsScored,
    required this.highestRunsConceded,
    required this.lowestRunsConceded,
  });

  factory TeamStatsModel.fromJson(Map<String, dynamic> json) {
    return TeamStatsModel(
      matches: json['matches'] ?? 0,
      wins: json['wins'] ?? 0,
      losses: json['losses'] ?? 0,
      draws: json['draws'] ?? 0,
      abandoned: json['abandoned'] ?? 0,
      nrr: (json['nrr'] ?? 0).toDouble(),
      tossWins: json['tossWins'] ?? 0,
      batFirst: json['batFirst'] ?? 0,
      batFirstWins: json['batFirstWins'] ?? 0,
      batFirstLoss: json['batFirstLoss'] ?? 0,
      bowlFirst: json['bowlFirst'] ?? 0,
      bowlFirstWins: json['bowlFirstWins'] ?? 0,
      bowlFirstLoss: json['bowlFirstLoss'] ?? 0,
      highestRunsScored: json['highestRunsScored'] ?? 0,
      lowestRunsScored: json['lowestRunsScored'] ?? 0,
      highestRunsConceded: json['highestRunsConceded'] ?? 0,
      lowestRunsConceded: json['lowestRunsConceded'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matches': matches,
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'abandoned': abandoned,
      'nrr': nrr,
      'tossWins': tossWins,
      'batFirst': batFirst,
      'batFirstWins': batFirstWins,
      'batFirstLoss': batFirstLoss,
      'bowlFirst': bowlFirst,
      'bowlFirstWins': bowlFirstWins,
      'bowlFirstLoss': bowlFirstLoss,
      'highestRunsScored': highestRunsScored,
      'lowestRunsScored': lowestRunsScored,
      'highestRunsConceded': highestRunsConceded,
      'lowestRunsConceded': lowestRunsConceded,
    };
  }

  /// Convert Model → Entity
  TeamStatsEntity toEntity() {
    return TeamStatsEntity(
      matches: matches,
      wins: wins,
      losses: losses,
      draws: draws,
      abandoned: abandoned,
      nrr: nrr,
      tossWins: tossWins,
      batFirst: batFirst,
      batFirstWins: batFirstWins,
      batFirstLoss: batFirstLoss,
      bowlFirst: bowlFirst,
      bowlFirstWins: bowlFirstWins,
      bowlFirstLoss: bowlFirstLoss,
      highestRunsScored: highestRunsScored,
      lowestRunsScored: lowestRunsScored,
      highestRunsConceded: highestRunsConceded,
      lowestRunsConceded: lowestRunsConceded,
    );
  }

  /// Convert Entity → Model
  factory TeamStatsModel.fromEntity(TeamStatsEntity entity) {
    return TeamStatsModel(
      matches: entity.matches,
      wins: entity.wins,
      losses: entity.losses,
      draws: entity.draws,
      abandoned: entity.abandoned,
      nrr: entity.nrr,
      tossWins: entity.tossWins,
      batFirst: entity.batFirst,
      batFirstWins: entity.batFirstWins,
      batFirstLoss: entity.batFirstLoss,
      bowlFirst: entity.bowlFirst,
      bowlFirstWins: entity.bowlFirstWins,
      bowlFirstLoss: entity.bowlFirstLoss,
      highestRunsScored: entity.highestRunsScored,
      lowestRunsScored: entity.lowestRunsScored,
      highestRunsConceded: entity.highestRunsConceded,
      lowestRunsConceded: entity.lowestRunsConceded,
    );
  }
}

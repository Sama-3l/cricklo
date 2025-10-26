import 'package:cricklo/features/teams/domain/entities/team_stats_entity.dart';

class TeamStatsModel {
  final int matches;
  final int wins;
  final int losses;
  final int draws;
  final int abandoned;
  final int tossWon;
  final int batFirst;
  final int batFirstWon;

  TeamStatsModel({
    required this.matches,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.tossWon,
    required this.abandoned,
    required this.batFirst,
    required this.batFirstWon,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'matches': matches,
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'tossWon': tossWon,
      'abandoned': abandoned,
      'batFirst': batFirst,
      'batFirstWon': batFirstWon,
    };
  }

  TeamStatsEntity toEntity() {
    return TeamStatsEntity(
      matches: matches,
      wins: wins,
      losses: losses,
      draws: draws,
      tossWon: tossWon,
      batFirst: batFirst,
      abandoned: abandoned,
      batFirstWon: batFirstWon,
    );
  }

  factory TeamStatsModel.fromJson(Map<String, dynamic> map) {
    return TeamStatsModel(
      abandoned: map['Abandoned'] as int,
      matches: map['Matches_Played'] as int,
      wins: map['Wins'] as int,
      losses: map['Losses'] as int,
      draws: map['Draws'] as int,
      tossWon: map['Toss_Won'] as int,
      batFirst: map['Bat_First'] as int,
      batFirstWon: map['Bat_First_Won'] as int,
    );
  }

  factory TeamStatsModel.fromEntity(TeamStatsEntity entity) {
    return TeamStatsModel(
      matches: entity.matches,
      abandoned: entity.abandoned,
      wins: entity.wins,
      losses: entity.losses,
      draws: entity.draws,
      tossWon: entity.tossWon,
      batFirst: entity.batFirst,
      batFirstWon: entity.batFirstWon,
    );
  }
}

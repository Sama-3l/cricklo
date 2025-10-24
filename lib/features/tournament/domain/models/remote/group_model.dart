// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/matches/domain/models/remote/match_model.dart';
import 'package:cricklo/features/tournament/domain/entities/group_entity.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_team_model.dart';

class GroupModel {
  final List<TournamentTeamModel> teams;
  final List<MatchModel> matches;
  String name;

  GroupModel({required this.teams, required this.name, required this.matches});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'teams': teams.map((x) => x.toJson()).toList(),
      'matches': matches.map((x) => x.toJson()).toList(),
      'name': name,
    };
  }

  GroupEntity toEntity() {
    return GroupEntity(
      teams: teams.map((x) => x.toEntity()).toList(),
      matches: matches.map((x) => x.toEntity()).toList(),
      name: name,
    );
  }

  factory GroupModel.fromJson(Map<String, dynamic> map) {
    return GroupModel(
      teams: map['teams'] != null
          ? List<TournamentTeamModel>.from(
              (map['teams'] as List<dynamic>).map<TournamentTeamModel>(
                (x) => TournamentTeamModel.fromJson(x),
              ),
            )
          : [],
      matches: map['matches'] != null
          ? List<MatchModel>.from(
              (map['matches'] as List<dynamic>).map<MatchModel>(
                (x) => MatchModel.fromJson(x as Map<String, dynamic>),
              ),
            )
          : [],
      name: map['groupName'] as String,
    );
  }

  factory GroupModel.fromEntity(GroupEntity entity) {
    return GroupModel(
      teams: entity.teams
          .map((e) => TournamentTeamModel.fromEntity(e))
          .toList(),
      matches: entity.matches.map((e) => MatchModel.fromEntity(e)).toList(),
      name: entity.name,
    );
  }
}

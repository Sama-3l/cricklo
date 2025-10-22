// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';

class GroupEntity {
  final List<TournamentTeamEntity> teams;
  final List<MatchEntity> matches;
  final String name;

  GroupEntity({required this.teams, required this.name, required this.matches});
}

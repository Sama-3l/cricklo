// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';

class InviteTeamsUsecaseEntity {
  final List<TournamentTeamEntity> teams;
  final String tournamentId;

  InviteTeamsUsecaseEntity({required this.teams, required this.tournamentId});
}

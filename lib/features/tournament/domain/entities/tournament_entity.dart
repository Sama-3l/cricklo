// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/group_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';

class TournamentEntity {
  final String id;
  final String organizerId;
  final String name;
  int spotsLeft;
  final String banner;
  final DateTime inviteDeadline;
  final DateTime startDate;
  final int maxTeams;
  final DateTime endDate;
  final TournamentType tournamentType;
  final MatchType matchType;
  final BallType ballType;
  final int overs;
  final bool userFollow;
  final int followers;
  final List<SearchUserEntity> moderators;
  final List<LocationEntity> venues;
  final List<TournamentTeamEntity> teams;
  final List<MatchEntity> matches;
  final List<GroupEntity> groups;

  TournamentEntity({
    required this.id,
    required this.organizerId,
    required this.name,
    required this.spotsLeft,
    required this.banner,
    required this.inviteDeadline,
    required this.startDate,
    required this.endDate,
    required this.userFollow,
    required this.matchType,
    required this.maxTeams,
    required this.followers,
    required this.tournamentType,
    required this.ballType,
    required this.overs,
    required this.moderators,
    required this.venues,
    required this.teams,
    required this.matches,
    required this.groups,
  });

  TournamentEntity copyWith({
    String? id,
    String? organizerId,
    String? name,
    String? banner,
    DateTime? inviteDeadline,
    DateTime? startDate,
    DateTime? endDate,
    TournamentType? tournamentType,
    MatchType? matchType,
    BallType? ballType,
    int? maxTeams,
    int? spotsLeft,
    int? overs,
    bool? userFollow,
    int? followers,
    List<SearchUserEntity>? moderators,
    List<LocationEntity>? venues,
    List<TournamentTeamEntity>? teams,
    List<MatchEntity>? matches,
    List<GroupEntity>? groups,
  }) {
    return TournamentEntity(
      maxTeams: maxTeams ?? this.maxTeams,
      organizerId: organizerId ?? this.organizerId,
      id: id ?? this.id,
      ballType: ballType ?? this.ballType,
      name: name ?? this.name,
      banner: banner ?? this.banner,
      inviteDeadline: inviteDeadline ?? this.inviteDeadline,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      spotsLeft: spotsLeft ?? this.spotsLeft,
      followers: followers ?? this.followers,
      tournamentType: tournamentType ?? this.tournamentType,
      matchType: matchType ?? this.matchType,
      overs: overs ?? this.overs,
      userFollow: userFollow ?? this.userFollow,
      moderators: moderators ?? this.moderators,
      venues: venues ?? this.venues,
      teams: teams ?? this.teams,
      matches: matches ?? this.matches,
      groups: groups ?? this.groups,
    );
  }
}

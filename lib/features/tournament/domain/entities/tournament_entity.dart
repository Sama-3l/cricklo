// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';

class TournamentEntity {
  final String id;
  final String name;
  final String banner;
  final DateTime inviteDeadline;
  final DateTime startDate;
  final int maxTeams;
  final DateTime endDate;
  final TournamentType tournamentType;
  final MatchType matchType;
  final BallType ballType;
  final int overs;
  final List<SearchUserEntity> moderators;
  final List<LocationEntity> venues;

  TournamentEntity({
    required this.id,
    required this.name,
    required this.banner,
    required this.inviteDeadline,
    required this.startDate,
    required this.endDate,
    required this.matchType,
    required this.maxTeams,
    required this.tournamentType,
    required this.ballType,
    required this.overs,
    required this.moderators,
    required this.venues,
  });

  TournamentEntity copyWith({
    String? id,
    String? name,
    String? banner,
    DateTime? inviteDeadline,
    DateTime? startDate,
    DateTime? endDate,
    TournamentType? tournamentType,
    MatchType? matchType,
    BallType? ballType,
    int? maxTeams,
    int? overs,
    List<SearchUserEntity>? moderators,
    List<LocationEntity>? venues,
  }) {
    return TournamentEntity(
      maxTeams: maxTeams ?? this.maxTeams,
      id: id ?? this.id,
      ballType: ballType ?? this.ballType,
      name: name ?? this.name,
      banner: banner ?? this.banner,
      inviteDeadline: inviteDeadline ?? this.inviteDeadline,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tournamentType: tournamentType ?? this.tournamentType,
      matchType: matchType ?? this.matchType,
      overs: overs ?? this.overs,
      moderators: moderators ?? this.moderators,
      venues: venues ?? this.venues,
    );
  }
}

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
  final DateTime endDate;
  final MatchType matchType;
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
    MatchType? matchType,
    int? overs,
    List<SearchUserEntity>? moderators,
    List<LocationEntity>? venues,
  }) {
    return TournamentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      banner: banner ?? this.banner,
      inviteDeadline: inviteDeadline ?? this.inviteDeadline,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      matchType: matchType ?? this.matchType,
      overs: overs ?? this.overs,
      moderators: moderators ?? this.moderators,
      venues: venues ?? this.venues,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_user_model.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';

class TournamentModel {
  final String id;
  final String name;
  final String banner;
  final DateTime inviteDeadline;
  final DateTime startDate;
  final DateTime endDate;
  final TournamentType tournamentType;
  final MatchType matchType;
  final BallType ballType;
  final int overs;
  final int maxTeams;
  final List<SearchUserModel> moderators;
  final List<LocationModel> venues;

  TournamentModel({
    required this.id,
    required this.name,
    required this.banner,
    required this.inviteDeadline,
    required this.startDate,
    required this.endDate,
    required this.ballType,
    required this.matchType,
    required this.maxTeams,
    required this.tournamentType,
    required this.overs,
    required this.moderators,
    required this.venues,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'banner': banner,
      'inviteDeadline':
          "${inviteDeadline.year}-${inviteDeadline.month.toString().padLeft(2, '0')}-${inviteDeadline.day.toString().padLeft(2, '0')}",
      'startDate':
          "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      'endDate':
          "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      'tournamentType': tournamentType.title.toUpperCase(),
      'format': matchType.name.toUpperCase(),
      'ballType': ballType.title.toUpperCase(),
      'overs': overs,
      'moderators': moderators.map((x) => x.id).toList(),
      'venues': venues.map((x) => x.toJson()).toList(),
      'noOfTeams': maxTeams,
    };
  }

  TournamentEntity toEntity() {
    return TournamentEntity(
      ballType: ballType,
      id: id,
      name: name,
      banner: banner,
      inviteDeadline: inviteDeadline,
      startDate: startDate,
      endDate: endDate,
      tournamentType: tournamentType,
      matchType: matchType,
      overs: overs,
      moderators: moderators.map((e) => e.toEntity()).toList(),
      venues: venues.map((e) => e.toEntity()).toList(),
      maxTeams: maxTeams,
    );
  }

  factory TournamentModel.fromEntity(TournamentEntity entity) {
    return TournamentModel(
      id: entity.id,
      name: entity.name,
      banner: entity.banner,
      inviteDeadline: entity.inviteDeadline,
      startDate: entity.startDate,
      ballType: entity.ballType,
      endDate: entity.endDate,
      tournamentType: entity.tournamentType,
      matchType: entity.matchType,
      overs: entity.overs,
      maxTeams: entity.maxTeams,
      moderators: List<SearchUserModel>.from(
        entity.moderators.map<SearchUserModel>(
          (x) => SearchUserModel.fromEntity(x),
        ),
      ),
      venues: List<LocationModel>.from(
        entity.venues.map<LocationModel>((x) => LocationModel.fromEntity(x)),
      ),
    );
  }

  // factory TournamentModel.fromJson(Map<String, dynamic> map) {
  //   return TournamentModel(
  //     id: map['id'] as String,
  //     name: map['name'] as String,
  //     banner: map['banner'] as String,
  //     inviteDeadline: DateTime.fromMillisecondsSinceEpoch(
  //       map['inviteDeadline'] as int,
  //     ),
  //     startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
  //     endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
  //     tournamentType: TournamentType.fromJson(
  //       map['tournamentType'] as Map<String, dynamic>,
  //     ),
  //     matchType: MatchType.fromJson(map['matchType'] as Map<String, dynamic>),
  //     overs: map['overs'] as int,
  //     moderators: List<SearchUserEntity>.from(
  //       (map['moderators'] as List<int>).map<SearchUserEntity>(
  //         (x) => SearchUserEntity.fromJson(x as Map<String, dynamic>),
  //       ),
  //     ),
  //     venues: List<LocationEntity>.from(
  //       (map['venues'] as List<int>).map<LocationEntity>(
  //         (x) => LocationEntity.fromMap(x as Map<String, dynamic>),
  //       ),
  //     ),
  //   );
  // }
}

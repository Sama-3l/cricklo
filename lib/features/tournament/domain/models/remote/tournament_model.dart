// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/matches/domain/models/remote/match_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_user_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/domain/models/remote/group_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_player_stats_model.dart';

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
  final List<TeamModel> teams;
  final List<MatchModel> matches;
  final List<GroupModel> groups;
  final List<TournamentPlayerStatsModel> playerStats;

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
    required this.teams,
    required this.matches,
    required this.groups,
    required this.playerStats,
  });

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
      teams: teams.map((e) => e.toEntity()).toList(),
      matches: matches.map((e) => e.toEntity()).toList(),
      groups: groups.map((e) => e.toEntity()).toList(),
      playerStats: playerStats.map((e) => e.toEntity()).toList(),
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
      teams: entity.teams.map((e) => TeamModel.fromEntity(e)).toList(),
      matches: entity.matches.map((e) => MatchModel.fromEntity(e)).toList(),
      groups: entity.groups.map((e) => GroupModel.fromEntity(e)).toList(),
      playerStats: entity.playerStats
          .map((e) => TournamentPlayerStatsModel.fromEntity(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson({bool fullObject = false}) {
    if (fullObject) {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'banner': banner,
        'inviteDeadline': inviteDeadline.millisecondsSinceEpoch,
        'startDate': startDate.millisecondsSinceEpoch,
        'endDate': endDate.millisecondsSinceEpoch,
        'tournamentType': tournamentType.title,
        'matchType': matchType.name,
        'ballType': ballType.title,
        'overs': overs,
        'maxTeams': maxTeams,
        'moderators': moderators.map((x) => x.toJson()).toList(),
        'venues': venues.map((x) => x.toJson()).toList(),
        'teams': teams.map((x) => x.toJson()).toList(),
        'matches': matches.map((x) => x.toJson()).toList(),
        'groups': groups.map((x) => x.toJson()).toList(),
        'playerStats': playerStats.map((x) => x.toJson()).toList(),
      };
    }
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

  // factory TournamentModel.fromMap(Map<String, dynamic> map) {
  //   return TournamentModel(
  //     id: map['id'] as String,
  //     name: map['name'] as String,
  //     banner: map['banner'] as String,
  //     inviteDeadline: DateTime.fromMillisecondsSinceEpoch(map['inviteDeadline'] as int),
  //     startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
  //     endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
  //     tournamentType: TournamentType.fromMap(map['tournamentType'] as Map<String,dynamic>),
  //     matchType: MatchType.fromMap(map['matchType'] as Map<String,dynamic>),
  //     ballType: BallType.fromMap(map['ballType'] as Map<String,dynamic>),
  //     overs: map['overs'] as int,
  //     maxTeams: map['maxTeams'] as int,
  //     moderators: List<SearchUserModel>.from((map['moderators'] as List<int>).map<SearchUserModel>((x) => SearchUserModel.fromMap(x as Map<String,dynamic>),),),
  //     venues: List<LocationModel>.from((map['venues'] as List<int>).map<LocationModel>((x) => LocationModel.fromMap(x as Map<String,dynamic>),),),
  //     teams: List<TeamModel>.from((map['teams'] as List<int>).map<TeamModel>((x) => TeamModel.fromMap(x as Map<String,dynamic>),),),
  //     matches: List<MatchModel>.from((map['matches'] as List<int>).map<MatchModel>((x) => MatchModel.fromMap(x as Map<String,dynamic>),),),
  //     groups: List<GroupModel>.from((map['groups'] as List<int>).map<GroupModel>((x) => GroupModel.fromMap(x as Map<String,dynamic>),),),
  //     playerStats: List<TournamentPlayerStatsModel>.from((map['playerStats'] as List<int>).map<TournamentPlayerStatsModel>((x) => TournamentPlayerStatsModel.fromMap(x as Map<String,dynamic>),),),
  //   );
  // }
}

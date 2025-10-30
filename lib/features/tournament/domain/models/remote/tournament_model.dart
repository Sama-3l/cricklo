// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:cricklo/features/matches/domain/models/remote/match_model.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_user_model.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/domain/models/remote/group_model.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_batting_stats.dart';
import 'package:cricklo/features/tournament/domain/models/remote/tournament_team_model.dart';

class TournamentModel {
  final String id;
  final String organizerId;
  final String name;
  final String banner;
  final DateTime inviteDeadline;
  final DateTime startDate;
  final DateTime endDate;
  final TournamentType tournamentType;
  final MatchType matchType;
  final BallType ballType;
  final int overs;
  final bool userFollow;
  final int followers;
  final int maxTeams;
  final int spotsLeft;
  final List<SearchUserModel> moderators;
  final List<LocationModel> venues;
  final List<TournamentTeamModel> teams;
  final List<MatchModel> groupMatches;
  final List<MatchModel> playoffMatches;
  final List<GroupModel> groups;
  final List<TournamentBattingStatsModel> battingStats;
  final List<TournamentBowlingStatsModel> bowlingStats;
  final List<TournamentFieldingStatsModel> fieldingStats;

  TournamentModel({
    required this.id,
    required this.organizerId,
    required this.name,
    required this.banner,
    required this.inviteDeadline,
    required this.startDate,
    required this.endDate,
    required this.followers,
    required this.ballType,
    required this.matchType,
    required this.maxTeams,
    required this.tournamentType,
    required this.overs,
    required this.userFollow,
    required this.spotsLeft,
    required this.moderators,
    required this.venues,
    required this.teams,
    required this.groupMatches,
    required this.playoffMatches,
    required this.groups,
    required this.battingStats,
    required this.bowlingStats,
    required this.fieldingStats,
  });

  TournamentEntity toEntity() {
    return TournamentEntity(
      organizerId: organizerId,
      spotsLeft: spotsLeft,
      ballType: ballType,
      id: id,
      name: name,
      banner: banner,
      followers: followers,
      userFollow: userFollow,
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
      groupMatches: groupMatches.map((e) => e.toEntity()).toList(),
      playoffMatches: playoffMatches.map((e) => e.toEntity()).toList(),
      groups: groups.map((e) => e.toEntity()).toList(),
      battingStats: battingStats.map((e) => e.toEntity()).toList(),
      bowlingStats: bowlingStats.map((e) => e.toEntity()).toList(),
      fieldingStats: fieldingStats.map((e) => e.toEntity()).toList(),
    );
  }

  factory TournamentModel.fromEntity(TournamentEntity entity) {
    return TournamentModel(
      organizerId: entity.organizerId,
      spotsLeft: entity.spotsLeft,
      id: entity.id,
      name: entity.name,
      banner: entity.banner,
      userFollow: entity.userFollow,
      followers: entity.followers,
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
      teams: entity.teams
          .map((e) => TournamentTeamModel.fromEntity(e))
          .toList(),
      groupMatches: entity.groupMatches
          .map((e) => MatchModel.fromEntity(e))
          .toList(),
      playoffMatches: entity.playoffMatches
          .map((e) => MatchModel.fromEntity(e))
          .toList(),
      groups: entity.groups.map((e) => GroupModel.fromEntity(e)).toList(),
      battingStats: entity.battingStats
          .map((e) => TournamentBattingStatsModel.fromEntity(e))
          .toList(),
      bowlingStats: entity.bowlingStats
          .map((e) => TournamentBowlingStatsModel.fromEntity(e))
          .toList(),
      fieldingStats: entity.fieldingStats
          .map((e) => TournamentFieldingStatsModel.fromEntity(e))
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
        'spotsLeft': spotsLeft,
        'userFollow': userFollow,
        'moderators': moderators.map((x) => x.toJson()).toList(),
        'venues': venues.map((x) => x.toJson()).toList(),
        'teams': teams.map((x) => x.toJson()).toList(),
        'groupMatches': groupMatches.map((x) => x.toJson()).toList(),
        'playoffMatches': playoffMatches.map((x) => x.toJson()).toList(),
        'groups': groups.map((x) => x.toJson()).toList(),
        'followers': followers,
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

  factory TournamentModel.fromJson(Map<String, dynamic> map) {
    MatchType matchType = MatchType.t10;
    final format =
        map["format"] as String? ?? map['tournament']["format"] as String?;
    if (format != null) {
      switch (format) {
        case "T10":
          matchType = MatchType.t10;
          break;
        case "T20":
          matchType = MatchType.t20;
          break;
        case "T30":
          matchType = MatchType.t30;
          break;
        case "ODI":
          matchType = MatchType.odi;
          break;
        case "TEST":
          matchType = MatchType.test;
          break;
        default:
          matchType = MatchType.t20;
          break;
      }
    }
    final inviteDeadlineDateTime = DateTime.parse(
      map['inviteDeadline'] as String? ??
          map['tournament']['inviteDeadline'] as String,
    );
    final startDateDateTime = DateTime.parse(
      map['startDate'] as String? ?? map['tournament']['startDate'] as String,
    );
    final endDateDateTime = DateTime.parse(
      map['endDate'] as String? ?? map['tournament']['endDate'] as String,
    );
    final inviteDeadline = DateTime(
      inviteDeadlineDateTime.year,
      inviteDeadlineDateTime.month,
      inviteDeadlineDateTime.day,
      inviteDeadlineDateTime.hour,
      inviteDeadlineDateTime.minute,
      inviteDeadlineDateTime.second,
    );
    final startDate = DateTime(
      startDateDateTime.year,
      startDateDateTime.month,
      startDateDateTime.day,
      startDateDateTime.hour,
      startDateDateTime.minute,
      startDateDateTime.second,
    );
    final endDate = DateTime(
      endDateDateTime.year,
      endDateDateTime.month,
      endDateDateTime.day,
      endDateDateTime.hour,
      endDateDateTime.minute,
      endDateDateTime.second,
    );

    final teams = map['teams'] == null
        ? <TournamentTeamModel>[]
        : List<TournamentTeamModel>.from(
            (map['teams'] as List<dynamic>).map<TournamentTeamModel>(
              (x) => TournamentTeamModel.fromJson(x),
            ),
          );
    final groups = map['groups'] == null
        ? <GroupModel>[]
        : List<GroupModel>.from(
            (map['groups'] as List<dynamic>).map<GroupModel>(
              (x) => GroupModel.fromJson(x, teams),
            ),
          );

    final Map<String, List<MatchModel>> parsedGroups = {};
    if (map['matchesByGroup'] != null) {
      for (final group in map['matchesByGroup']) {
        final String groupName = group['groupName'] ?? 'Unknown Group';
        final List<MatchModel> matches =
            (group['matches'] as List?)
                ?.map((e) => MatchModel.fromJson(e))
                .toList() ??
            [];
        parsedGroups[groupName] = matches;
      }
    }
    final groupMatches = <MatchModel>[];
    for (var group in groups) {
      group.matches.addAll(parsedGroups[group.name] ?? []);
      groupMatches.addAll(group.matches);
    }
    final venues = map['venues'] == null
        ? <LocationModel>[]
        : List<LocationModel>.from(
            (map['venues'] as List<dynamic>).map<LocationModel>(
              (x) => LocationModel.fromJson(x),
            ),
          );
    return TournamentModel(
      followers: map['followersCount'] as int? ?? 0,
      organizerId:
          map['organizerProfileId'] as String? ??
          map['organizer']['profileId'] as String? ??
          "",
      id: map['tournamentId'] as String? ?? map['tournament']['id'] as String,
      userFollow:
          map["follows"] as bool? ?? map['tournament']["follows"] as bool,
      name:
          map['name'] as String? ??
          map['tournamentName'] as String? ??
          map['tournament']['name'] as String,
      banner: map['banner'] as String? ?? map['tournament']['banner'] as String,
      inviteDeadline: inviteDeadline,
      startDate: startDate,
      endDate: endDate,
      tournamentType: map['tournamentType'] == null
          ? map['tournament']['tournamentType'] != null
                ? TournamentType.values
                      .where(
                        (e) =>
                            e.title.toUpperCase() ==
                            map['tournament']['tournamentType'],
                      )
                      .first
                : TournamentType.knockout
          : TournamentType.values
                .where((e) => e.title.toUpperCase() == map['tournamentType'])
                .first,
      spotsLeft:
          map['spotsLeft'] as int? ?? map['tournament']['spotsLeft'] as int,
      matchType: matchType,
      ballType: map['ballType'] == null
          ? map['tournament']['ballType'] != null
                ? BallType.values
                          .where(
                            (e) =>
                                e.title.toUpperCase() ==
                                map['tournament']['ballType'],
                          )
                          .firstOrNull ??
                      BallType.leather
                : BallType.leather
          : BallType.values
                    .where(
                      (e) => e.title.toUpperCase() == map['tournamentType'],
                    )
                    .firstOrNull ??
                BallType.leather,
      overs:
          (map['format'] as String? ?? map['tournament']['format'] as String)
                  .toLowerCase() ==
              "odi"
          ? 50
          : (map['format'] as String? ?? map['tournament']['format'] as String)
                    .toLowerCase() ==
                "t10"
          ? 10
          : (map['format'] as String? ?? map['tournament']['format'] as String)
                    .toLowerCase() ==
                "t20"
          ? 20
          : (map['format'] as String? ?? map['tournament']['format'] as String)
                    .toLowerCase() ==
                "t30"
          ? 30
          : 0,
      maxTeams: map['maxTeams'] as int? ?? map['tournament']['maxTeams'] as int,
      moderators: map['moderators'] == null
          ? []
          : List<SearchUserModel>.from(
              (map['moderators'] as List<dynamic>).map<SearchUserModel>(
                (x) => SearchUserModel.fromJson(x),
              ),
            ),
      venues: venues,
      teams: teams,
      groupMatches: groupMatches,
      playoffMatches: map['ungroupedMatches'] == null
          ? []
          : List<MatchModel>.from(
              (map['ungroupedMatches'] as List<dynamic>).map<MatchModel>(
                (x) => MatchModel.fromJson(x),
              ),
            ),
      groups: groups,
      battingStats: map["playerStats"] == null
          ? []
          : (map["playerStats"]["batting"] as List<dynamic>)
                .map((e) => TournamentBattingStatsModel.fromJson(e))
                .toList(),
      bowlingStats: map["playerStats"] == null
          ? []
          : (map["playerStats"]["bowling"] as List<dynamic>)
                .map((e) => TournamentBowlingStatsModel.fromJson(e))
                .toList(),
      fieldingStats: map["playerStats"] == null
          ? []
          : (map["playerStats"]["fielding"] as List<dynamic>)
                .map((e) => TournamentFieldingStatsModel.fromJson(e))
                .toList(),
    );
  }
}

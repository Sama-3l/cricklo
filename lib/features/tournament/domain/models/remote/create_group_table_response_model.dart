// lib/features/tournament/domain/models/remote/create_group_matches_response_model.dart

import 'package:cricklo/features/matches/domain/models/remote/match_model.dart';
import 'package:cricklo/features/tournament/domain/entities/create_group_table_response_entity.dart';

class CreateGroupTableResponseModel {
  final bool success;
  final String? message;
  final int? totalMatches;
  final int? groupMatchesLength;
  final int? playoffMatches;
  final Map<String, List<MatchModel>> groupMatches;
  final List<MatchModel> playoffs;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  const CreateGroupTableResponseModel({
    required this.success,
    this.message,
    this.totalMatches,
    this.groupMatchesLength,
    this.playoffMatches,
    required this.groupMatches,
    required this.playoffs,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  factory CreateGroupTableResponseModel.fromJson(Map<String, dynamic> map) {
    final payload = map['data'] ?? map;
    final Map<String, List<MatchModel>> parsedGroups = {};
    if (payload['groups'] != null) {
      for (final group in payload['groups']) {
        final String groupName = group['groupName'] ?? 'Unknown Group';
        final List<MatchModel> matches =
            (group['matches'] as List?)
                ?.map((e) => MatchModel.fromJson(e))
                .toList() ??
            [];
        parsedGroups[groupName] = matches;
      }
    }

    return CreateGroupTableResponseModel(
      success: map['success'] ?? true,
      message: map['message'],
      totalMatches: payload['totalMatches'],
      groupMatchesLength: payload['groupMatches'],
      playoffMatches: payload['playoffMatches'],
      groupMatches: parsedGroups,
      playoffs: payload['playoffs'] != null
          ? (payload['playoffs'] as List<dynamic>)
                .map((e) => MatchModel.fromJson(e))
                .toList()
          : [],
      status: map['status'],
      errorCode: map['errorCode'],
      errorMessage: map['errorMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'totalMatches': totalMatches,
      'groupMatches': groupMatchesLength,
      'playoffMatches': playoffMatches,
      'groups': groupMatches.map(
        (e, v) => MapEntry(e, v.map((e) => e.toJson())),
      ),
      'playoffs': playoffs.map((e) => e.toJson()).toList(),
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  CreateGroupTableResponseEntity toEntity() {
    return CreateGroupTableResponseEntity(
      success: success,
      message: message,
      totalMatches: totalMatches,
      groupMatchesLength: groupMatchesLength,
      playoffMatches: playoffMatches,
      groupMatches: groupMatches.map(
        (e, v) => MapEntry(e, v.map((e) => e.toEntity()).toList()),
      ),
      playoffs: playoffs.map((e) => e.toEntity()).toList(),
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }
}

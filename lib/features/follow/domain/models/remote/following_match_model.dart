import 'package:cricklo/features/follow/domain/entities/following_match_entity.dart';

class FollowingMatchModel {
  final String matchId;
  final String matchName;
  final DateTime followedAt;

  const FollowingMatchModel({
    required this.matchId,
    required this.matchName,
    required this.followedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'matchId': matchId,
      'matchName': matchName,
      'followedAt': followedAt.millisecondsSinceEpoch,
    };
  }

  FollowingMatchEntity toEntity() {
    return FollowingMatchEntity(
      matchId: matchId,
      matchName: matchName,
      followedAt: followedAt,
    );
  }

  factory FollowingMatchModel.fromJson(Map<String, dynamic> map) {
    return FollowingMatchModel(
      matchId: map['matchId'] as String,
      matchName: map['matchName'] as String,
      followedAt: DateTime.fromMillisecondsSinceEpoch(map['followedAt'] as int),
    );
  }
}

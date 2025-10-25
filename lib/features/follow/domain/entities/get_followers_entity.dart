import 'package:cricklo/features/follow/domain/entities/follower_entity.dart';

class GetFollowersEntity {
  final bool success;
  final List<FollowerEntity> followers;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetFollowersEntity({
    required this.success,
    required this.followers,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}

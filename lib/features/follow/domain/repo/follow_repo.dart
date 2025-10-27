import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/follow/domain/entities/follow_response_entity.dart';
import 'package:cricklo/features/follow/domain/entities/get_followers_entity.dart';
import 'package:cricklo/features/follow/domain/entities/get_following_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FollowRepo {
  Future<Either<Failure, FollowResponseEntity>> follow(
    String entityId,
    Map<String, dynamic> body,
  );
  Future<Either<Failure, FollowResponseEntity>> unfollow(
    String entityId,
    Map<String, dynamic> body,
  );
  Future<Either<Failure, GetFollowersEntity>> getFollowers(
    String entityId,
    Map<String, dynamic> body,
  );
  Future<Either<Failure, GetFollowingResponseEntity>> following(
    String profileId,
  );
}

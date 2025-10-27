import 'package:cricklo/features/follow/domain/models/remote/follow_response_model.dart';
import 'package:cricklo/features/follow/domain/models/remote/get_followers_model.dart';
import 'package:cricklo/features/follow/domain/models/remote/get_following_response_model.dart';
import 'package:cricklo/services/api_service.dart';

abstract class FollowDatasourceRemote {
  Future<FollowResponseModel> follow(
    String entityId,
    Map<String, dynamic> body,
  );
  Future<FollowResponseModel> unfollow(
    String entityId,
    Map<String, dynamic> body,
  );
  Future<GetFollowersModel> getFollowers(
    String entityId,
    Map<String, dynamic> body,
  );
  Future<GetFollowingResponseModel> following(String profileId);
}

class FollowDatasourceRemoteImpl extends FollowDatasourceRemote {
  final ApiService _apiService;

  FollowDatasourceRemoteImpl(this._apiService);

  @override
  Future<FollowResponseModel> follow(
    String entityId,
    Map<String, dynamic> body,
  ) {
    return _apiService.follow(entityId, body);
  }

  @override
  Future<FollowResponseModel> unfollow(
    String entityId,
    Map<String, dynamic> body,
  ) {
    return _apiService.unfollow(entityId, body);
  }

  @override
  Future<GetFollowersModel> getFollowers(
    String entityId,
    Map<String, dynamic> body,
  ) {
    return _apiService.followers(entityId, body);
  }

  @override
  Future<GetFollowingResponseModel> following(String profileId) {
    return _apiService.following(profileId);
  }
}

import 'package:cricklo/features/follow/domain/entities/get_followers_entity.dart';
import 'package:cricklo/features/follow/domain/models/remote/follower_model.dart';

class GetFollowersModel {
  final bool success;
  final List<FollowerModel> followers;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetFollowersModel({
    required this.success,
    required this.followers,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'followers': followers.map((e) => e.toJson()),
      'message': message,
      'status': status,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
    };
  }

  GetFollowersEntity toEntity() {
    return GetFollowersEntity(
      followers: followers.map((e) => e.toEntity()).toList(),
      success: success,
      message: message,
      status: status,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  factory GetFollowersModel.fromJson(Map<String, dynamic> map) {
    return GetFollowersModel(
      success: map['success'] as bool,
      followers: map['payload'] != null
          ? (map['payload']['followers'] as List<dynamic>)
                .map((e) => FollowerModel.fromJson(e))
                .toList()
          : [],
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      errorMessage: map['errorMessage'] != null
          ? map['errorMessage'] as String
          : null,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/follow/domain/entities/follower_entity.dart';

class FollowerModel {
  final String profileId;
  final String name;
  final String email;
  final String? profilePicture;
  final PlayerType playerType;
  final String phoneNumber;

  FollowerModel({
    required this.profileId,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.playerType,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'profileId': profileId,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'playerType': playerType.name,
      'phoneNumber': phoneNumber,
    };
  }

  FollowerEntity toEntity() {
    return FollowerEntity(
      profileId: profileId,
      name: name,
      email: email,
      profilePicture: profilePicture,
      playerType: playerType,
      phoneNumber: phoneNumber,
    );
  }

  factory FollowerModel.fromJson(Map<String, dynamic> map) {
    PlayerType playerType = PlayerType.values
        .where((e) => e.name.toLowerCase() == map['playerType'].toLowerCase())
        .first;
    return FollowerModel(
      profileId: map['profileId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profilePicture: map['profilePicture'] as String?,
      playerType: playerType,
      phoneNumber: map['phoneNumber'] as String,
    );
  }
}

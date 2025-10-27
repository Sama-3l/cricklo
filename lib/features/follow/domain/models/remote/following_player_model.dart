import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/follow/domain/entities/following_player_entity.dart';

class FollowingPlayerModel {
  final String profileId;
  final String name;
  final String? profilePicture;
  final PlayerType? playerType;

  const FollowingPlayerModel({
    required this.profileId,
    required this.name,
    this.profilePicture,
    this.playerType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'profileId': profileId,
      'name': name,
      'profilePicture': profilePicture,
      'playerType': playerType,
    };
  }

  FollowingPlayerEntity toEntity() {
    return FollowingPlayerEntity(
      profileId: profileId,
      name: name,
      profilePicture: profilePicture,
      playerType: playerType,
    );
  }

  factory FollowingPlayerModel.fromJson(Map<String, dynamic> map) {
    return FollowingPlayerModel(
      profileId: map['profileId'] as String,
      name: map['name'] as String,
      profilePicture: map['profilePicture'] as String?,
      playerType: PlayerType.values
          .where((e) => e.name.toLowerCase() == map['playerType'].toLowerCase())
          .first,
    );
  }
}

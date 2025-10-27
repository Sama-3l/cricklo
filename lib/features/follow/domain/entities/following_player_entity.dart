import 'package:cricklo/core/utils/constants/enums.dart';

class FollowingPlayerEntity {
  final String profileId;
  final String name;
  final String? profilePicture;
  final PlayerType? playerType;

  const FollowingPlayerEntity({
    required this.profileId,
    required this.name,
    this.profilePicture,
    this.playerType,
  });
}

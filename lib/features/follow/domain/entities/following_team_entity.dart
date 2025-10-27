import 'package:cricklo/features/login/domain/entities/location_entity.dart';

class FollowingTeamEntity {
  final String teamId;
  final String teamName;
  final String teamLogo;
  final LocationEntity location;

  const FollowingTeamEntity({
    required this.teamId,
    required this.teamName,
    required this.teamLogo,
    required this.location,
  });
}

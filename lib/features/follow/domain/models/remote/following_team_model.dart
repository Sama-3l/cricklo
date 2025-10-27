import 'package:cricklo/features/follow/domain/entities/following_team_entity.dart';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';

class FollowingTeamModel {
  final String teamId;
  final String teamName;
  final String teamLogo;
  final LocationModel location;

  const FollowingTeamModel({
    required this.teamId,
    required this.teamName,
    required this.teamLogo,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'teamId': teamId,
      'teamName': teamName,
      'teamLogo': teamLogo,
      'location': location.toJson(),
    };
  }

  FollowingTeamEntity toEntity() {
    return FollowingTeamEntity(
      teamId: teamId,
      teamName: teamName,
      teamLogo: teamLogo,
      location: location.toEntity(),
    );
  }

  factory FollowingTeamModel.fromJson(Map<String, dynamic> map) {
    return FollowingTeamModel(
      teamId: map['teamId'] as String,
      teamName: map['teamName'] as String,
      teamLogo: map['teamLogo'] as String,
      location: LocationModel(
        area: "",
        city: map["location"]["city"],
        state: map["location"]["state"],
        lat: null,
        lng: null,
      ),
    );
  }
}

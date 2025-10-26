// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';

class TeamEntity {
  final String? uuid;
  final String id;
  final String? inviteStatus;
  final String name;
  final File? logoFile;
  final File? bannerFile;
  final String teamLogo;
  final String teamBanner;
  int followers;
  bool userFollows;
  final List<PlayerEntity> players;
  final LocationEntity location;

  TeamEntity({
    required this.uuid,
    required this.id,
    required this.name,
    required this.inviteStatus,
    this.logoFile,
    this.bannerFile,
    required this.userFollows,
    required this.teamLogo,
    required this.followers,
    required this.teamBanner,
    required this.players,
    required this.location,
  });

  TeamEntity copyWith({
    String? uuid,
    String? id,
    String? inviteStatus,
    String? name,
    File? logoFile,
    File? bannerFile,
    int? followers,
    bool? userFollows,
    String? teamLogo,
    String? teamBanner,
    List<PlayerEntity>? players,
    LocationEntity? location,
  }) {
    return TeamEntity(
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      inviteStatus: inviteStatus ?? this.inviteStatus,
      followers: followers ?? this.followers,
      name: name ?? this.name,
      logoFile: logoFile ?? this.logoFile,
      userFollows: userFollows ?? this.userFollows,
      bannerFile: bannerFile ?? this.bannerFile,
      teamLogo: teamLogo ?? this.teamLogo,
      teamBanner: teamBanner ?? this.teamBanner,
      players: players ?? this.players,
      location: location ?? this.location,
    );
  }
}

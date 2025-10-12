// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';

class TeamEntity {
  final String uuid;
  final String id;
  final String name;
  final File? logoFile;
  final File? bannerFile;
  final String teamLogo;
  final String teamBanner;
  final List<PlayerEntity> players;
  final LocationEntity location;

  TeamEntity({
    required this.uuid,
    required this.id,
    required this.name,
    this.logoFile,
    this.bannerFile,
    required this.teamLogo,

    required this.teamBanner,
    required this.players,
    required this.location,
  });
}

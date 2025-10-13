// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';

class UserEntity {
  final String profileId;
  final String name;
  final String email;
  final int unreadNotifications;
  final String? profilePic;
  final String phoneNumber;
  final String countryCode;
  final LocationEntity location;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;

  UserEntity({
    required this.profileId,
    this.playerType = PlayerType.batter,
    this.batterType,
    this.bowlerType,
    required this.unreadNotifications,
    required this.profilePic,
    required this.phoneNumber,
    this.countryCode = "+91",
    required this.name,
    required this.email,
    required this.location,
  });

  UserEntity copyWith({
    String? profileId,
    String? name,
    String? email,
    int? unreadNotifications,
    String? profilePic,
    String? phoneNumber,
    String? countryCode,
    LocationEntity? location,
    PlayerType? playerType,
    BatterType? batterType,
    BowlerType? bowlerType,
  }) {
    return UserEntity(
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      email: email ?? this.email,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      profilePic: profilePic ?? this.profilePic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      location: location ?? this.location,
      playerType: playerType ?? this.playerType,
      batterType: batterType ?? this.batterType,
      bowlerType: bowlerType ?? this.bowlerType,
    );
  }
}

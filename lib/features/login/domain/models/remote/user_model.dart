// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';

class UserModel {
  final String profileId;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? countryCode;
  final LocationEntity location;
  final PlayerType playerType;
  final BatterType? batterType;
  final BowlerType? bowlerType;

  UserModel({
    required this.profileId,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.countryCode = "+91",
    required this.location,
    this.playerType = PlayerType.batter,
    this.batterType,
    this.bowlerType,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      profileId: entity.profileId,
      name: entity.name,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      countryCode: entity.countryCode,
      location: entity.location,
      playerType: entity.playerType,
      batterType: entity.batterType,
      bowlerType: entity.bowlerType,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    // Location (API currently returns just an ID)
    final location = LocationEntity(
      area: '', // no area info from API
      city: '',
      state: '',
      lat: 0,
      lng: 0,
    );

    // PlayerType
    PlayerType playerType;
    switch ((data['Player_Type'] ?? '').toString().toLowerCase()) {
      case 'batsman':
        playerType = PlayerType.batter;
        break;
      case 'bowler':
        playerType = PlayerType.bowler;
        break;
      case 'allrounder':
      default:
        playerType = PlayerType.allRounder;
    }

    // BatterType
    BatterType? batterType;
    final batsmen = data['Batsmen'] as List<dynamic>? ?? [];
    if (batsmen.isNotEmpty) {
      final typeStr = batsmen[0]['Batsman_Type'] ?? '';
      switch (typeStr.toUpperCase()) {
        case 'LEFT_HANDED':
          batterType = BatterType.leftHand;
          break;
        case 'RIGHT_HANDED':
          batterType = BatterType.rightHand;
          break;
      }
    }

    // BowlerType
    BowlerType? bowlerType;
    final bowlers = data['Bowlers'] as List<dynamic>? ?? [];
    if (bowlers.isNotEmpty) {
      final typeStr = bowlers[0]['Bowler_Type'] ?? '';
      switch (typeStr.toUpperCase()) {
        case 'LEFT_ARM_LEGSPIN':
          bowlerType = BowlerType.leftArmSpin;
          break;
        case 'LEFT_ARM_FAST':
          bowlerType = BowlerType.leftArmPace;
          break;
        case 'RIGHT_ARM_LEGSPIN':
          bowlerType = BowlerType.rightArmSpin;
          break;
        case 'RIGHT_ARM_FAST':
          bowlerType = BowlerType.rightArmPace;
          break;
      }
    }

    return UserModel(
      profileId: data['profileId'],
      name: data['Name'] ?? '',
      email: data['Email'] ?? '',
      location: location,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      profileId: profileId,
      name: name,
      email: email,
      phoneNumber: phoneNumber ?? "1234567890",
      countryCode: countryCode ?? "+91",
      location: location,
      playerType: playerType,
      batterType: batterType,
      bowlerType: bowlerType,
    );
  }

  UserModel copyWith({
    String? profileId,
    String? name,
    String? email,
    String? phoneNumber,
    String? countryCode,
    LocationEntity? location,
    PlayerType? playerType,
    BatterType? batterType,
    BowlerType? bowlerType,
  }) {
    return UserModel(
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      location: location ?? this.location,
      playerType: playerType ?? this.playerType,
      batterType: batterType ?? this.batterType,
      bowlerType: bowlerType ?? this.bowlerType,
    );
  }
}

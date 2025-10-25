// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';

class FollowerEntity {
  final String profileId;
  final String name;
  final String email;
  final String? profilePicture;
  final PlayerType playerType;
  final String phoneNumber;

  FollowerEntity({
    required this.profileId,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.playerType,
    required this.phoneNumber,
  });
}

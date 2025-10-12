// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/core/utils/constants/enums.dart';

class SearchTeamPlayerEntity {
  final String playerId;
  final String name;
  final bool captain;
  final String? logo;
  final TeamRole teamRole;

  SearchTeamPlayerEntity({
    required this.playerId,
    required this.name,
    required this.captain,
    required this.teamRole,
    required this.logo,
  });
}

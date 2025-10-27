import 'package:cricklo/core/utils/constants/enums.dart';

class FollowingTournamentEntity {
  final String tournamentId;
  final String tournamentName;
  final String banner;
  final String format;
  final TournamentType tournamentType;
  final DateTime startDate;
  final DateTime endDate;

  const FollowingTournamentEntity({
    required this.tournamentId,
    required this.tournamentName,
    required this.banner,
    required this.format,
    required this.tournamentType,
    required this.startDate,
    required this.endDate,
  });
}

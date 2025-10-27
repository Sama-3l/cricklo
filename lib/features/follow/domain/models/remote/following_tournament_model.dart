import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/follow/domain/entities/following_tournament_entity.dart';

class FollowingTournamentModel {
  final String tournamentId;
  final String tournamentName;
  final String banner;
  final String format;
  final TournamentType tournamentType;
  final DateTime startDate;
  final DateTime endDate;

  const FollowingTournamentModel({
    required this.tournamentId,
    required this.tournamentName,
    required this.banner,
    required this.format,
    required this.tournamentType,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tournamentId': tournamentId,
      'tournamentName': tournamentName,
      'banner': banner,
      'format': format,
      'tournamentType': tournamentType,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    };
  }

  FollowingTournamentEntity toEntity() {
    return FollowingTournamentEntity(
      tournamentId: tournamentId,
      tournamentName: tournamentName,
      banner: banner,
      format: format,
      tournamentType: tournamentType,
      startDate: startDate,
      endDate: endDate,
    );
  }

  factory FollowingTournamentModel.fromJson(Map<String, dynamic> map) {
    final startDateDateTime = DateTime.parse(map['startDate'] as String);
    final endDateDateTime = DateTime.parse(map['endDate'] as String);
    final startDate = DateTime(
      startDateDateTime.year,
      startDateDateTime.month,
      startDateDateTime.day,
      startDateDateTime.hour,
      startDateDateTime.minute,
      startDateDateTime.second,
    );
    final endDate = DateTime(
      endDateDateTime.year,
      endDateDateTime.month,
      endDateDateTime.day,
      endDateDateTime.hour,
      endDateDateTime.minute,
      endDateDateTime.second,
    );
    return FollowingTournamentModel(
      tournamentId: map['tournamentId'] as String,
      tournamentName: map['tournamentName'] as String,
      banner: map['banner'] as String,
      format: map['format'] as String,
      tournamentType: TournamentType.values
          .where((e) => e.title.toUpperCase() == map['tournamentType'])
          .first,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

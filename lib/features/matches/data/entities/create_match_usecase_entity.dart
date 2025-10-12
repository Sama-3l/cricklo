import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/login/domain/models/remote/location_model.dart';
import 'package:flutter/material.dart';

class CreateMatchUsecaseEntity {
  final DateTime date;
  final TimeOfDay time;
  final int overs;
  final String matchType;
  final String teamA;
  final String teamB;
  final LocationEntity location;
  final String scorer;

  CreateMatchUsecaseEntity({
    required this.date,
    required this.time,
    required this.overs,
    required this.matchType,
    required this.teamA,
    required this.teamB,
    required this.location,
    required this.scorer,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date':
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      'time':
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
      'overs': overs,
      'format': matchType,
      'teamAId': teamA,

      'teamBId': teamB,
      'venue': LocationModel.fromEntity(location).toJson(),
      'scorerId': scorer,
    };
  }
}

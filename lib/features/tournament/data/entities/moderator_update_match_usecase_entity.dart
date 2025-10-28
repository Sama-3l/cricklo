// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ModeratorUpdateMatchUsecaseEntity {
  final String matchId;
  final String venueId;
  final String scorerId;
  final DateTime date;
  final TimeOfDay time;
  final String tournamentId;
  ModeratorUpdateMatchUsecaseEntity({
    required this.matchId,
    required this.venueId,
    required this.scorerId,
    required this.date,
    required this.time,
    required this.tournamentId,
  });
}

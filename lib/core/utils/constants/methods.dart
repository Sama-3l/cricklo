import 'dart:convert';
import 'dart:io';

import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';

class Methods {
  static String getPlayerType(UserEntity user) {
    String s = "";
    if (user.playerType == PlayerType.batter ||
        user.playerType == PlayerType.allRounder) {
      s = "${user.batterType!.title}ed Batter";
    }
    if (user.playerType == PlayerType.bowler ||
        user.playerType == PlayerType.allRounder) {
      if (s.isNotEmpty) s += " & ";
      s += "${user.bowlerType!.title} Bowler";
    }

    return s;
  }

  static String getPlayerTypePlayerEntity(PlayerEntity user) {
    String s = "";
    if (user.playerType == PlayerType.batter ||
        user.playerType == PlayerType.allRounder) {
      s = "${user.batterType!.title}ed Batter";
    }
    if (user.playerType == PlayerType.bowler ||
        user.playerType == PlayerType.allRounder) {
      if (s.isNotEmpty) s += " & ";
      s += "${user.bowlerType!.title} Bowler";
    }

    return s;
  }

  static String getMainAppPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Matches';
      case 2:
        return 'Tournaments';
      case 3:
        return 'Account';
      default:
        return '';
    }
  }

  static Future<void> pickTime(
    BuildContext context,
    TimeOfDay? selectedTime,
    Function(TimeOfDay? pickedTime) onTimePicked,
  ) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorsConstants
                  .accentOrange, // header, dial hand, active elements
              secondary:
                  ColorsConstants.accentOrange, // <-- AM/PM selector background
              onPrimary: Colors.white, // text/icons on orange
              onSecondary: Colors.white, // text/icons on AM/PM background
              onSurface: Colors.black, // body text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    ColorsConstants.accentOrange, // OK/Cancel buttons
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    onTimePicked(pickedTime);
  }

  static Future<void> pickDate(
    BuildContext context,
    DateTime? selectedDate,
    Function(DateTime? pickedTime) onDatePicked,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              onSecondary: ColorsConstants.accentOrange,
              primary:
                  ColorsConstants.accentOrange, // header background & OK/Cancel
              onPrimary: Colors.white, // text/icon color on header
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorsConstants.accentOrange, // buttons text
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    onDatePicked(pickedDate);
  }

  static String formatDateTime(DateTime dateTime, {bool addLineBreak = true}) {
    // Day with suffix (1st, 2nd, 3rd, 4th, etc.)
    String getDaySuffix(int day) {
      if (day >= 11 && day <= 13) return 'th';
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    final day = dateTime.day;
    final suffix = getDaySuffix(day);

    // Month and time formatting
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final month = months[dateTime.month - 1];
    final year = dateTime.year; // '25' for 2025

    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'pm' : 'am';

    return '$day$suffix $month${addLineBreak ? ", $year\n" : " at "}$hour:$minute $period';
  }

  static MatchStage getStage(MatchEntity match) {
    final now = DateTime.now();

    // 1️⃣ Match hasn’t started
    if (match.tossWinner == null) {
      if (now.isBefore(match.dateAndTime)) {
        return MatchStage.upcoming;
      } else {
        return MatchStage.waitingForToss;
      }
    }

    // 2️⃣ Match has started (toss done)
    final teamAScore = match.teamAScore;
    final teamBScore = match.teamBScore;

    // Match completed
    if (match.winner != null) return MatchStage.completed;

    // Both innings done but result pending (rare edge)
    if (teamAScore != null && teamBScore != null) {
      return MatchStage.secondInnings;
    }

    // Only one innings active — figure out which team is batting first
    final battingFirstId = getBattingFirstTeamId(match);

    if (battingFirstId == match.teamA.id && teamAScore != null) {
      return MatchStage.firstInnings;
    } else if (battingFirstId == match.teamB.id && teamBScore != null) {
      return MatchStage.firstInnings;
    }

    // If first batting team finished, second innings must be ongoing
    if (teamAScore != null || teamBScore != null) {
      return MatchStage.secondInnings;
    }

    return MatchStage.upcoming; // fallback
  }

  static String? getBattingFirstTeamId(MatchEntity match) {
    if (match.tossWinner == null || match.tossChoice == null) return null;

    if (match.tossChoice == TossChoice.batting) {
      return match.tossWinner;
    } else {
      return match.tossWinner == match.teamA.id
          ? match.teamB.id
          : match.teamA.id;
    }
  }

  static Future<String> imageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }
}

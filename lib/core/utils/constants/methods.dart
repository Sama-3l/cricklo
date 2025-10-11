import 'dart:convert';
import 'dart:io';

import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';
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
      'Jan',
      'Feb',
      'March',
      'April',
      'May',
      'June',
      'July',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec',
    ];

    final month = months[dateTime.month - 1];
    final year = dateTime.year; // '25' for 2025

    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

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

  static String battingTeamAbbr(String name) {
    final n = name.split(' ');
    String d = "";
    for (var word in n) {
      d += word[0];
    }
    return d;
  }

  static String numberSuffix(int number) {
    if (number >= 11 && number <= 13) return 'th';
    switch (number % 10) {
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

  static List<dynamic> getLastBallsWithBreaks(
    List<OversEntity> overs, {
    int count = 6,
  }) {
    final List<dynamic> result = [];
    final List<Map<String, dynamic>> flattened = [];

    // Flatten overs into list of { ball, overNumber }
    for (var over in overs) {
      for (var ball in over.balls) {
        flattened.add({"ball": ball, "overNumber": over.overNumber});
      }
    }
    if (flattened.isEmpty) return [];

    // Take the last `count` balls safely
    final int startIndex = flattened.length > count
        ? flattened.length - count
        : 0;
    final recent = flattened.sublist(startIndex);

    // Add "-" when over changes between consecutive balls
    for (int i = 0; i < recent.length; i++) {
      if (i > 0 && recent[i]["overNumber"] != recent[i - 1]["overNumber"]) {
        result.add("-");
      }
      result.add(recent[i]["ball"]);
    }

    return result;
  }

  static String incrementOver(String currentOver) {
    // Split the overs string into overs and balls
    final parts = currentOver.split('.');
    int overs = int.parse(parts[0]);
    int balls = parts.length > 1 ? int.parse(parts[1]) : 0;

    // Add one ball
    balls += 1;

    // If 6 balls are completed, increment overs and reset balls
    if (balls >= 6) {
      overs += 1;
      balls = 0;
    }

    return '$overs.$balls';
  }

  static double oversToDecimal(String oversString) {
    final parts = oversString.split('.');
    final overs = int.parse(parts[0]);
    final balls = parts.length > 1 ? int.parse(parts[1]) : 0;
    return overs + (balls / 6.0);
  }

  static String decrementOver(String overs) {
    if (!overs.contains('.')) return overs; // safety

    final parts = overs.split('.');
    int over = int.tryParse(parts[0]) ?? 0;
    int ball = int.tryParse(parts[1]) ?? 0;

    if (over == 0 && ball == 0) return "0.0"; // can't go below 0

    if (ball > 0) {
      ball--;
    } else {
      // ball == 0 → borrow 1 over, set balls to 5
      if (over > 0) {
        over--;
        ball = 5;
      } else {
        ball = 0;
      }
    }

    return "$over.$ball";
  }

  static bool validScorerOperation(
    List<MatchPlayerEntity?> currBatsmen,
    MatchPlayerEntity? strike,
  ) {
    return currBatsmen.where((e) => e != null).isNotEmpty &&
        strike != null &&
        (currBatsmen[0]!.playerId == strike.playerId ||
            currBatsmen[1]!.playerId == strike.playerId);
  }

  static String getBatsmanSubtitle(
    MatchPlayerEntity player,
    MatchCenterEntity match,
  ) {
    final innings = match.innings.last;
    final isCurrBatsman = match.battingTeam!.currBatsmen.any(
      (b) => b?.playerId == player.playerId,
    );
    final matchOverOrAbandoned = match.winner != null || match.abandoned;

    // Player is not out but match ended
    if (matchOverOrAbandoned && player.stats.out == false) {
      return "not out";
    }

    // Player still batting
    if (!player.stats.out && isCurrBatsman) {
      return "batting";
    }

    // Player is out
    if (player.stats.out) {
      switch (player.stats.wicketType) {
        case WicketType.retired:
          return "retired hurt";
        case WicketType.caught:
          return "c ${player.stats.fielder} b ${player.stats.bowler}";
        case WicketType.stumped:
          return "st ${player.stats.fielder} b ${player.stats.bowler}";
        case WicketType.bowled:
          return "b ${player.stats.bowler}";
        case WicketType.lbw:
          return "lbw b ${player.stats.bowler}";
        case WicketType.hitWicket:
          return "hit wicket b ${player.stats.bowler}";
        case WicketType.runOut:
          return "run out (${player.stats.fielder})";
        default:
          return "";
      }
    }

    // Default fallback
    return "";
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/domain/entities/location_entity.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/innings_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/player_stats_entities.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_highligh_stat_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  static String getDateRangeFormatted(DateTime start, DateTime end) {
    final startDay = start.day;
    final endDay = end.day;
    final startMonth = DateFormat('MMM').format(start);
    final endMonth = DateFormat('MMM').format(end);
    final startYearShort = DateFormat("''yy").format(start);
    final endYearShort = DateFormat("''yy").format(end);

    String startSuffix = getDaySuffix(startDay);
    String endSuffix = getDaySuffix(endDay);

    if (start.year == end.year) {
      // SAME YEAR
      if (start.month == end.month) {
        // Same month → 19ᵗʰ – 27ᵗʰ Oct '25
        return '$startDay$startSuffix – $endDay$endSuffix $endMonth $endYearShort';
      } else {
        // Different months, same year → 19ᵗʰ Oct – 2ⁿᵈ Nov '25
        return '$startDay$startSuffix $startMonth – $endDay$endSuffix $endMonth $endYearShort';
      }
    } else {
      // DIFFERENT YEARS → 29ᵗʰ Dec '25 – 3ʳᵈ Jan '26
      return '$startDay$startSuffix $startMonth $startYearShort – '
          '$endDay$endSuffix $endMonth $endYearShort';
    }
  }

  static String getFormattedDate(DateTime date) {
    final day = date.day;
    final month = DateFormat('MMM').format(date);
    final yearShort = DateFormat("''yy").format(date); // e.g. '25
    final suffix = getDaySuffix(day);

    return '$day$suffix $month $yearShort';
  }

  /// Returns ordinal suffix in superscript form
  static String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'ᵗʰ';
    switch (day % 10) {
      case 1:
        return 'ˢᵗ';
      case 2:
        return 'ⁿᵈ';
      case 3:
        return 'ʳᵈ';
      default:
        return 'ᵗʰ';
    }
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
    if (match.draw || match.winner != null) return MatchStage.completed;

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
    final isCurrBatsman = match.battingTeam!.currBatsmen.any(
      (b) => b?.playerId == player.playerId,
    );
    final inningsIndex = match.innings.length <= 2 ? 0 : 1;
    final matchOverOrAbandoned =
        match.winner != null || match.abandoned || match.draw;

    // Player is not out but match ended
    if (matchOverOrAbandoned && player.stats[inningsIndex].out == false) {
      return "not out";
    }

    // Player still batting
    if (!player.stats[inningsIndex].out && isCurrBatsman) {
      return "batting";
    }

    // Player is out
    if (player.stats[inningsIndex].out) {
      switch (player.stats[inningsIndex].wicketType) {
        case WicketType.retired:
          return "retired hurt";
        case WicketType.caught:
          return "c ${player.stats[inningsIndex].fielder} b ${player.stats[inningsIndex].bowler}";
        case WicketType.stumped:
          return "st ${player.stats[inningsIndex].fielder} b ${player.stats[inningsIndex].bowler}";
        case WicketType.bowled:
          return "b ${player.stats[inningsIndex].bowler}";
        case WicketType.lbw:
          return "lbw b ${player.stats[inningsIndex].bowler}";
        case WicketType.hitWicket:
          return "hit wicket b ${player.stats[inningsIndex].bowler}";
        case WicketType.runOut:
          return "run out (${player.stats[inningsIndex].fielder})";
        default:
          return "";
      }
    }

    // Default fallback
    return "";
  }

  static DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  static String abbreviateTeamName(String name) {
    // Check if name contains text in brackets → use that directly
    final bracketMatch = RegExp(r'\(([^)]+)\)').firstMatch(name);
    if (bracketMatch != null) {
      return bracketMatch.group(1)!.toUpperCase();
    }

    // Otherwise, take first letter of each word and uppercase it
    final words = name
        .split(' ')
        .where((word) => word.isNotEmpty) // remove extra spaces
        .toList();

    final abbreviation = words.map((word) => word[0].toUpperCase()).join();

    return abbreviation;
  }

  static LocationEntity getLocationEntity(String venueArea, String location) {
    final split = venueArea.split(', ');
    final state = split.last;
    final city = split[split.length - 2];
    final area = split.first;
    return LocationEntity(
      location: location,
      area: area,
      city: city,
      state: state,
    );
  }

  static String truncatePlayerName(String fullName) {
    // Split by spaces and clean up
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();

    if (parts.isEmpty) return '';

    // If only one word, return as-is (e.g., "Dhoni")
    if (parts.length == 1) return parts.first;

    // Last name is the surname
    final lastName = parts.last;

    // Initials from all but last
    final initials = parts
        .sublist(0, parts.length - 1)
        .map((name) => '${name[0].toUpperCase()}.')
        .join(' ');

    return '$initials $lastName';
  }

  static Map<String, String> getTargetOrLead(List<InningsEntity> innings) {
    final int count = innings.length;

    if (count == 1) return {"title": "", "value": ""};

    // Get total runs for each team
    final teamARuns = innings
        .where((inn) => inn.battingTeam.id == innings.first.battingTeam.id)
        .fold(0, (sum, inn) => sum + inn.runs);

    final teamBRuns = innings
        .where((inn) => inn.battingTeam.id != innings.first.battingTeam.id)
        .fold(0, (sum, inn) => sum + inn.runs);

    // --- 2nd Innings ---
    if (count == 2) {
      final int difference = teamBRuns - teamARuns;
      if (difference < 0) {
        return {"title": "Trail:", "value": "${difference.abs()}"};
      } else if (difference > 0) {
        return {"title": "Lead:", "value": "$difference"};
      } else {
        return {"title": "Scores Level", "value": ""};
      }
    }

    // --- 3rd Innings ---
    if (count == 3) {
      // Compare (Team A total after 3 innings) vs (Team B total after 2)
      final int difference = teamARuns - teamBRuns;
      if (difference < 0) {
        return {"title": "Trail:", "value": "${difference.abs()}"};
      } else if (difference > 0) {
        return {"title": "Lead:", "value": "$difference"};
      } else {
        return {"title": "Scores Level", "value": ""};
      }
    }

    // --- 4th Innings ---
    if (count == 4) {
      // Team B chasing → Target = (Team A total) - (Team B total after 2 innings) + 1
      final target = (teamARuns - teamBRuns) + 1;
      return {"title": "Target:", "value": "${target >= 0 ? target : 0}"};
    }

    return {"title": "", "value": ""};
  }

  static String? getWinner(MatchCenterEntity match) {
    if (match.matchType != MatchType.test) {
      final innings = match.innings;
      if (innings.length < 2) return null;
      final teamARuns = innings
          .where((inn) => inn.battingTeam.id == match.teamA.id)
          .fold(0, (sum, inn) => sum + inn.runs);
      final teamBRuns = innings
          .where((inn) => inn.battingTeam.id == match.teamB.id)
          .fold(0, (sum, inn) => sum + inn.runs);

      if (teamARuns > teamBRuns) return match.teamA.id;
      if (teamBRuns > teamARuns) return match.teamB.id;
      return null; // tie
    } else {
      // TEST match winner (after 4 innings)
      final innings = match.innings;
      final teamARuns = innings
          .where((inn) => inn.battingTeam.id == match.teamA.id)
          .fold(0, (sum, inn) => sum + inn.runs);
      final teamBRuns = innings
          .where((inn) => inn.battingTeam.id == match.teamB.id)
          .fold(0, (sum, inn) => sum + inn.runs);

      // if (innings.length < 4) return null;

      if (teamARuns > teamBRuns) return match.teamA.id;
      if (teamBRuns > teamARuns) return match.teamB.id;
      return null; // draw
    }
  }

  static double toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static List<dynamic> calculateResultMessage(
    MatchCenterEntity match,
    List<InningsEntity> innings,
  ) {
    if (innings.length < 2) return ["Match not completed"];

    if (match.draw) return ["Match Tied"];

    final first = innings[0];
    final second = innings[1];

    if (second.runs > first.runs) {
      // Team B chased successfully
      final wicketsRemaining =
          second.battingTeam.players.length - second.wickets;
      return [
        second.battingTeam.teamLogo,
        second.battingTeam.name,
        "${second.battingTeam.name} won by $wicketsRemaining wickets",
      ];
    } else if (first.runs > second.runs) {
      // Team A defended successfully
      final runsDiff = first.runs - second.runs;
      return [
        first.battingTeam.teamLogo,
        first.battingTeam.name,
        "${first.battingTeam.name} won by $runsDiff runs",
      ];
    } else {
      return ["Match tied"];
    }
  }

  static List<TournamentHighlightStat> computeTournamentHighlights({
    required List<TournamentBattingStatsEntity> battingStats,
    required List<TournamentBowlingStatsEntity> bowlingStats,
  }) {
    TournamentBattingStatsEntity? getTopBatter(String fieldName) {
      if (battingStats.isEmpty) return null;
      battingStats.sort((a, b) {
        switch (fieldName) {
          case 'runs':
            return b.runs.compareTo(a.runs);
          case 'sixes':
            return b.sixes.compareTo(a.sixes);
          case 'fours':
            return b.fours.compareTo(a.fours);
          case 'fifties':
            return b.fifties.compareTo(a.fifties);
          case 'hundreds':
            return b.hundreds.compareTo(a.hundreds);
          default:
            return 0;
        }
      });
      return battingStats.first;
    }

    TournamentBowlingStatsEntity? getTopBowler(String fieldName) {
      if (bowlingStats.isEmpty) return null;
      bowlingStats.sort((a, b) {
        if (fieldName == 'wickets') return b.wickets.compareTo(a.wickets);
        return 0;
      });
      return bowlingStats.first;
    }

    return [
      if (getTopBatter('runs') != null)
        TournamentHighlightStat(
          title: "Most Runs",
          playerName: getTopBatter('runs')!.playerName,
          value: getTopBatter('runs')!.runs,
          logo: getTopBatter('runs')!.teamLogo,
        ),
      if (getTopBowler('wickets') != null)
        TournamentHighlightStat(
          title: "Most Wickets",
          playerName: getTopBowler('wickets')!.playerName,
          value: getTopBowler('wickets')!.wickets,
          logo: getTopBowler('wickets')!.teamLogo,
        ),
      if (getTopBatter('sixes') != null)
        TournamentHighlightStat(
          title: "Most Sixes",
          playerName: getTopBatter('sixes')!.playerName,
          value: getTopBatter('sixes')!.sixes,
          logo: getTopBatter('sixes')!.teamLogo,
        ),
      if (getTopBatter('fours') != null)
        TournamentHighlightStat(
          title: "Most Fours",
          playerName: getTopBatter('fours')!.playerName,
          value: getTopBatter('fours')!.fours,
          logo: getTopBatter('fours')!.teamLogo,
        ),
      if (getTopBatter('fifties') != null)
        TournamentHighlightStat(
          title: "Most 50s",
          playerName: getTopBatter('fifties')!.playerName,
          value: getTopBatter('fifties')!.fifties,
          logo: getTopBatter('fifties')!.teamLogo,
        ),
      if (getTopBatter('hundreds') != null)
        TournamentHighlightStat(
          title: "Most 100s",
          playerName: getTopBatter('hundreds')!.playerName,
          value: getTopBatter('hundreds')!.hundreds,
          logo: getTopBatter('hundreds')!.teamLogo,
        ),
    ];
  }

  static int calculateTournamentSixes(TournamentEntity entity) {
    int p = 0;
    for (var stats in entity.battingStats) {
      p += stats.sixes;
    }
    return p;
  }

  static int calculateTournamentFours(TournamentEntity entity) {
    int p = 0;
    for (var stats in entity.battingStats) {
      p += stats.fours;
    }
    return p;
  }
}

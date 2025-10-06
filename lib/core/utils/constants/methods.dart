import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
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
}

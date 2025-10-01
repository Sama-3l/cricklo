import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';

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
}

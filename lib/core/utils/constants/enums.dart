enum PlayerType { batter, bowler, allRounder }

enum BatterType {
  leftHand("Left-Hand"),
  rightHand("Right-Hand");

  final String title;
  const BatterType(this.title);
}

enum BowlerType {
  leftArmSpin("Left-Arm Spin"),
  leftArmPace("Left-Arm Pace"),
  rightArmSpin("Right-Arm Spin"),
  rightArmPace("Right-Arm Pace");

  final String title;
  const BowlerType(this.title);
}

enum TeamRole {
  invited("Invited"),
  member("Member"),
  captain("Captain"),
  active("Active Squad"),
  sub("Substitute");

  final String roleTitle;
  const TeamRole(this.roleTitle);
}

enum MatchType {
  t10("T10"),
  t20("T20"),
  t30("T30"),
  odi("ODI"),
  test("Test"),
  custom("Custom");

  final String matchType;
  const MatchType(this.matchType);
}

enum NotificationType { team, match, tournament }

enum TossChoice { batting, bowling }

enum MatchStage {
  upcoming,
  waitingForToss,
  firstInnings,
  secondInnings,
  completed,
}

enum ExtraType { none, wide, noBall, bye, legBye }

enum WicketType {
  bowled,
  caught,
  stumped,
  lbw,
  runOut,
  mankad,
  retired,
  overTheFence,
  timedOut,
  doubleHit,
  hitWicket,
}

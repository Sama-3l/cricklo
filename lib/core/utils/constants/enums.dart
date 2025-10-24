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
  test("Test");

  final String matchType;
  const MatchType(this.matchType);
}

enum NotificationType {
  team,
  match,
  tournamentTeam,
  tournamentModerator,
  scorer,
}

enum TossChoice { batting, bowling }

enum MatchStage {
  upcoming,
  waitingForToss,
  firstInnings,
  secondInnings,
  completed,
}

enum ExtraType { wide, noBall, bye, legBye, penalty, bonus, moreRuns }

enum WicketType {
  bowled("Bowled"),
  caught("Caught"),
  stumped("Stumped"),
  lbw("LBW"),
  runOut("Run Out"),
  mankad("Mankad"),
  retired("Retired"),
  overTheFence("Over the Fence"),
  timedOut("Timed Out"),
  doubleHit("Double Hit"),
  hitWicket("Hit Wicket");

  final String title;
  const WicketType(this.title);
}

enum OptionType { more, bonusRuns, moreRuns }

enum TournamentType {
  knockout("Knockout"),
  league("League");

  final String title;
  const TournamentType(this.title);
}

enum BallType {
  rubber("Rubber"),
  tennis("Tennis"),
  leather("Leather");

  final String title;
  const BallType(this.title);
}

enum InviteStatus {
  accepted("ACCEPTED"),
  invited("INVITED"),
  pending("PENDING"),
  denied("DENIED");

  final String title;
  const InviteStatus(this.title);
}

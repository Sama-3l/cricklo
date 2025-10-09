import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/matches/domain/entities/overall_score_entity.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetDecider {
  static Widget optionBuilder({
    required Function() onTap,
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required String title,
    required bool selected,
    EdgeInsets padding = const EdgeInsets.all(0),
    bool showIcon = true,
  }) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? ColorsConstants.accentOrange.withValues(alpha: 0.2)
                : ColorsConstants.onSurfaceOrange,
            borderRadius: BorderRadius.circular(8),
            border: selected
                ? Border.all(color: ColorsConstants.accentOrange)
                : null,
          ),
          child: Row(
            children: [
              if (showIcon) ...[
                Icon(selected ? selectedIcon : unselectedIcon, size: 16),
                const SizedBox(width: 12),
              ],

              Text(
                title,
                style: TextStyles.poppinsRegular.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildOptionButton(
    String text,
    VoidCallback onPress,
    Animation<Offset> slide,
    Animation<double> opacity,
  ) {
    return SlideTransition(
      position: slide,
      child: FadeTransition(
        opacity: opacity,
        child: Container(
          width: 150,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: PrimaryButton(
            disabled: false,
            onPress: onPress,
            color: ColorsConstants.defaultWhite,
            child: Text(
              text,
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 12,
                letterSpacing: -0.5,
                color: ColorsConstants.defaultBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildPlayerList(
    List<PlayerEntity> players, {
    bool showInvited = false,
    bool dismissable = false,
    required Function(String playerId) onDismiss,
  }) {
    final invited = players
        .where((p) => p.teamRole == TeamRole.invited)
        .toList();

    final nonInvited = players
        .where((p) => p.teamRole != TeamRole.invited)
        .toList();

    final effectiveList = showInvited ? invited : nonInvited;

    final captain = !showInvited && nonInvited.any((p) => p.captain)
        ? nonInvited.firstWhere((p) => p.captain)
        : null;

    final remaining = !showInvited
        ? nonInvited
              .where((p) => captain == null || p.id != captain.id)
              .toList()
        : invited;

    final batters = remaining
        .where((p) => p.playerType == PlayerType.batter)
        .toList();
    final bowlers = remaining
        .where((p) => p.playerType == PlayerType.bowler)
        .toList();
    final allRounders = remaining
        .where((p) => p.playerType == PlayerType.allRounder)
        .toList();

    if (effectiveList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              showInvited ? "No Players Added" : "No Team Members Yet",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.8,
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildSection(String title, List<PlayerEntity> sectionPlayers) {
      if (sectionPlayers.isEmpty) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyles.poppinsBold.copyWith(
                    fontSize: 16,
                    color: ColorsConstants.defaultBlack,
                    letterSpacing: -0.8,
                  ),
                ),
                const Spacer(),
                Text(
                  "${sectionPlayers.length}",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    color: ColorsConstants.defaultBlack,
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1, height: 12),

            Column(
              children: sectionPlayers.map((p) {
                return dismissable
                    ? Dismissible(
                        key: ValueKey(p.playerId),
                        direction:
                            DismissDirection.horizontal, // swipe right only
                        background: Container(
                          decoration: BoxDecoration(
                            color: ColorsConstants.accentOrange.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.only(left: 24),
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.delete,
                            color: ColorsConstants.accentOrange,
                          ),
                        ),
                        secondaryBackground: Container(
                          decoration: BoxDecoration(
                            color: ColorsConstants.accentOrange.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.only(right: 24),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: ColorsConstants.accentOrange,
                          ),
                        ),
                        onDismissed: (_) => onDismiss(p.playerId),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: ColorsConstants.accentOrange
                                    .withValues(alpha: 0.2),
                                child: Icon(
                                  CupertinoIcons.person_fill,
                                  size: 16,
                                  color: ColorsConstants.defaultBlack,
                                ),
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${p.name} ${p.captain ? "(C)" : ""}",
                                      style: TextStyles.poppinsMedium.copyWith(
                                        fontSize: 16,
                                        color: ColorsConstants.defaultBlack,
                                        letterSpacing: -0.8,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      p.playerType == PlayerType.batter
                                          ? "${p.batterType?.title ?? ""} Batsman"
                                          : p.playerType == PlayerType.bowler
                                          ? p.bowlerType?.title ?? "Bowler"
                                          : "${p.batterType?.title ?? ""} • ${p.bowlerType?.title ?? ""}",
                                      style: TextStyles.poppinsRegular.copyWith(
                                        fontSize: 10,
                                        color: ColorsConstants.defaultBlack,
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                p.playerId,
                                style: TextStyles.poppinsMedium.copyWith(
                                  fontSize: 12,
                                  color: ColorsConstants.defaultBlack,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: ColorsConstants.accentOrange
                                  .withValues(alpha: 0.2),
                              child: Icon(
                                CupertinoIcons.person_fill,
                                size: 16,
                                color: ColorsConstants.defaultBlack,
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${p.name} ${p.captain ? "(C)" : ""}",
                                    style: TextStyles.poppinsMedium.copyWith(
                                      fontSize: 16,
                                      color: ColorsConstants.defaultBlack,
                                      letterSpacing: -0.8,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    p.playerType == PlayerType.batter
                                        ? "${p.batterType?.title ?? ""} Batsman"
                                        : p.playerType == PlayerType.bowler
                                        ? p.bowlerType?.title ?? "Bowler"
                                        : "${p.batterType?.title ?? ""} • ${p.bowlerType?.title ?? ""}",
                                    style: TextStyles.poppinsRegular.copyWith(
                                      fontSize: 10,
                                      color: ColorsConstants.defaultBlack,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              p.playerId,
                              style: TextStyles.poppinsMedium.copyWith(
                                fontSize: 12,
                                color: ColorsConstants.defaultBlack,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      );
              }).toList(),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      showInvited ? "Total Invites" : "Total Players",
                      style: TextStyles.poppinsBold.copyWith(
                        fontSize: 20,
                        color: ColorsConstants.defaultBlack,
                        letterSpacing: -1,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${effectiveList.length}",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 20,
                        color: ColorsConstants.defaultBlack,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 12.0),
                  child: const Divider(thickness: 1, height: 1),
                ),
              ],
            ),
          ),

          if (!showInvited && captain != null)
            buildSection("Captain", [captain]),

          if (batters.isNotEmpty) buildSection("Batsmen", batters),
          if (bowlers.isNotEmpty) buildSection("Bowlers", bowlers),
          if (allRounders.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: buildSection("All-Rounders", allRounders),
            ),
        ],
      ),
    );
  }

  static Widget buildAlphabeticalList(List<PlayerEntity> players) {
    players = players.where((e) => e.teamRole != TeamRole.invited).toList();
    if (players.isEmpty) {
      return Center(
        child: Text(
          "No Team Members Yet",
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 16,
            letterSpacing: -0.8,
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    final sorted = [...players]..sort((a, b) => a.name.compareTo(b.name));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Row(
            children: [
              Text(
                "All Players (A–Z)",
                style: TextStyles.poppinsBold.copyWith(
                  fontSize: 20,
                  color: ColorsConstants.defaultBlack,
                  letterSpacing: -1,
                ),
              ),
              const Spacer(),
              Text(
                "${sorted.length}",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 20,
                  letterSpacing: -1,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1, height: 12),

        Column(
          children: sorted.map((p) {
            return _playerRow(p);
          }).toList(),
        ),
      ],
    );
  }

  static Widget buildActivePlayersList(List<PlayerEntity> players) {
    players = players.where((e) => e.teamRole != TeamRole.invited).toList();

    if (players.isEmpty) {
      return Center(
        child: Text(
          "No Team Members Yet",
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 16,
            color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
            letterSpacing: -0.8,
          ),
        ),
      );
    }

    final captain = players.any((p) => p.captain)
        ? players.firstWhere((p) => p.captain)
        : null;

    final withoutCaptain = captain != null
        ? players.where((p) => p.id != captain.id).toList()
        : players;

    final batters = withoutCaptain
        .where((p) => p.playerType == PlayerType.batter)
        .toList();
    final bowlers = withoutCaptain
        .where((p) => p.playerType == PlayerType.bowler)
        .toList();
    final allRounders = withoutCaptain
        .where((p) => p.playerType == PlayerType.allRounder)
        .toList();
    final substitutes = withoutCaptain
        .where((p) => p.teamRole == TeamRole.sub)
        .toList();

    Widget buildSection(String title, List<PlayerEntity> list) {
      if (list.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyles.poppinsBold.copyWith(
                    fontSize: 16,
                    color: ColorsConstants.defaultBlack,
                  ),
                ),
                const Spacer(),
                Text(
                  "${list.length}",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    color: ColorsConstants.defaultBlack,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1, height: 12),
            Column(children: list.map((p) => _playerRow(p)).toList()),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Row(
            children: [
              Text(
                "Active Players",
                style: TextStyles.poppinsBold.copyWith(
                  fontSize: 20,
                  letterSpacing: -1,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
              const Spacer(),
              Text(
                "${players.length}",
                style: TextStyles.poppinsSemiBold.copyWith(
                  fontSize: 20,
                  letterSpacing: -1,
                  color: ColorsConstants.defaultBlack,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1, height: 12),

        if (captain != null) buildSection("Captain", [captain]),

        if (batters.isNotEmpty) buildSection("Batsmen", batters),
        if (bowlers.isNotEmpty) buildSection("Bowlers", bowlers),
        if (allRounders.isNotEmpty) buildSection("All-Rounders", allRounders),

        if (substitutes.isNotEmpty) buildSection("Substitutes", substitutes),
      ],
    );
  }

  static Widget _playerRow(PlayerEntity p) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: ColorsConstants.accentOrange.withValues(
              alpha: 0.2,
            ),
            child: Icon(
              CupertinoIcons.person_fill,
              size: 16,
              color: ColorsConstants.defaultBlack,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${p.name} ${p.captain ? "(C)" : ""}",
                  style: TextStyles.poppinsMedium.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                    color: ColorsConstants.defaultBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  p.playerType == PlayerType.batter
                      ? "${p.batterType?.title ?? ""} Batsman"
                      : p.playerType == PlayerType.bowler
                      ? p.bowlerType?.title ?? "Bowler"
                      : "${p.batterType?.title ?? ""} • ${p.bowlerType?.title ?? ""}",
                  style: TextStyles.poppinsRegular.copyWith(
                    fontSize: 10,
                    letterSpacing: -0.2,
                    color: ColorsConstants.defaultBlack,
                  ),
                ),
              ],
            ),
          ),
          Text(
            p.playerId,
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 12,
              letterSpacing: -0.5,
              color: ColorsConstants.defaultBlack,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildTeamRow(
    TeamEntity team,
    OverallScoreEntity? score,
    MatchEntity matchEntity,
  ) {
    final matchStage = Methods.getStage(matchEntity);

    // Determine score text
    String scoreText = "-";
    double textOpacity = 1.0;

    if (matchStage == MatchStage.upcoming ||
        matchStage == MatchStage.waitingForToss) {
      // Match not started yet or toss pending
      scoreText = "-";
    } else if (matchStage == MatchStage.waitingForToss) {
      // Toss done but match yet to begin
      scoreText = "Yet to Bat";
    } else if (matchStage == MatchStage.firstInnings ||
        matchStage == MatchStage.secondInnings) {
      if (score != null) {
        // Team currently batting or already batted
        scoreText =
            "${score.score}${score.wickets == 10 ? "" : "/${score.wickets}"} (${score.overs})";
      } else {
        // Team hasn't batted yet in this stage
        scoreText = "Yet to Bat";
        textOpacity = 0.5; // faded for team yet to bat
      }
    } else if (matchStage == MatchStage.completed) {
      // Completed match — show both scores if available
      if (score != null) {
        scoreText =
            "${score.score}${score.wickets == 10 ? "" : "/${score.wickets}"} (${score.overs})";
      } else {
        scoreText = "Yet to Bat";
      }
    }

    // Dim losing team after match completion
    final bool isWinner = matchEntity.winner == team.id;
    final bool isCompleted = matchStage == MatchStage.completed;

    final baseColor = ColorsConstants.defaultBlack;
    final textColor = isCompleted
        ? (isWinner ? baseColor : baseColor.withValues(alpha: 0.3))
        : baseColor.withValues(alpha: textOpacity);

    return Row(
      children: [
        CircleAvatar(radius: 16, backgroundImage: AssetImage(team.teamLogo)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            team.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 12,
              letterSpacing: -0.5,
              color: ColorsConstants.defaultBlack,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          scoreText,
          style: TextStyles.poppinsMedium.copyWith(color: textColor),
        ),
      ],
    );
  }

  static Widget buildBattingTable({
    required List<Map<String, dynamic>> batsmen,
    required String strikerName,
  }) {
    if (batsmen.isEmpty) {
      batsmen = [
        {
          'name': '-',
          'runs': "-",
          'balls': "-",
          'fours': "-",
          'sixes': "-",
          'strikeRate': "-",
        },
        {
          'name': '-',
          'runs': "-",
          'balls': "-",
          'fours': "-",
          'sixes': "-",
          'strikeRate': "-",
        },
      ];
    }
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2.5), // Batsman name wider
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1.2),
      },
      border: TableBorder(
        horizontalInside: BorderSide(
          color: ColorsConstants.defaultBlack.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      children: [
        // 🟠 Header Row
        TableRow(
          decoration: BoxDecoration(
            color: ColorsConstants.accentOrange.withValues(alpha: 0.15),
          ),
          children: [
            _headerCell("Batsman"),
            _headerCell("R"),
            _headerCell("B"),
            _headerCell("4s"),
            _headerCell("6s"),
            _headerCell("SR"),
          ],
        ),

        // 🏏 Player Rows
        for (final player in batsmen)
          TableRow(
            children: [
              _batsmanNameCell(player['name'], player['name'] == strikerName),
              _dataCell("${player['runs']}"),
              _dataCell("${player['balls']}"),
              _dataCell("${player['fours']}"),
              _dataCell("${player['sixes']}"),
              _dataCell("${player['strikeRate']}"),
            ],
          ),
      ],
    );
  }

  static Widget buildBowlingTable(List<Map<String, dynamic>> bowlers) {
    if (bowlers.isEmpty) {
      bowlers = [
        {
          'name': '-',
          'overs': "-",
          'runs': "-",
          'maidens': "-",
          'wickets': "-",
          'economy': "-",
        },
      ];
    }
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2.5),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1.2),
      },
      border: TableBorder(
        horizontalInside: BorderSide(
          color: ColorsConstants.defaultBlack.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: ColorsConstants.accentOrange.withValues(alpha: 0.15),
          ),
          children: [
            _headerCell("Bowler"),
            _headerCell("O"),
            _headerCell("R"),
            _headerCell("M"),
            _headerCell("W"),
            _headerCell("Eco"),
          ],
        ),
        for (final bowler in bowlers)
          TableRow(
            children: [
              _dataCell(bowler['name']),
              _dataCell("${bowler['overs']}"),
              _dataCell("${bowler['runs']}"),
              _dataCell("${bowler['maidens']}"),
              _dataCell("${bowler['wickets']}"),
              _dataCell("${bowler['economy']}"),
            ],
          ),
      ],
    );
  }

  static Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        text,
        style: TextStyles.poppinsSemiBold.copyWith(
          fontSize: 12,
          color: ColorsConstants.defaultBlack,
          letterSpacing: -0.3,
        ),
      ),
    );
  }

  static Widget _batsmanNameCell(String name, bool isStriker) {
    if (isStriker) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsConstants.accentOrange,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(
            name,
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 12,
              color: ColorsConstants.defaultWhite,
              letterSpacing: -0.3,
            ),
          ),
        ),
      );
    }

    return _dataCell(name);
  }

  static Widget _dataCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        text,
        style: TextStyles.poppinsMedium.copyWith(
          fontSize: 12,
          color: ColorsConstants.defaultBlack,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}

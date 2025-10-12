import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/matches/domain/entities/overall_score_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/ball_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/match_player_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/overs_entity.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
import 'package:cricklo/features/scorer/presentation/widgets/commentary_ball_row.dart';
import 'package:cricklo/features/scorer/presentation/widgets/wagon_wheel_painter.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        CircleAvatar(
          radius: 16,
          backgroundImage: CachedNetworkImageProvider(team.teamLogo),
        ),
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
    required List<MatchPlayerEntity?> players,
    required MatchPlayerEntity? onStrike,
    required ScorerMatchCenterCubit cubit,
  }) {
    List<Map<String, dynamic>> batsmen = [];

    for (var i in players) {
      if (i == null) {
        batsmen.add({
          'name': '-',
          'runs': "-",
          'balls': "-",
          'fours': "-",
          'sixes': "-",
          'strikeRate': "-",
        });
      } else {
        batsmen.add({
          'name': i.name,
          'runs': i.stats.runs,
          'balls': i.stats.balls,
          'fours': i.stats.n4s,
          'sixes': i.stats.n6s,
          'strikeRate': i.stats.sr.toStringAsFixed(2),
        });
      }
    }
    for (int i = batsmen.length; i < 2; i++) {
      batsmen.add({
        'name': '-',
        'runs': "-",
        'balls': "-",
        'fours': "-",
        'sixes': "-",
        'strikeRate': "-",
      });
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
            headerCell("Batsman"),
            headerCell("R"),
            headerCell("B"),
            headerCell("4s"),
            headerCell("6s"),
            headerCell("SR"),
          ],
        ),

        // 🏏 Player Rows
        for (int i = 0; i < batsmen.length; i++)
          TableRow(
            children: [
              _batsmanNameCell(
                batsmen[i]['name'],
                onStrike == null ? false : onStrike.name == batsmen[i]['name'],
                () {
                  try {
                    cubit.setOnStrike(players[i]!);
                  } catch (e) {
                    rethrow;
                  }
                },
              ),
              _dataCell("${batsmen[i]['runs']}"),
              _dataCell("${batsmen[i]['balls']}"),
              _dataCell("${batsmen[i]['fours']}"),
              _dataCell("${batsmen[i]['sixes']}"),
              _dataCell("${batsmen[i]['strikeRate']}"),
            ],
          ),
      ],
    );
  }

  static Widget buildBowlingTable(MatchPlayerEntity? bowlerData) {
    Map<String, dynamic> bowler;
    if (bowlerData == null) {
      bowler = {
        'name': '-',
        'overs': "-",
        'runs': "-",
        'maidens': "-",
        'wickets': "-",
        'economy': "-",
      };
    } else {
      bowler = {
        'name': bowlerData.name,
        'overs': bowlerData.stats.overs,
        'runs': bowlerData.stats.runsGiven,
        'maidens': bowlerData.stats.maidens,
        'wickets': bowlerData.stats.wickets,
        'economy': bowlerData.stats.eco.toStringAsFixed(2),
      };
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
            headerCell("Bowler"),
            headerCell("O"),
            headerCell("R"),
            headerCell("M"),
            headerCell("W"),
            headerCell("Eco"),
          ],
        ),
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

  static Widget headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        text,
        style: TextStyles.poppinsSemiBold.copyWith(
          fontSize: 12,
          color: ColorsConstants.defaultBlack,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  static Widget _batsmanNameCell(
    String name,
    bool isStriker,
    Function() onTap,
  ) {
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
            "$name*",
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 12,
              color: ColorsConstants.defaultWhite,
              letterSpacing: -0.3,
            ),
          ),
        ),
      );
    }

    return GestureDetector(onTap: () => onTap(), child: _dataCell(name));
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

  static Future<int?> showWagonWheelBottomSheet(
    BuildContext context,
    int runs,
  ) async {
    final sector = await showModalBottomSheet(
      context: context,
      backgroundColor: ColorsConstants.defaultWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        bool showPercentages = false; // local state inside bottom sheet

        return StatefulBuilder(
          builder: (context, setModalState) {
            return SizedBox(
              height: 500,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Select Shot Direction for $runs run${runs > 1 ? 's' : ''}",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTapUp: (details) {
                        final box = context.findRenderObject() as RenderBox?;
                        if (box == null) return;
                        final localPos = box.globalToLocal(
                          details.globalPosition,
                        );

                        final center = Offset(
                          box.size.width / 2,
                          box.size.height / 2,
                        );
                        final dx = localPos.dx - center.dx;
                        final dy = localPos.dy - center.dy;

                        final angle =
                            (math.atan2(dy, dx) + 2 * math.pi) % (2 * math.pi);
                        const sectors = 8;
                        final sector = (angle / (2 * math.pi) * sectors)
                            .floor();
                        GoRouter.of(context).pop(sector);
                      },
                      child: SizedBox.expand(
                        child: CustomPaint(
                          painter: WagonWheelPainter(
                            shots: [],
                            showPercentages: showPercentages,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    return sector;
  }

  static Widget cell(String title, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 16,
              letterSpacing: -0.8,
              color: ColorsConstants.defaultWhite,
            ),
          ),
        ),
      ),
    );
  }

  static void showSelectBatsmenBottomSheet(
    BuildContext context, {
    required List<MatchPlayerEntity> players,
    required int maxSelection, // 1 or 2
    bool bowler = false,
    String? title,
    List<MatchPlayerEntity?>? currBatsmen, // 👈 NEW
    OversEntity? overEntity, // 👈 NEW
    required Function(List<MatchPlayerEntity>) onConfirm,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorsConstants.defaultWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        List<MatchPlayerEntity> selectedPlayers = [];

        return StatefulBuilder(
          builder: (context, setModalState) {
            /// Determine if a player should be disabled
            bool isPlayerDisabled(MatchPlayerEntity player) {
              // 1️⃣ Batsman selection
              if (!bowler && title == null) {
                final isCurrentBatsman =
                    currBatsmen?.any((p) => p?.playerId == player.playerId) ??
                    false;
                if (isCurrentBatsman) return true;
                if (player.stats.out) return true;
              }

              // 2️⃣ Bowler selection
              if (bowler && title == null) {
                if (overEntity?.bowler.playerId == player.playerId) return true;
              }

              // 3️⃣ Generic (title != null)
              if (title != null) {
                if (overEntity?.bowler.playerId == player.playerId) return true;
              }

              return false;
            }

            /// Group players by type
            final grouped = {
              "Batting": players
                  .where((p) => p.playerType == PlayerType.batter)
                  .toList(),
              "All Rounder": players
                  .where((p) => p.playerType == PlayerType.allRounder)
                  .toList(),
              "Bowling": players
                  .where((p) => p.playerType == PlayerType.bowler)
                  .toList(),
            };

            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Scaffold(
                  backgroundColor: ColorsConstants.defaultWhite,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        disabled: selectedPlayers.length != maxSelection,
                        onPress: selectedPlayers.length == maxSelection
                            ? () {
                                onConfirm(selectedPlayers);
                                Navigator.pop(context);
                              }
                            : () {},
                        child: Text(
                          "Confirm Selection",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 16,
                            color: ColorsConstants.defaultWhite,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  body: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          title ??
                              (bowler
                                  ? "Select Bowler"
                                  : "Select ${maxSelection == 1 ? 'Batsman' : 'Batsmen'}"),
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 16,
                            letterSpacing: -0.6,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: grouped.entries.map((entry) {
                            final role = entry.key;
                            final rolePlayers = entry.value;

                            if (rolePlayers.isEmpty) return SizedBox.shrink();

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    role,
                                    style: TextStyles.poppinsSemiBold.copyWith(
                                      fontSize: 16,
                                      letterSpacing: -0.8,
                                      color: ColorsConstants.accentOrange,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // Player list
                                  ...rolePlayers.map((player) {
                                    final isSelected = selectedPlayers.contains(
                                      player,
                                    );
                                    final isDisabled = isPlayerDisabled(player);

                                    return Opacity(
                                      opacity: isDisabled ? 0.5 : 1.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          onTap: isDisabled
                                              ? null
                                              : () {
                                                  setModalState(() {
                                                    if (isSelected) {
                                                      selectedPlayers.remove(
                                                        player,
                                                      );
                                                    } else if (selectedPlayers
                                                            .length <
                                                        maxSelection) {
                                                      selectedPlayers.add(
                                                        player,
                                                      );
                                                    } else {
                                                      selectedPlayers.removeAt(
                                                        0,
                                                      );
                                                      selectedPlayers.add(
                                                        player,
                                                      );
                                                    }
                                                  });
                                                },
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? ColorsConstants.accentOrange
                                                        .withValues(alpha: 0.2)
                                                  : ColorsConstants
                                                        .defaultWhite,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: isSelected
                                                    ? ColorsConstants
                                                          .accentOrange
                                                    : ColorsConstants
                                                          .defaultBlack
                                                          .withValues(
                                                            alpha: 0.3,
                                                          ),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      ColorsConstants
                                                          .accentOrange
                                                          .withValues(
                                                            alpha: 0.2,
                                                          ),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: ColorsConstants
                                                        .defaultBlack,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        player.name,
                                                        style: TextStyles
                                                            .poppinsMedium
                                                            .copyWith(
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  -0.5,
                                                            ),
                                                      ),
                                                      Text(
                                                        player.playerId,
                                                        style: TextStyles
                                                            .poppinsMedium
                                                            .copyWith(
                                                              fontSize: 10,
                                                              letterSpacing:
                                                                  -0.2,
                                                              color: ColorsConstants
                                                                  .defaultBlack
                                                                  .withValues(
                                                                    alpha: 0.5,
                                                                  ),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  bowler
                                                      ? "${player.stats.wickets}-${player.stats.runsGiven} (${player.stats.overs})"
                                                      : player.stats.out
                                                      ? "${player.stats.runs} (${player.stats.balls})"
                                                      : "",
                                                  style: TextStyles
                                                      .poppinsRegular
                                                      .copyWith(
                                                        fontSize: 12,
                                                        letterSpacing: -0.5,
                                                        color: ColorsConstants
                                                            .defaultBlack,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> showOnRunOut(
    BuildContext context,
    List<MatchPlayerEntity?> batsmen,
    List<MatchPlayerEntity> bowlingTeam,
    Function(MatchPlayerEntity batsman, MatchPlayerEntity fielder, int runs)
    onComplete,
  ) async {
    MatchPlayerEntity? selectedBatsman;
    MatchPlayerEntity? selectedFielder;
    int? selectedRuns;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Scaffold(
                  backgroundColor: ColorsConstants.defaultWhite,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        disabled: false,
                        onPress: () {
                          onComplete(
                            selectedBatsman!,
                            selectedFielder!,
                            selectedRuns ?? 0,
                          );
                          GoRouter.of(context).pop();
                        },
                        child: Text(
                          "Confirm Selection",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 16,
                            color: ColorsConstants.defaultWhite,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Run-Out Details",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.6,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Batsman Selection
                      Text(
                        "Select Batsman",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: batsmen.map((batsman) {
                          final isSelected = selectedBatsman?.id == batsman!.id;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => selectedBatsman = batsman),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorsConstants.accentOrange.withValues(
                                        alpha: 0.2,
                                      )
                                    : ColorsConstants.defaultWhite,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? ColorsConstants.accentOrange
                                      : ColorsConstants.defaultBlack.withValues(
                                          alpha: 0.3,
                                        ),
                                ),
                              ),
                              width: 100,
                              height: 150,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: ColorsConstants
                                        .accentOrange
                                        .withValues(alpha: 0.2),
                                    radius: 30,
                                    child: Icon(
                                      Icons.person,
                                      size: 24,
                                      color: ColorsConstants.defaultBlack,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    batsman.name,
                                    style: TextStyles.poppinsMedium.copyWith(
                                      fontSize: 12,
                                      letterSpacing: -0.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    batsman.playerId,
                                    style: TextStyles.poppinsMedium.copyWith(
                                      fontSize: 12,
                                      letterSpacing: -0.2,
                                      color: ColorsConstants.defaultBlack
                                          .withValues(alpha: 0.2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      // Fielder Selection
                      Text(
                        "Select Fielder",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            showSelectBatsmenBottomSheet(
                              context,
                              players: bowlingTeam,
                              maxSelection: 1,
                              onConfirm: (player) {
                                setState(() {
                                  if (player.isNotEmpty) {
                                    selectedFielder = player.last;
                                  }
                                });
                              },
                            );
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: selectedFielder == null
                                    ? Colors.grey.shade300
                                    : ColorsConstants.accentOrange.withValues(
                                        alpha: 0.2,
                                      ),
                                child: selectedFielder == null
                                    ? Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.person,
                                        size: 30,
                                        color: ColorsConstants.defaultBlack,
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                selectedFielder?.name ?? "Fielder",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Completed Runs Selection
                      Text(
                        "Completed Runs",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 12,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        children: List.generate(6, (index) {
                          final run = index + 1;
                          final isSelected = selectedRuns == run;
                          return ChoiceChip(
                            selectedColor: ColorsConstants.accentOrange
                                .withValues(alpha: 0.2),
                            label: Text(run.toString()),
                            selected: isSelected,
                            onSelected: (_) =>
                                setState(() => selectedRuns = run),
                          );
                        }),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static List<Widget> renderCommentaryBallWidget(
    List<BallEntity> balls,
    OversEntity over,
  ) {
    int legalCount = 0;

    // First, compute all balls with correct numbering
    final numberedBalls = balls.asMap().entries.map((entry) {
      final ball = entry.value;

      final legalDelivery =
          !ball.isExtra ||
          ball.extraType == ExtraType.bye ||
          ball.extraType == ExtraType.legBye;

      if (legalDelivery) legalCount++;

      final ballNumber = "${over.overNumber - 1}.$legalCount";

      return CommentaryBallRow(ballNumber: ballNumber, ball: ball);
    }).toList();

    // Then reverse them so latest ball is shown first
    return numberedBalls.reversed
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: e,
          ),
        )
        .toList();
  }
}

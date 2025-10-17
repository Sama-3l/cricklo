import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

Future<Map<String, String>?> showTossDialog(
  BuildContext context, {
  required String teamAId,
  required String teamBId,
  required String teamAName,
  required String teamALogo,
  required String teamBName,
  required String teamBLogo,
}) {
  String? tossWinner;
  String? tossChoice;

  return showModalBottomSheet<Map<String, String>?>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Toss Decision",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 24,
                    color: ColorsConstants.defaultBlack,
                    letterSpacing: -1.2,
                  ),
                ),
                const SizedBox(height: 24),

                // Who won the toss?
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Who won the toss?",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _TeamOption(
                        selected: tossWinner == teamAId,
                        teamName: teamAName,
                        teamId: teamAId,
                        logoUrl: teamALogo,
                        onTap: () => setState(() => tossWinner = teamAId),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _TeamOption(
                        selected: tossWinner == teamBId,
                        teamName: teamBName,
                        teamId: teamBId,
                        logoUrl: teamBLogo,
                        onTap: () => setState(() => tossWinner = teamBId),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Choice to?
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choice to",
                    style: TextStyles.poppinsMedium.copyWith(
                      fontSize: 14,
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _ChoiceOption(
                        title: "Bat First",
                        selected: tossChoice == "Bat First",
                        onTap: () => setState(() => tossChoice = "Bat First"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _ChoiceOption(
                        title: "Bowl First",
                        selected: tossChoice == "Bowl First",
                        onTap: () => setState(() => tossChoice = "Bowl First"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Confirm button
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    disabled: tossWinner == null || tossChoice == null,
                    child: Text(
                      "Confirm",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 16,
                        color: ColorsConstants.defaultWhite,
                      ),
                    ),
                    onPress: () {
                      if (tossWinner != null && tossChoice != null) {
                        Navigator.pop(context, {
                          "winner": tossWinner!,
                          "choice": tossChoice!,
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// --- TEAM OPTION WIDGET ---
class _TeamOption extends StatelessWidget {
  final String teamName;
  final String teamId;
  final String logoUrl;
  final bool selected;
  final VoidCallback onTap;

  const _TeamOption({
    required this.teamName,
    required this.teamId,
    required this.logoUrl,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? ColorsConstants.accentOrange
                : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              child: Icon(
                Icons.people,
                size: 24,
                color: ColorsConstants.defaultBlack,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              teamName,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 12,
                letterSpacing: -0.5,
                color: selected
                    ? ColorsConstants.accentOrange
                    : ColorsConstants.defaultBlack,
              ),
            ),
            Text(
              teamId,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.poppinsMedium.copyWith(
                fontSize: 10,
                letterSpacing: -0.2,
                color: selected
                    ? ColorsConstants.accentOrange.withValues(alpha: 0.5)
                    : ColorsConstants.defaultBlack.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- CHOICE OPTION WIDGET ---
class _ChoiceOption extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _ChoiceOption({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? ColorsConstants.accentOrange
                : ColorsConstants.defaultBlack.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 12,
            letterSpacing: -0.5,
            color: selected
                ? ColorsConstants.accentOrange
                : ColorsConstants.defaultBlack,
          ),
        ),
      ),
    );
  }
}

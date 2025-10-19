import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/presentation/widgets/search_players_bottom_sheet.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddModeratorsPage extends StatefulWidget {
  const AddModeratorsPage({super.key, required this.tournament});

  final TournamentEntity tournament;

  @override
  State<AddModeratorsPage> createState() => _AddModeratorsPageState();
}

class _AddModeratorsPageState extends State<AddModeratorsPage> {
  final List<_ModeratorSelector> _moderators = [];

  void _addModerator() {
    setState(() {
      _moderators.add(_ModeratorSelector(onUpdate: _refresh));
    });
  }

  void _removeModerator() {
    if (_moderators.isNotEmpty) {
      setState(() {
        _moderators.removeLast();
      });
    }
  }

  void _refresh() => setState(() {});

  @override
  void initState() {
    super.initState();
    _addModerator(); // start with one moderator selector
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsConstants.defaultWhite,
      appBar: AppBar(
        backgroundColor: ColorsConstants.accentOrange,
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: Icon(Icons.chevron_left, color: ColorsConstants.defaultWhite),
          iconSize: 32,
        ),
        title: Text(
          "Add Moderators",
          style: TextStyles.poppinsMedium.copyWith(
            fontSize: 24,
            letterSpacing: -1.2,
            color: ColorsConstants.defaultWhite,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(bottom: 16),
        child: SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            disabled: false,

            child: Text(
              "Continue",
              style: TextStyles.poppinsSemiBold.copyWith(
                fontSize: 16,
                letterSpacing: -0.6,
                color: ColorsConstants.defaultWhite,
              ),
            ),
            onPress: () {
              // final tournament = widget.tournament.copyWith(
              //   venues: _moderators
              //       .map(
              //         (e) => Methods.getLocationEntity(
              //           e.areaController.text,
              //           e.locationController.text,
              //         ),
              //       )
              //       .toList(),
              // );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Moderators",
                  style: TextStyles.poppinsSemiBold.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.8,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: _moderators.length > 1
                          ? _removeModerator
                          : null,
                      tooltip: "Remove last moderator",
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: _addModerator,
                      tooltip: "Add moderator",
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._moderators.map((m) => m.build(context)).toList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ModeratorSelector {
  final VoidCallback onUpdate;
  dynamic selectedModerator;

  _ModeratorSelector({required this.onUpdate});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Moderator",
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 12,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SearchPlayersBottomSheet(
                  initiallySelected: [],
                  singleSelect: true,
                ),
              );
              if (result != null && result.isNotEmpty) {
                selectedModerator = result.last;
                onUpdate();
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorsConstants.onSurfaceGrey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedModerator != null) ...[
                    Text(
                      selectedModerator!.name,
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                    ),
                    Text(
                      selectedModerator!.playerId,
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 12,
                        letterSpacing: -0.4,
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                  if (selectedModerator == null)
                    Text(
                      "Select Moderator",
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

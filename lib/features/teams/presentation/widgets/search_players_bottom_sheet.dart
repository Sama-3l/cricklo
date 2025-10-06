import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/dummy_data.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPlayersBottomSheet extends StatefulWidget {
  final List<PlayerEntity> initiallySelected; // Pass selected players here

  const SearchPlayersBottomSheet({
    super.key,
    this.initiallySelected = const [],
  });

  @override
  State<SearchPlayersBottomSheet> createState() =>
      _SearchPlayersBottomSheetState();
}

class _SearchPlayersBottomSheetState extends State<SearchPlayersBottomSheet> {
  late List<PlayerEntity> selectedPlayers;
  late List<PlayerEntity> filteredPlayers;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchNode = FocusNode();
  bool captainAlloted = false;

  @override
  void initState() {
    super.initState();
    // start with already selected players
    selectedPlayers = List<PlayerEntity>.from(widget.initiallySelected);
    // sync captainAlloted flag
    captainAlloted = selectedPlayers.any((p) => p.captain);
    filteredPlayers = dummyPlayers;
    searchNode.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  void _filterPlayers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPlayers = dummyPlayers;
      } else {
        filteredPlayers = dummyPlayers
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Scaffold(
          backgroundColor: ColorsConstants.defaultWhite,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: selectedPlayers.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      disabled: false,
                      child: Text(
                        "Confirm",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.6,
                          color: ColorsConstants.defaultWhite,
                        ),
                      ),
                      onPress: () {
                        GoRouter.of(context).pop(selectedPlayers);
                      },
                    ),
                  ),
                )
              : null,
          body: Column(
            children: [
              Container(
                color: ColorsConstants.defaultWhite,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    InputField(
                      controller: searchController,
                      onChanged: _filterPlayers,
                      prefixIcon: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: searchNode.hasFocus
                              ? ColorsConstants.defaultBlack
                              : ColorsConstants.defaultBlack.withValues(
                                  alpha: 0.3,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 12,
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.6,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Long Press to select Captain",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              color: ColorsConstants.defaultBlack.withValues(
                                alpha: 0.6,
                              ),
                              fontSize: 10,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),

              Expanded(
                child: ListView.separated(
                  itemCount: filteredPlayers.length,
                  separatorBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Divider(height: 1),
                  ),
                  itemBuilder: (context, index) {
                    final player = filteredPlayers[index];
                    final bool selected = selectedPlayers.any(
                      (p) => p.playerId == player.playerId,
                    );

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == filteredPlayers.length - 1 ? 32 : 0,
                      ),
                      child: ListTile(
                        selected: selected,
                        selectedTileColor: ColorsConstants.accentOrange,
                        leading: Icon(
                          player.playerType == PlayerType.batter
                              ? Icons.sports_cricket
                              : player.playerType == PlayerType.bowler
                              ? Icons.sports_baseball
                              : Icons.star,
                          color: selected
                              ? ColorsConstants.defaultWhite
                              : ColorsConstants.defaultBlack,
                        ),
                        trailing: Text(
                          player.playerId,
                          style: TextStyles.poppinsMedium.copyWith(
                            fontSize: 12,
                            color: selected
                                ? ColorsConstants.defaultWhite
                                : ColorsConstants.defaultBlack,
                            letterSpacing: -0.5,
                          ),
                        ),
                        title: Text(
                          player.captain ? "${player.name} (C)" : player.name,
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 16,
                            color: selected
                                ? ColorsConstants.defaultWhite
                                : ColorsConstants.defaultBlack,
                            letterSpacing: -0.8,
                          ),
                        ),
                        subtitle: Text(
                          player.playerType == PlayerType.batter
                              ? "${player.batterType?.title ?? ""} Batsman"
                              : player.playerType == PlayerType.bowler
                              ? player.bowlerType?.title ?? "Bowler"
                              : "${player.batterType?.title ?? ""} • ${player.bowlerType?.title ?? ""}",
                          style: TextStyles.poppinsRegular.copyWith(
                            fontSize: 10,
                            color: selected
                                ? ColorsConstants.defaultWhite
                                : ColorsConstants.defaultBlack,
                            letterSpacing: -0.2,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (selected) {
                              selectedPlayers.removeWhere(
                                (p) => p.playerId == player.playerId,
                              );
                              filteredPlayers[index] = player.copyWith(
                                captain: false,
                              );
                              captainAlloted = selectedPlayers.any(
                                (p) => p.captain,
                              ); // sync again
                            } else {
                              selectedPlayers.add(player);
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

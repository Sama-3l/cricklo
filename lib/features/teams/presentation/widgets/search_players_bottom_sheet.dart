import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/SearchPlayersCubit/search_players_cubit.dart';
import 'package:cricklo/injection_container.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchPlayersBottomSheet extends StatefulWidget {
  final List<SearchUserEntity> initiallySelected; // Pass selected players here

  final bool singleSelect;

  const SearchPlayersBottomSheet({
    super.key,
    this.initiallySelected = const [],
    this.singleSelect = false,
  });

  @override
  State<SearchPlayersBottomSheet> createState() =>
      _SearchPlayersBottomSheetState();
}

class _SearchPlayersBottomSheetState extends State<SearchPlayersBottomSheet> {
  late List<SearchUserEntity> selectedPlayers;
  late List<SearchUserEntity> filteredPlayers;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchNode = FocusNode();
  bool captainAlloted = false;

  @override
  void initState() {
    super.initState();
    // start with already selected players
    selectedPlayers = List<SearchUserEntity>.from(widget.initiallySelected);
    searchNode.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchPlayersCubit>(),
      child: BlocBuilder<SearchPlayersCubit, SearchPlayersState>(
        builder: (context, state) {
          final cubit = context.read<SearchPlayersCubit>();
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
                            autofocus: true,
                            controller: searchController,
                            onChanged: (value) => cubit.onQueryChanged(value),
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
                        ],
                      ),
                    ),

                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent - 100 &&
                              !state.loading) {
                            context.read<SearchPlayersCubit>().loadMore();
                          }
                          return false;
                        },
                        child: ListView.separated(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount:
                              state.searchResults.length +
                              (state.loading ? 1 : 0),
                          separatorBuilder: (_, __) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.0),
                            child: Divider(height: 1),
                          ),
                          itemBuilder: (context, index) {
                            if (index == state.searchResults.length) {
                              // 👇 This is your "Loading more..." spinner at the bottom
                              return Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: ColorsConstants.accentOrange,
                                    ),
                                  ),
                                ),
                              );
                            }

                            final player = state.searchResults[index];
                            final bool selected = selectedPlayers.any(
                              (p) => p.playerId == player.playerId,
                            );

                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == state.searchResults.length - 1
                                    ? 16
                                    : 0,
                              ),
                              child: ListTile(
                                onLongPress: () => GoRouter.of(
                                  context,
                                ).push(Routes.profilePage, extra: player.id),
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
                                  player.name,
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
                                    if (widget.singleSelect) {
                                      if (selected) {
                                        selectedPlayers.removeWhere(
                                          (p) => p.playerId == player.playerId,
                                        );
                                      } else {
                                        selectedPlayers.clear();
                                        selectedPlayers.add(player);
                                      }
                                    } else {
                                      if (selected) {
                                        selectedPlayers.removeWhere(
                                          (p) => p.playerId == player.playerId,
                                        );
                                      } else {
                                        selectedPlayers.add(player);
                                      }
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Expanded(
                    //   child: state.loading
                    //       ? Center(
                    //           child: SizedBox(
                    //             height: 24,
                    //             width: 24,
                    //             child: CircularProgressIndicator(
                    //               color: ColorsConstants.accentOrange,
                    //             ),
                    //           ),
                    //         )
                    //       : state.searchResults.isEmpty
                    //       ? Center(
                    //           child: Text(
                    //             "Find Players",
                    //             style: TextStyles.poppinsMedium.copyWith(
                    //               fontSize: 16,
                    //               color: ColorsConstants.defaultBlack
                    //                   .withValues(alpha: 0.5),
                    //               letterSpacing: -0.8,
                    //             ),
                    //           ),
                    //         )
                    //       : ListView.separated(
                    //           itemCount: state.searchResults.length,
                    //           separatorBuilder: (_, __) => const Padding(
                    //             padding: EdgeInsets.symmetric(horizontal: 32.0),
                    //             child: Divider(height: 1),
                    //           ),
                    //           itemBuilder: (context, index) {
                    //             final player = state.searchResults[index];
                    //             final bool selected = selectedPlayers.any(
                    //               (p) => p.playerId == player.playerId,
                    //             );
                    //             return Padding(
                    //               padding: EdgeInsets.only(
                    //                 bottom:
                    //                     index == state.searchResults.length - 1
                    //                     ? 32
                    //                     : 0,
                    //               ),
                    //               child: ListTile(
                    //                 selected: selected,
                    //                 selectedTileColor:
                    //                     ColorsConstants.accentOrange,
                    //                 leading: Icon(
                    //                   player.playerType == PlayerType.batter
                    //                       ? Icons.sports_cricket
                    //                       : player.playerType ==
                    //                             PlayerType.bowler
                    //                       ? Icons.sports_baseball
                    //                       : Icons.star,
                    //                   color: selected
                    //                       ? ColorsConstants.defaultWhite
                    //                       : ColorsConstants.defaultBlack,
                    //                 ),
                    //                 trailing: Text(
                    //                   player.playerId,
                    //                   style: TextStyles.poppinsMedium.copyWith(
                    //                     fontSize: 12,
                    //                     color: selected
                    //                         ? ColorsConstants.defaultWhite
                    //                         : ColorsConstants.defaultBlack,
                    //                     letterSpacing: -0.5,
                    //                   ),
                    //                 ),
                    //                 title: Text(
                    //                   player.name,
                    //                   style: TextStyles.poppinsSemiBold
                    //                       .copyWith(
                    //                         fontSize: 16,
                    //                         color: selected
                    //                             ? ColorsConstants.defaultWhite
                    //                             : ColorsConstants.defaultBlack,
                    //                         letterSpacing: -0.8,
                    //                       ),
                    //                 ),
                    //                 subtitle: Text(
                    //                   player.playerType == PlayerType.batter
                    //                       ? "${player.batterType?.title ?? ""} Batsman"
                    //                       : player.playerType ==
                    //                             PlayerType.bowler
                    //                       ? player.bowlerType?.title ?? "Bowler"
                    //                       : "${player.batterType?.title ?? ""} • ${player.bowlerType?.title ?? ""}",
                    //                   style: TextStyles.poppinsRegular.copyWith(
                    //                     fontSize: 10,
                    //                     color: selected
                    //                         ? ColorsConstants.defaultWhite
                    //                         : ColorsConstants.defaultBlack,
                    //                     letterSpacing: -0.2,
                    //                   ),
                    //                 ),
                    //                 onTap: () {
                    //                   setState(() {
                    //                     if (selected) {
                    //                       selectedPlayers.removeWhere(
                    //                         (p) =>
                    //                             p.playerId == player.playerId,
                    //                       );
                    //                     } else {
                    //                       selectedPlayers.add(player);
                    //                     }
                    //                   });
                    //                 },
                    //               ),
                    //             );
                    //           },
                    //         ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

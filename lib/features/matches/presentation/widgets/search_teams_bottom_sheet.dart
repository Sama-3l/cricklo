import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/matches/presentation/blocs/cubits/SearchTeamCubit/search_team_cubit.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/injection_container.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchTeamsBottomSheet extends StatefulWidget {
  final List<TeamEntity> initiallySelected; // Pass selected players here
  final bool multiSelect;

  const SearchTeamsBottomSheet({
    super.key,
    this.initiallySelected = const [],
    this.multiSelect = false,
  });

  @override
  State<SearchTeamsBottomSheet> createState() => _SearchTeamsBottomSheetState();
}

class _SearchTeamsBottomSheetState extends State<SearchTeamsBottomSheet> {
  late List<TeamEntity> selectedTeams = [];
  late List<TeamEntity> filteredTeams;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // start with already selected players
    // selectedTeams = List<TeamEntity>.from(widget.initiallySelected);
    searchNode.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchTeamCubit>(),
      child: BlocBuilder<SearchTeamCubit, SearchTeamState>(
        builder: (context, state) {
          final cubit = context.read<SearchTeamCubit>();
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Scaffold(
                backgroundColor: ColorsConstants.defaultWhite,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: selectedTeams.isNotEmpty
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
                              GoRouter.of(context).pop(selectedTeams);
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

                          final team = state.searchResults[index];
                          bool selected = selectedTeams.any(
                            (p) => p.id == team.id,
                          );
                          final bool initiallySeleted = widget.initiallySelected
                              .any((e) => e.id == team.id);
                          selected = selected || initiallySeleted;

                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == state.searchResults.length - 1
                                  ? 16
                                  : 0,
                            ).copyWith(top: 6, bottom: 6),
                            child: InkWell(
                              onLongPress: () => GoRouter.of(context).push(
                                Routes.teamPage,
                                extra: [
                                  state.searchResults[index],
                                  <MatchEntity>[],
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  if (!initiallySeleted) {
                                    if (selected) {
                                      selectedTeams.removeWhere(
                                        (p) => p.id == team.id,
                                      );
                                    } else {
                                      if (!widget.multiSelect) {
                                        selectedTeams.clear();
                                      }
                                      selectedTeams.add(team);
                                    }
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? ColorsConstants.accentOrange
                                      : ColorsConstants.defaultWhite,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                            team.teamLogo,
                                          ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        team.name,
                                        style: TextStyles.poppinsSemiBold
                                            .copyWith(
                                              fontSize: 12,
                                              color: selected
                                                  ? ColorsConstants.defaultWhite
                                                  : ColorsConstants
                                                        .defaultBlack,
                                              letterSpacing: -0.5,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        team.id,
                                        textAlign: TextAlign.end,
                                        style: TextStyles.poppinsMedium
                                            .copyWith(
                                              fontSize: 10,
                                              color: selected
                                                  ? ColorsConstants.defaultWhite
                                                  : ColorsConstants
                                                        .defaultBlack,
                                              letterSpacing: -0.2,
                                            ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        },
      ),
    );
  }
}

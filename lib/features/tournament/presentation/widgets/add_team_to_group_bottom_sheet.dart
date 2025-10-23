import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/common/textfield.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_team_entity.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/AddTeamToGroupCubit/add_team_to_group_cubit.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddTeamToGroupBottomSheet extends StatefulWidget {
  final List<TournamentTeamEntity> allTeams; // Pass selected players here

  const AddTeamToGroupBottomSheet({super.key, this.allTeams = const []});

  @override
  State<AddTeamToGroupBottomSheet> createState() =>
      _AddTeamToGroupBottomSheetState();
}

class _AddTeamToGroupBottomSheetState extends State<AddTeamToGroupBottomSheet> {
  late List<TournamentTeamEntity> selectedTeams = [];
  late List<TournamentTeamEntity> filteredTeams;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // start with already selected players
    // selectedTeams = widget.allTeams;
    searchNode.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTeamToGroupCubit()..init(widget.allTeams),
      child: BlocBuilder<AddTeamToGroupCubit, AddTeamToGroupState>(
        builder: (context, state) {
          final cubit = context.read<AddTeamToGroupCubit>();
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
                body: state.searchResults.isEmpty
                    ? Center(
                        child: Text(
                          "No Teams Yet",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 24,
                            letterSpacing: -1.2,
                            color: ColorsConstants.accentOrange,
                          ),
                        ),
                      )
                    : Column(
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
                                  hintText: "Rajasthan Revolvers",
                                  onChanged: (value) =>
                                      cubit.searchTeams(value, widget.allTeams),
                                  prefixIcon: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.search,
                                      size: 20,
                                      color: searchNode.hasFocus
                                          ? ColorsConstants.defaultBlack
                                          : ColorsConstants.defaultBlack
                                                .withValues(alpha: 0.3),
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
                                final bool selected = selectedTeams.any(
                                  (p) => p.id == team.id,
                                );

                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        index == state.searchResults.length - 1
                                        ? 16
                                        : 0,
                                  ).copyWith(top: 6, bottom: 6),
                                  child: InkWell(
                                    onLongPress: () =>
                                        GoRouter.of(context).push(
                                          Routes.teamPage,
                                          extra: [
                                            state.searchResults[index],
                                            <MatchEntity>[],
                                          ],
                                        ),
                                    onTap: () {
                                      setState(() {
                                        if (selected) {
                                          selectedTeams.removeWhere(
                                            (p) => p.id == team.id,
                                          );
                                        } else {
                                          // selectedTeams.clear();
                                          selectedTeams.add(team);
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
                                                        ? ColorsConstants
                                                              .defaultWhite
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
                                                        ? ColorsConstants
                                                              .defaultWhite
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

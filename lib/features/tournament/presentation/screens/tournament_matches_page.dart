import 'package:cricklo/core/utils/common/secondary_button.dart';
import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile.dart';
import 'package:cricklo/features/home/presentation/widgets/shimmer_match_tile.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TournamentMatchesPage extends StatelessWidget {
  final bool loading;

  const TournamentMatchesPage({super.key, this.loading = false});

  bool _isScheduled(MatchEntity match) {
    final hasValidLocation = match.location == null
        ? false
        : match.location!.city.isNotEmpty; // ensure city exists
    final hasValidScorer = (match.scorer['name'] ?? '')
        .toString()
        .trim()
        .isNotEmpty;

    return hasValidLocation && hasValidScorer;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TournamentCubit>();
    final state = context.read<TournamentCubit>().state;
    final tournament = state.tournamentEntity;

    if (loading || tournament == null || state.loading) {
      return Scaffold(
        backgroundColor: ColorsConstants.onSurfaceGrey,
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: 6,
          itemBuilder: (_, __) => const ShimmerMatchTile(),
        ),
      );
    }

    final allGroupMatches = tournament.groupMatches;
    final playoffMatches = tournament.playoffMatches;

    // 🔹 Separate scheduled vs unscheduled based on the new rule
    final scheduledMatches = [
      ...allGroupMatches,
      ...playoffMatches,
    ].where(_isScheduled).toList();

    final unscheduledGroupMatches = allGroupMatches
        .where((m) => !_isScheduled(m))
        .toList();

    // 🔹 Sort scheduled matches by date and time
    scheduledMatches.sort((a, b) => a.dateAndTime.compareTo(b.dateAndTime));

    return Scaffold(
      backgroundColor: ColorsConstants.onSurfaceGrey,
      body: allGroupMatches.isEmpty
          ? Column(
              children: [
                Expanded(
                  child: Center(
                    child:
                        state.tournamentEntity!.tournamentType ==
                            TournamentType.knockout
                        ? SecondaryButton(
                            onTap: () => cubit.createKnockoutMatches(context),
                            title: "Create Group Matches",
                          )
                        : Text(
                            "No Matches Yet",
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 24,
                              letterSpacing: -1.2,
                              color: ColorsConstants.accentOrange,
                            ),
                          ),
                  ),
                ),
              ],
            )
          : RefreshIndicator(
              color: ColorsConstants.accentOrange,
              onRefresh: () async {
                await cubit.init(context, state.tournamentEntity!);
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                children: [
                  // --- Scheduled Matches ---
                  if (scheduledMatches.isNotEmpty)
                    ..._buildScheduledMatchesByDate(context, scheduledMatches),

                  // --- Group Matches Divider ---
                  if (unscheduledGroupMatches.isNotEmpty)
                    _buildDivider("GROUP MATCHES"),

                  // --- Unscheduled Group Matches ---
                  ...unscheduledGroupMatches.map(
                    (m) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: MatchTile(
                        dateSet: false,
                        matchEntity: m,
                        onTap: () {
                          if (state.tournamentEntity!.moderators
                                  .map((e) => e.playerId)
                                  .contains(GlobalVariables.user!.profileId) ||
                              state.tournamentEntity!.organizerId ==
                                  GlobalVariables.user!.profileId) {
                            GoRouter.of(context).push(
                              Routes.moderatorMatchCenter,
                              extra: [
                                m,
                                state.tournamentEntity!,
                                (
                                  context,
                                  matchId,
                                  scorer,
                                  venueId,
                                  date,
                                  time,
                                ) => cubit.updateMatchUsecase(
                                  context,
                                  matchId,
                                  scorer,
                                  venueId,
                                  date,
                                  time,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  // --- Playoff Matches Divider ---
                  if (playoffMatches.isNotEmpty) _buildDivider("PLAYOFFS"),

                  // --- Playoff Matches ---
                  ...playoffMatches.map(
                    (m) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child:
                          m.scorer['profileId'] != null &&
                              (m.scorer['profileId'] as String).isNotEmpty
                          ? MatchTile(matchEntity: m)
                          : MatchTile(
                              matchEntity: m,
                              dateSet: false,
                              onTap: () {
                                if (state.tournamentEntity!.moderators
                                        .map((e) => e.playerId)
                                        .contains(
                                          GlobalVariables.user!.profileId,
                                        ) ||
                                    state.tournamentEntity!.organizerId ==
                                        GlobalVariables.user!.profileId) {
                                  GoRouter.of(context).push(
                                    Routes.moderatorMatchCenter,
                                    extra: [
                                      m,
                                      state.tournamentEntity!,
                                      (
                                        context,
                                        matchId,
                                        scorer,
                                        venueId,
                                        date,
                                        time,
                                      ) => cubit.updateMatchUsecase(
                                        context,
                                        matchId,
                                        scorer,
                                        venueId,
                                        date,
                                        time,
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Group scheduled matches date-wise
  List<Widget> _buildScheduledMatchesByDate(
    BuildContext context,
    List<MatchEntity> matches,
  ) {
    final Map<String, List<MatchEntity>> groupedByDate = {};

    for (var match in matches) {
      final dateKey = DateFormat('dd MMM yyyy').format(match.dateAndTime);
      groupedByDate.putIfAbsent(dateKey, () => []).add(match);
    }

    final sortedDates = groupedByDate.keys.toList()
      ..sort((a, b) {
        final da = DateFormat('dd MMM yyyy').parse(a);
        final db = DateFormat('dd MMM yyyy').parse(b);
        return da.compareTo(db);
      });

    return [
      for (final date in sortedDates) ...[
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 4),
          child: Text(
            date.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
        ...groupedByDate[date]!.map(
          (m) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: MatchTile(matchEntity: m),
          ),
        ),
      ],
    ];
  }

  Widget _buildDivider(String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyles.poppinsSemiBold.copyWith(
            color: ColorsConstants.defaultBlack,
            fontSize: 12,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

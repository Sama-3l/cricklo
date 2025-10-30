import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:cricklo/features/follow/domain/entities/following_match_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_player_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_team_entity.dart';
import 'package:cricklo/features/follow/presentation/blocs/cubits/FollowingPageCubit/following_page_cubit.dart';
import 'package:cricklo/features/home/presentation/widgets/shimmer_match_tile.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/presentation/widgets/shimmer_tournament_tile.dart';
import 'package:cricklo/features/tournament/presentation/widgets/tournament_tile.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class FollowingPage extends StatefulWidget {
  final String profileId;

  const FollowingPage({super.key, required this.profileId});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ["Players", "Teams", "Matches", "Tournaments"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<FollowingPageCubit>()..init(context, widget.profileId),
      child: Scaffold(
        backgroundColor: ColorsConstants.defaultWhite,
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorsConstants.defaultWhite),
          backgroundColor: ColorsConstants.accentOrange,
          title: Text(
            "Following",
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 24,
              letterSpacing: -1.2,
              color: ColorsConstants.defaultWhite,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<FollowingPageCubit, FollowingPageState>(
          builder: (context, state) {
            final cubit = context.read<FollowingPageCubit>();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ).copyWith(top: 24, bottom: 16),
                  child: StatsTableFilterTabBar(
                    selectedTab: _tabController.index,
                    selectTab: (index) {
                      _tabController.animateTo(index);
                      cubit.updateState();
                    },
                    options: ["Players", "Teams", "Matches", "Tournaments"],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _LazyTab(
                        child: _buildPlayers(state.players, state.loading),
                      ),
                      _LazyTab(child: _buildTeams(state.teams, state.loading)),
                      _LazyTab(
                        child: _buildMatches(state.matches, state.loading),
                      ),
                      _LazyTab(
                        child: _buildTournaments(
                          state.tournaments,
                          state.loading,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayers(List<FollowingPlayerEntity> players, bool loading) {
    if (loading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24),
        child: ListView.builder(
          itemCount: 10,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Shimmer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  // Profile circle shimmer
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.2,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Name + ID shimmer
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 14,
                          decoration: BoxDecoration(
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 80,
                          height: 10,
                          decoration: BoxDecoration(
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Invite status shimmer
                  Container(
                    width: 50,
                    height: 12,
                    decoration: BoxDecoration(
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (players.isEmpty) {
      return Center(
        child: Text(
          "Not following any players",
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 16,
            letterSpacing: -0.8,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final p = players[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 32,
            backgroundColor: ColorsConstants.surfaceOrange,
            backgroundImage: CachedNetworkImageProvider(p.profileId),
          ),
          title: Text(
            p.name,
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 16,
              letterSpacing: -0.8,
            ),
          ),
          subtitle: Text(
            p.playerType?.name ?? '',
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 12,
              letterSpacing: -0.5,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTeams(List<FollowingTeamEntity> teams, bool loading) {
    if (loading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24),
        child: ListView.builder(
          itemCount: 10,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Shimmer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  // Profile circle shimmer
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.2,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Name + ID shimmer
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 14,
                          decoration: BoxDecoration(
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 80,
                          height: 10,
                          decoration: BoxDecoration(
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Invite status shimmer
                  Container(
                    width: 50,
                    height: 12,
                    decoration: BoxDecoration(
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (teams.isEmpty) {
      return Center(
        child: Text(
          "Not following any teams",
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 16,
            letterSpacing: -0.8,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final t = teams[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 32,
            backgroundColor: ColorsConstants.surfaceOrange,
            backgroundImage: CachedNetworkImageProvider(t.teamLogo),
          ),
          title: Text(
            t.teamName,
            style: TextStyles.poppinsSemiBold.copyWith(
              fontSize: 16,
              letterSpacing: -0.8,
            ),
          ),
          subtitle: Text(
            "${t.location.city}, ${t.location.state}",
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 12,
              letterSpacing: -0.5,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMatches(List<FollowingMatchEntity> matches, bool loading) {
    if (loading) {
      return ListView.builder(
        itemBuilder: (context, index) => ShimmerMatchTile(),
      );
    }
    if (matches.isEmpty) {
      return Center(
        child: Text(
          "Not following any matches",
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 16,
            letterSpacing: -0.8,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final m = matches[index];
        return ListTile(
          title: Text(m.matchName),
          subtitle: Text("Match ID: ${m.matchId}"),
          trailing: Text(
            DateFormat('dd MMM').format(m.followedAt),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        );
      },
    );
  }

  Widget _buildTournaments(List<TournamentEntity> tournaments, bool loading) {
    if (loading) {
      return ListView.builder(
        itemBuilder: (context, index) => ShimmerTournamentTile(),
      );
    }
    if (tournaments.isEmpty) {
      return Center(
        child: Text(
          "Not following any tournaments",
          style: TextStyles.poppinsSemiBold.copyWith(
            fontSize: 16,
            letterSpacing: -0.8,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: tournaments.length,
        itemBuilder: (context, index) {
          final t = tournaments[index];
          return SizedBox(
            height: 300,
            child: TournamentTile(tournamentEntity: t),
          );
        },
      ),
    );
  }
}

class _LazyTab extends StatefulWidget {
  final Widget child;
  const _LazyTab({required this.child});

  @override
  State<_LazyTab> createState() => _LazyTabState();
}

class _LazyTabState extends State<_LazyTab> with AutomaticKeepAliveClientMixin {
  bool _isBuilt = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!_isBuilt) {
      Future.microtask(() => setState(() => _isBuilt = true));
      return const Center(child: CircularProgressIndicator());
    }
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

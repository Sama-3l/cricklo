import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:cricklo/features/follow/domain/entities/following_match_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_player_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_team_entity.dart';
import 'package:cricklo/features/follow/domain/entities/following_tournament_entity.dart';
import 'package:cricklo/features/follow/presentation/blocs/cubits/FollowingPageCubit/following_page_cubit.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
                      _LazyTab(child: _buildPlayers(state.players)),
                      _LazyTab(child: _buildTeams(state.teams)),
                      _LazyTab(child: _buildMatches(state.matches)),
                      _LazyTab(child: _buildTournaments(state.tournaments)),
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

  Widget _buildPlayers(List<FollowingPlayerEntity> players) {
    if (players.isEmpty) {
      return const Center(child: Text("Not following any players"));
    }
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final p = players[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: p.profilePicture != null
                ? NetworkImage(p.profilePicture!)
                : null,
            child: p.profilePicture == null ? const Icon(Icons.person) : null,
          ),
          title: Text(p.name),
          subtitle: Text(p.playerType?.name ?? ''),
        );
      },
    );
  }

  Widget _buildTeams(List<FollowingTeamEntity> teams) {
    if (teams.isEmpty) {
      return const Center(child: Text("Not following any teams"));
    }
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final t = teams[index];
        return ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(t.teamLogo)),
          title: Text(t.teamName),
          subtitle: Text("${t.location.city}, ${t.location.state}"),
        );
      },
    );
  }

  Widget _buildMatches(List<FollowingMatchEntity> matches) {
    if (matches.isEmpty) {
      return const Center(child: Text("Not following any matches"));
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

  Widget _buildTournaments(List<FollowingTournamentEntity> tournaments) {
    if (tournaments.isEmpty) {
      return const Center(child: Text("Not following any tournaments"));
    }
    return ListView.builder(
      itemCount: tournaments.length,
      itemBuilder: (context, index) {
        final t = tournaments[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              t.banner,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(t.tournamentName),
          subtitle: Text(
            "${t.format} • ${t.tournamentType} • "
            "${DateFormat('dd MMM').format(t.startDate)} - "
            "${DateFormat('dd MMM').format(t.endDate)}",
          ),
        );
      },
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

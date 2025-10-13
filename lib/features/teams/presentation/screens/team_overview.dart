import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/methods.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/account/presentation/widgets/profile_header_information.dart';
import 'package:cricklo/features/account/presentation/widgets/stats_table_filter_tab_bar.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/TeamPageCubit/team_page_cubit.dart';
import 'package:cricklo/features/teams/presentation/widgets/recent_matches_winloss.dart';
import 'package:cricklo/features/teams/presentation/widgets/scheduled_matches_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamOverview extends StatefulWidget {
  const TeamOverview({super.key, required this.team, required this.matches});

  final TeamEntity team;
  final List<MatchEntity> matches;

  @override
  State<TeamOverview> createState() => _TeamOverviewState();
}

class _TeamOverviewState extends State<TeamOverview> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    final state = context.read<TeamPageCubit>().state;
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: ListView(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () => {},
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorsConstants.accentOrange.withValues(alpha: 0.2),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.team.teamBanner),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ).copyWith(top: 16),
                child: ProfileHeaderInformation(team: widget.team),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        disabled: false,
                        onPress: () {},
                        noShadow: true,
                        radius: 16,
                        child: Text(
                          "Follow Team",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 10,
                            letterSpacing: -0.5,
                            color: ColorsConstants.defaultWhite,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: PrimaryButton(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        color: ColorsConstants.urlBlue,
                        disabled: false,
                        onPress: () {},
                        noShadow: true,
                        radius: 16,
                        child: Text(
                          "Share Team Profile",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 10,
                            letterSpacing: -0.5,
                            color: ColorsConstants.defaultWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SectionHeader(title: "Win Loss Ratio", showIcon: false),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
            ),
            child: Column(
              children: [
                // Toggle
                StatsTableFilterTabBar(
                  options: ["Both", "Bat First", "Bowl First"],
                  selectTab: (index) => setState(() {
                    selectedTab = index;
                  }),
                  selectedTab: selectedTab,
                ),
                const SizedBox(height: 12),
                RecentMatchesWinloss(win: 0.5, loss: 0.5),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "0",
                          style: TextStyles.poppinsBold.copyWith(
                            fontSize: 16,
                            letterSpacing: -0.8,
                            color: ColorsConstants.defaultBlack,
                          ),
                        ),
                        Text(
                          "Matches",
                          style: TextStyles.poppinsMedium.copyWith(
                            fontSize: 12,
                            letterSpacing: -0.5,
                            color: ColorsConstants.defaultBlack,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: TextStyles.poppinsBold.copyWith(
                            fontSize: 16,
                            letterSpacing: -0.8,
                            color: ColorsConstants.defaultBlack,
                          ),
                        ),
                        Text(
                          "Won",
                          style: TextStyles.poppinsMedium.copyWith(
                            fontSize: 12,
                            letterSpacing: -0.5,
                            color: ColorsConstants.defaultBlack,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "0",
                          style: TextStyles.poppinsBold.copyWith(
                            fontSize: 16,
                            letterSpacing: -0.8,
                            color: ColorsConstants.defaultBlack,
                          ),
                        ),
                        Text(
                          "Lost",
                          style: TextStyles.poppinsMedium.copyWith(
                            fontSize: 12,
                            letterSpacing: -0.5,
                            color: ColorsConstants.defaultBlack,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1.5,
                      color: ColorsConstants.accentOrange,
                    ),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: ColorsConstants.accentOrange,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (state.team != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SectionHeader(title: "Top Performers", showIcon: false),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
              ),
              child: Column(
                children: state.team!.players
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                    e.name,
                                    style: TextStyles.poppinsSemiBold.copyWith(
                                      fontSize: 16,
                                      letterSpacing: -0.5,
                                      color: ColorsConstants.defaultBlack,
                                    ),
                                  ),
                                  Text(
                                    Methods.getPlayerTypePlayerEntity(e),
                                    maxLines: 2,
                                    style: TextStyles.poppinsSemiBold.copyWith(
                                      fontSize: 12,
                                      letterSpacing: -0.6,

                                      color: ColorsConstants.defaultBlack
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "16 pts",
                              style: TextStyles.poppinsSemiBold.copyWith(
                                fontSize: 14,
                                letterSpacing: -0.6,
                                color: ColorsConstants.defaultBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SectionHeader(title: "Scheduled Matches", showIcon: false),
          ),
          const SizedBox(height: 16),
          ...widget.matches
              .where(
                (e) =>
                    e.dateAndTime.isAfter(DateTime.now()) &&
                    e.tossWinner == null,
              )
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4,
                  ),
                  child: ScheduledMatchesItem(match: e),
                ),
              ),
        ],
      ),
    );
  }
}

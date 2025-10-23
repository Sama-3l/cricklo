import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
import 'package:cricklo/features/scorer/presentation/screens/commentary_screen.dart';
import 'package:cricklo/features/scorer/presentation/screens/scorecard_info_tab.dart';
import 'package:cricklo/features/scorer/presentation/screens/scorecard_tab.dart';
import 'package:cricklo/features/scorer/presentation/screens/scorer_summary_tab.dart';
import 'package:cricklo/features/scorer/presentation/screens/wagon_wheel_screen.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScorerMatchCenter extends StatelessWidget {
  const ScorerMatchCenter({
    super.key,
    required this.match,
    required this.spectator,
  });

  final MatchEntity match;
  final bool spectator;

  final List<String> _tabs = const [
    "Summary",
    "Scorecard",
    "Wagon Wheel",
    "Live",
    "Info",
  ];

  Widget _buildTabContent(int index, ScorerMatchCenterState state) {
    switch (index) {
      case 0:
        return const ScorerSummaryTab();
      case 1:
        return const ScorecardScreen();
      case 2:
        return const WagonWheelScreen();
      case 3:
        return CommentaryScreen(matchCenterEntity: state.matchCenterEntity);
      case 4:
        return MatchInfoPage(match: state.matchEntity);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<ScorerMatchCenterCubit>()..init(context, match, spectator),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ScorerMatchCenterCubit>();
          return DefaultTabController(
            length: _tabs.length,
            child: BlocBuilder<ScorerMatchCenterCubit, ScorerMatchCenterState>(
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: ColorsConstants.defaultWhite,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: ColorsConstants.defaultWhite,
                    ),
                    leading: IconButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      icon: Icon(CupertinoIcons.back, size: 24),
                    ),
                    backgroundColor: ColorsConstants.accentOrange,
                    title: Text(
                      "Scorer Match Center",
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 24,
                        letterSpacing: -1.2,
                        color: ColorsConstants.defaultWhite,
                      ),
                    ),
                    centerTitle: true,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(48),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          padding: EdgeInsets.zero,
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          indicatorColor: ColorsConstants.defaultWhite,
                          labelColor: ColorsConstants.defaultWhite,
                          unselectedLabelColor: ColorsConstants.defaultWhite
                              .withValues(alpha: 0.5),
                          labelStyle: TextStyles.poppinsBold.copyWith(
                            fontSize: 12,
                            letterSpacing: -0.5,
                          ),
                          unselectedLabelStyle: TextStyles.poppinsMedium
                              .copyWith(fontSize: 12, letterSpacing: -0.5),
                          indicatorWeight: 2.5,

                          onTap: cubit.changeTab,
                          tabs: _tabs.map((t) => Tab(text: t)).toList(),
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: List.generate(
                      _tabs.length,
                      (index) => _buildTabContent(index, state),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/features/scorer/presentation/blocs/cubits/ScorerMatchCenter/scorer_match_center_cubit.dart';
import 'package:cricklo/features/scorer/presentation/screens/scorer_summary_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScorerMatchCenter extends StatelessWidget {
  const ScorerMatchCenter({super.key, required this.match});

  final MatchEntity match;

  final List<String> _tabs = const [
    "Summary",
    "Scorecard",
    "Wagon Wheel",
    "Commentary",
    "Info",
  ];

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return const ScorerSummaryTab();
      case 1:
        return const ScorecardTab();
      case 2:
        return const WagonWheelTab();
      case 3:
        return const CommentaryTab();
      case 4:
        return const InfoTab();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScorerMatchCenterCubit(),
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
                          tabAlignment: TabAlignment
                              .start, // 👈 ensures tabs start at left
                          padding: EdgeInsets.zero, // 👈 removes outer padding
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ), // 👈 custom spacing between tabs
                          indicatorColor: ColorsConstants.accentOrange,
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
                      (index) => _buildLazyTab(
                        context,
                        cubit: cubit,
                        index: index,
                        child: _buildTabContent(index),
                      ),
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

  Widget _buildLazyTab(
    BuildContext context, {
    required ScorerMatchCenterCubit cubit,
    required int index,
    required Widget child,
  }) {
    final state = context.watch<ScorerMatchCenterCubit>().state;
    final isLoaded = state.loadedTabs.contains(index);

    if (!isLoaded && index == state.currentIndex) {
      cubit.changeTab(index);
    }

    return isLoaded ? child : const Center(child: CircularProgressIndicator());
  }
}

class SummaryTab extends StatelessWidget {
  const SummaryTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Summary"));
}

class ScorecardTab extends StatelessWidget {
  const ScorecardTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Scorecard"));
}

class WagonWheelTab extends StatelessWidget {
  const WagonWheelTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Wagon Wheel"));
}

class CommentaryTab extends StatelessWidget {
  const CommentaryTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Commentary"));
}

class InfoTab extends StatelessWidget {
  const InfoTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Info"));
}

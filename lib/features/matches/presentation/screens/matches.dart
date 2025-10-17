import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/features/matches/presentation/screens/match_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<MainAppCubit>().state;
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      body: RefreshIndicator(
        color: ColorsConstants.accentOrange,
        onRefresh: () async {
          // Trigger Cubit method when user pulls down
          await context.read<MainAppCubit>().getUserMatches();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SectionHeader(title: "Your Matches"),
                ),
                const SizedBox(height: 12),
                state.matches.where((e) => e.teamA.inviteStatus != null).isEmpty
                    ? Container(
                        height: 200,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorsConstants.defaultBlack.withValues(
                            alpha: 0.07,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "No Matches Yet",
                            style: TextStyles.poppinsRegular.copyWith(
                              fontSize: 16,
                              letterSpacing: -0.8,
                              color: ColorsConstants.defaultBlack.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ),
                      )
                    : MatchList(),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SectionHeader(title: "From Your Circle"),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
                  ),
                  child: Center(
                    child: Text(
                      "No Matches Yet",
                      style: TextStyles.poppinsRegular.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SectionHeader(title: "Explore"),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
                  ),
                  child: Center(
                    child: Text(
                      "No Matches Yet",
                      style: TextStyles.poppinsRegular.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

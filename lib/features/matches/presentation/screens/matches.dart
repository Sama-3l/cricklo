import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/matches/presentation/screens/match_list.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // === Padding Wrapper ===
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 24),

              // === Your Matches Section ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SectionHeader(title: "Your Matches"),
              ),
              const SizedBox(height: 12),
              MatchList(),

              const SizedBox(height: 24),

              // === From Your Circle Section ===
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

              // === Explore Section ===
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
    );
  }
}

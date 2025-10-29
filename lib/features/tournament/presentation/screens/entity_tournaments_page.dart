import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/presentation/widgets/tournament_tile.dart';
import 'package:flutter/material.dart';

class EntityTournamentsPage extends StatelessWidget {
  const EntityTournamentsPage({
    super.key,
    required this.tournaments,
    this.loading = false,
    this.title = "Your Tournaments",
  });

  final List<TournamentEntity> tournaments;
  final bool loading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.onSurfaceGrey,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ).copyWith(top: 24),
            child: SectionHeader(title: title, showIcon: false),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: tournaments.isEmpty
                ? Center(
                    child: Text(
                      "No Tournaments Yet",
                      style: TextStyles.poppinsRegular.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: tournaments.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0)
                            .copyWith(
                              bottom: index == tournaments.length - 1 ? 24 : 0,
                            ),
                        child: SizedBox(
                          height: 300,
                          child: TournamentTile(
                            tournamentEntity: tournaments[index],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

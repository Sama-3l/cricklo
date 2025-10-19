import 'package:cricklo/core/utils/constants/global_variables.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile_header.dart';
import 'package:cricklo/features/matches/domain/entities/match_entity.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchTile extends StatelessWidget {
  final MatchEntity matchEntity;
  final bool live;
  final Function()? onTap;

  const MatchTile({
    super.key,
    required this.matchEntity,
    this.live = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          if (GlobalVariables.user!.profileId ==
              matchEntity.scorer["profileId"]) {
            GoRouter.of(
              context,
            ).pushNamed(Routes.scorerInitialPage, extra: matchEntity);
          } else {
            GoRouter.of(
              context,
            ).pushNamed(Routes.scorerMatchCenter, extra: [matchEntity, true]);
          }
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // color: ColorsConstants.defaultBlack.withValues(alpha: 0.07),
          color: ColorsConstants.defaultWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Top row: Team images + VS + LIVE
              MatchTileHeader(matchEntity: matchEntity),
              const SizedBox(height: 16),

              Column(
                children: [
                  WidgetDecider.buildTeamRow(
                    matchEntity.teamA,
                    matchEntity.teamAScore,
                    matchEntity,
                  ),
                  const SizedBox(height: 12),
                  WidgetDecider.buildTeamRow(
                    matchEntity.teamB,
                    matchEntity.teamBScore,
                    matchEntity,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${matchEntity.location.location!}, ${matchEntity.location.area}, ${matchEntity.location.city}, ${matchEntity.location.state}",
                    style: TextStyles.poppinsSemiBold.copyWith(
                      fontSize: 10,
                      letterSpacing: -0.2,
                      color: ColorsConstants.defaultBlack.withValues(
                        alpha: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

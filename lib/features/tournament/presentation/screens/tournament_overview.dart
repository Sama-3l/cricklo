import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:cricklo/features/tournament/presentation/widgets/shimmer_team_item.dart';
import 'package:cricklo/features/tournament/presentation/widgets/team_item.dart';
import 'package:cricklo/features/tournament/presentation/widgets/tournament_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TournamentOverview extends StatelessWidget {
  const TournamentOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TournamentCubit>();
    final state = context.read<TournamentCubit>().state;
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: ListView(
        children: [
          InkWell(
            onTap: () => {},
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsConstants.surfaceOrange,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    state.tournamentEntity!.banner,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          TournamentDetailsHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        color: ColorsConstants.scorerCenter,
                        disabled: false,
                        onPress: () {},
                        noShadow: true,
                        radius: 16,
                        child: Text(
                          "Share Tournament",
                          style: TextStyles.poppinsSemiBold.copyWith(
                            fontSize: 10,
                            letterSpacing: -0.5,
                            color: ColorsConstants.defaultBlack,
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
                          "Follow Tournament",
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
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    disabled: false,
                    onPress: () => cubit.applyTournament(context),
                    noShadow: true,
                    radius: 16,
                    color: state.applied
                        ? ColorsConstants.defaultBlack
                        : ColorsConstants.accentOrange,
                    child: state.applied
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Applied",
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  fontSize: 10,
                                  letterSpacing: -0.5,
                                  color: ColorsConstants.defaultWhite,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.check_circle_outline_rounded,
                                color: ColorsConstants.defaultWhite,
                                size: 12,
                              ),
                            ],
                          )
                        : Text(
                            "Apply",
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Divider(color: ColorsConstants.onSurfaceGrey, thickness: 2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ).copyWith(bottom: 16),
            child: SectionHeader(title: "Teams", showIcon: false),
          ),
          SizedBox(
            height: 120,
            child: state.loading
                ? ListView.separated(
                    itemCount: 10,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 40),
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 16.0 : 0,
                        right: index == 9 ? 16.0 : 0,
                      ),
                      child: ShimmerOverviewItem(title: ""),
                    ),
                  )
                : state.tournamentEntity!.teams.isEmpty
                ? Center(
                    child: Text(
                      "No Teams Yet",
                      style: TextStyles.poppinsMedium.copyWith(
                        fontSize: 16,
                        letterSpacing: -0.8,
                        color: ColorsConstants.defaultBlack,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: state.tournamentEntity!.teams.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 40),
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 16.0 : 0,
                        right: index == 9 ? 16.0 : 0,
                      ),
                      child: OverviewItem(title: 'Aviral All Stars'),
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Divider(color: ColorsConstants.onSurfaceGrey, thickness: 2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ).copyWith(bottom: 16),
            child: SectionHeader(title: "Top Players", showIcon: false),
          ),
          SizedBox(
            height: 156,
            child: ListView.separated(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 40),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 16.0 : 0,
                  right: index == 9 ? 16.0 : 0,
                ),
                child: OverviewItem(
                  topTitle: "Most Runs",
                  title: 'Aryan Vaish',
                  subtitle: 'Aviral All Stars',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Divider(color: ColorsConstants.onSurfaceGrey, thickness: 2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ).copyWith(bottom: 16),
            child: SectionHeader(
              title: "Tournament Boundaries",
              showIcon: false,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "SIXES",
                    style: TextStyles.poppinsLight.copyWith(
                      fontSize: 16,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  Text(
                    "72",
                    style: TextStyles.poppinsBold.copyWith(
                      fontSize: 32,
                      letterSpacing: -1.6,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "FOURS",
                    style: TextStyles.poppinsLight.copyWith(
                      fontSize: 16,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  Text(
                    "126",
                    style: TextStyles.poppinsBold.copyWith(
                      fontSize: 32,
                      letterSpacing: -1.6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

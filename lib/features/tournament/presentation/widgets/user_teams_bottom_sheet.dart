import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/FetchUserTeamsCubit/fetch_user_teams_cubit.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserTeamsBottomSheet extends StatelessWidget {
  const UserTeamsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Scaffold(
          backgroundColor: ColorsConstants.defaultWhite,
          body: BlocProvider(
            create: (context) => sl<FetchUserTeamsCubit>()..init(),
            child: BlocBuilder<FetchUserTeamsCubit, FetchUserTeamsState>(
              builder: (context, state) {
                if (state.loading) {
                  return Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: ColorsConstants.accentOrange,
                      ),
                    ),
                  );
                }
                if (state.teams.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data Yet",
                      style: TextStyles.poppinsSemiBold.copyWith(
                        fontSize: 24,
                        letterSpacing: -1.2,
                        color: ColorsConstants.accentOrange,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: ColorsConstants.onSurfaceGrey.withValues(
                              alpha: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Select a Team',
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      const SizedBox(height: 24),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.9,
                            ),
                        itemCount: state.teams.length,
                        itemBuilder: (context, index) {
                          final team = state.teams[index];
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pop(team.id);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: ColorsConstants.accentOrange
                                      .withValues(alpha: 0.2),
                                  backgroundImage: team.teamLogo.isNotEmpty
                                      ? CachedNetworkImageProvider(
                                          team.teamLogo,
                                        )
                                      : null,
                                  child:
                                      (team.logoFile == null &&
                                          team.teamLogo.isEmpty)
                                      ? Icon(
                                          Icons.people,
                                          size: 32,
                                          color: ColorsConstants.defaultBlack,
                                        )
                                      : null,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  team.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyles.poppinsSemiBold.copyWith(
                                    fontSize: 12,
                                    color: ColorsConstants.defaultBlack,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

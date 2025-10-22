import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/tournament/presentation/blocs/cubits/TournamentCubit/tournament_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TournamentOverview extends StatelessWidget {
  const TournamentOverview({super.key});

  @override
  Widget build(BuildContext context) {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ).copyWith(top: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.tournamentEntity!.name,
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.8,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${state.tournamentEntity!.venues[0].city}, ${state.tournamentEntity!.venues[0].state}",
                        style: TextStyles.poppinsMedium.copyWith(
                          fontSize: 14,
                          letterSpacing: -0.5,
                          color: ColorsConstants.defaultBlack.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),

                      InkWell(
                        onTap: () {
                          FlutterClipboard.copy(state.tournamentEntity!.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: ColorsConstants.defaultWhite,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: ColorsConstants.accentOrange,
                                  width: 1,
                                ),
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                              content: Center(
                                child: Text(
                                  "Tournament ID copied to Clipboard",
                                  style: TextStyles.poppinsSemiBold.copyWith(
                                    fontSize: 12,
                                    color: ColorsConstants.accentOrange,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ColorsConstants.surfaceOrange,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.copy,
                                size: 10,
                                color: ColorsConstants.defaultBlack,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Tournament ID: ",
                                style: TextStyles.poppinsRegular.copyWith(
                                  fontSize: 10,
                                  letterSpacing: -0.2,
                                  color: ColorsConstants.defaultBlack,
                                ),
                              ),
                              Text(
                                state.tournamentEntity!.id,
                                maxLines: 2,
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  fontSize: 10,
                                  letterSpacing: -0.2,
                                  color: ColorsConstants.defaultBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      width: 1,
                      color: ColorsConstants.defaultBlack,
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(top: 16, right: 16),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "20",
                          style: TextStyles.poppinsBold.copyWith(
                            color: ColorsConstants.defaultBlack,
                            fontSize: 12,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "followers",
                          style: TextStyles.poppinsBold.copyWith(
                            color: ColorsConstants.defaultBlack,
                            fontSize: 12,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                      "Follow Tournament",
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
                      "Share Tournament",
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
        ],
      ),
    );
  }
}

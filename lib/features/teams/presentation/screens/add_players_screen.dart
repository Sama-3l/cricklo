import 'package:cricklo/core/utils/common/primary_button.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/presentation/blocs/cubits/AddPlayersCubit/add_players_cubit.dart';
import 'package:cricklo/features/teams/presentation/widgets/search_players_bottom_sheet.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddPlayersScreen extends StatefulWidget {
  const AddPlayersScreen({super.key, required this.team});

  final TeamEntity team;

  @override
  State<AddPlayersScreen> createState() => _AddPlayersScreenState();
}

class _AddPlayersScreenState extends State<AddPlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddPlayersCubit>()..init(widget.team.players),
      child: BlocBuilder<AddPlayersCubit, AddPlayersState>(
        builder: (context, state) {
          final cubit = context.read<AddPlayersCubit>();
          return Scaffold(
            backgroundColor: ColorsConstants.defaultWhite,
            appBar: AppBar(
              backgroundColor: ColorsConstants.accentOrange,
              leading: IconButton(
                onPressed: () => GoRouter.of(context).pop(),
                icon: Icon(
                  Icons.chevron_left,
                  color: ColorsConstants.defaultWhite,
                ),
                iconSize: 32,
              ),
              title: Text(
                "Add Players",
                style: TextStyles.poppinsMedium.copyWith(
                  fontSize: 24,
                  letterSpacing: -1.2,
                  color: ColorsConstants.defaultWhite,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(top: 12),
              color: ColorsConstants.defaultWhite,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      noShadow: true,
                      disabled: false,
                      color: ColorsConstants.accentOrange.withValues(
                        alpha: 0.2,
                      ),
                      child: Text(
                        "Find Players",
                        style: TextStyles.poppinsSemiBold.copyWith(
                          fontSize: 16,
                          letterSpacing: -0.6,
                          color: ColorsConstants.defaultBlack,
                        ),
                      ),
                      onPress: () async {
                        final players =
                            await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => SearchPlayersBottomSheet(
                                    initiallySelected: state
                                        .players, // ✅ pass already added players
                                  ),
                                )
                                as List<SearchUserEntity>?;
                        if (players != null) {
                          cubit.playersAdded(players);
                        }
                      },
                    ),
                  ),
                  if (state.players.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: PrimaryButton(
                        disabled: false,
                        child: state.loading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: ColorsConstants.defaultWhite,
                                ),
                              )
                            : Text(
                                "Done",
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  fontSize: 16,
                                  letterSpacing: -0.6,
                                  color: ColorsConstants.defaultWhite,
                                ),
                              ),
                        onPress: () async {
                          await cubit.sendInvites(widget.team);
                          while (GoRouter.of(context).canPop()) {
                            GoRouter.of(context).pop(widget.team);
                          }
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: WidgetDecider.buildPlayerList(
                  state.players.map((e) => e.toPlayerEntity()).toList(),
                  onDismiss: (playerId) => cubit.removePlayer(playerId),
                  showInvited: true,
                  dismissable: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

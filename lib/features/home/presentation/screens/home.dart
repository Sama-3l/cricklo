import 'dart:ui';
import 'package:cricklo/core/utils/constants/dummy_data.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/core/utils/constants/widget_decider.dart';
import 'package:cricklo/features/home/presentation/widgets/home_profile_header.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:cricklo/features/matches/presentation/screens/match_list.dart';
import 'package:cricklo/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.userEntity});

  final UserEntity? userEntity;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool showOptions = false;
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  // final matches = [];
  final tournaments = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rotation = Tween<double>(
      begin: 0,
      end: 0.125,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleShowOptions() {
    setState(() {
      showOptions = !showOptions;
    });
    if (showOptions) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainAppCubit>();
    final state = cubit.state;
    return Scaffold(
      backgroundColor: ColorsConstants.defaultWhite,
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await cubit.getUserMatches();
            },
            color: ColorsConstants.accentOrange,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SectionHeader(title: "Matches"),
                ),
                state.matches.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 200,
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.all(16),
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
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: MatchList(),
                      ),
                if (widget.userEntity != null) ...[
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: HomeProfileHeader(userEntity: widget.userEntity),
                  ),
                ],
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SectionHeader(title: "Live Tournaments"),
                ),
                tournaments.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 200,
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorsConstants.defaultBlack.withValues(
                              alpha: 0.07,
                            ),
                          ),
                          child: Center(
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
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorsConstants.defaultBlack.withValues(
                            alpha: 0.07,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/images/tournament_Dummy_Image.png",
                          ),
                        ),
                      ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          if (showOptions)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  toggleShowOptions();
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ),

          Positioned(
            bottom: 24,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (showOptions) ...[
                  WidgetDecider.buildOptionButton(
                    "Create Team",
                    () async {
                      toggleShowOptions();
                      if (widget.userEntity != null) {
                        final done = await GoRouter.of(context).pushNamed(
                          Routes.createTeam,
                          extra: widget.userEntity,
                        );
                        if (done != null) {
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
                                  "Invites sent to all players",
                                  style: TextStyles.poppinsSemiBold.copyWith(
                                    fontSize: 12,
                                    color: ColorsConstants.accentOrange,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        GoRouter.of(context).goNamed(Routes.loginPage);
                      }
                    },
                    _slide,
                    _opacity,
                  ),
                  WidgetDecider.buildOptionButton(
                    "Create Match",
                    () async {
                      toggleShowOptions();
                      final done = await GoRouter.of(context).pushNamed(
                        Routes.createMatch,
                        extra: (match) =>
                            context.read<MainAppCubit>().addMatch(match),
                      );
                      if (done != null) {
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
                                "Invites sent to all players",
                                style: TextStyles.poppinsSemiBold.copyWith(
                                  fontSize: 12,
                                  color: ColorsConstants.accentOrange,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    _slide,
                    _opacity,
                  ),

                  WidgetDecider.buildOptionButton(
                    "Create Tournament",
                    () {},
                    _slide,
                    _opacity,
                  ),
                  const SizedBox(height: 12),
                ],

                FloatingActionButton(
                  backgroundColor: ColorsConstants.accentOrange,
                  onPressed: () => toggleShowOptions(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(40),
                  ),
                  child: AnimatedBuilder(
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotation.value * 2 * 3.141592,
                        child: Icon(
                          Icons.add,
                          color: ColorsConstants.defaultWhite,
                        ),
                      );
                    },
                    animation: _rotation,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:cricklo/features/home/presentation/widgets/match_tile.dart';
import 'package:cricklo/features/home/presentation/widgets/section_header.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/mainapp/presentation/blocs/cubits/MainAppCubit/main_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserMatches extends StatefulWidget {
  const UserMatches({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  State<UserMatches> createState() => _UserMatchesState();
}

class _UserMatchesState extends State<UserMatches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.onSurfaceGrey,
      body: RefreshIndicator(
        color: ColorsConstants.accentOrange,
        onRefresh: () async {
          // Trigger Cubit method when user pulls down
          await context.read<MainAppCubit>().getUserMatches();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: widget.userEntity.userMatches.isEmpty
              ? Container(
                  height: 200,
                  padding: const EdgeInsets.all(16),
                  // margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(16),
                    // color: ColorsConstants.defaultBlack.withValues(
                    //   alpha: 0.07,
                    // ),
                    color: ColorsConstants.defaultWhite,
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
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 24),
                      child: SectionHeader(
                        title: "Your Matches",
                        showIcon: false,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: widget.userEntity.userMatches.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                index ==
                                    widget.userEntity.userMatches.length - 1
                                ? 24
                                : 0,
                          ),
                          child: MatchTile(
                            matchEntity: widget.userEntity.userMatches[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

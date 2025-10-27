import 'package:cricklo/core/utils/constants/enums.dart';
import 'package:cricklo/features/follow/presentation/blocs/cubits/FollowersPageCubit/followers_page_cubit.dart';
import 'package:cricklo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class FollowersPage extends StatelessWidget {
  final String entityId;
  final EntityType entityType;

  const FollowersPage({
    super.key,
    required this.entityId,
    required this.entityType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<FollowerPageCubit>()..init(context, entityId, entityType),
      child: Scaffold(
        backgroundColor: ColorsConstants.onSurfaceGrey,
        appBar: AppBar(
          backgroundColor: ColorsConstants.accentOrange,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: ColorsConstants.defaultWhite,
                ),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              );
            },
          ),
          title: Text(
            "Followers",
            style: TextStyles.poppinsMedium.copyWith(
              fontSize: 24,
              letterSpacing: -1.2,
              color: ColorsConstants.defaultWhite,
            ),
          ),

          centerTitle: true,
        ),
        body: BlocBuilder<FollowerPageCubit, FollowersPageState>(
          builder: (context, state) {
            if (state.loading) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 10,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, __) => const _FollowerShimmer(),
              );
            }

            if (state.followers.isEmpty) {
              return Center(
                child: Text(
                  "No Followers Yet",
                  style: TextStyles.poppinsRegular.copyWith(
                    fontSize: 16,
                    letterSpacing: -0.5,
                    color: ColorsConstants.defaultBlack.withValues(alpha: 0.5),
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.followers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final follower = state.followers[index];
                return Container(
                  decoration: BoxDecoration(
                    color: ColorsConstants.defaultWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      follower.profilePicture != null
                          ? CircleAvatar(
                              radius: 32,
                              backgroundImage: CachedNetworkImageProvider(
                                follower.profilePicture!,
                              ),
                              backgroundColor: ColorsConstants.surfaceOrange,
                            )
                          : CircleAvatar(
                              radius: 32,
                              backgroundColor: ColorsConstants.surfaceOrange,
                              child: Icon(
                                Icons.people,
                                size: 24,
                                color: ColorsConstants.defaultBlack,
                              ),
                            ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            follower.name,
                            style: TextStyles.poppinsSemiBold.copyWith(
                              fontSize: 16,
                              color: ColorsConstants.defaultBlack,
                              letterSpacing: -0.8,
                            ),
                          ),
                          Text(
                            follower.profileId,
                            style: TextStyles.poppinsRegular.copyWith(
                              fontSize: 12,
                              color: ColorsConstants.defaultBlack.withValues(
                                alpha: 0.5,
                              ),
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _FollowerShimmer extends StatelessWidget {
  const _FollowerShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        decoration: BoxDecoration(
          color: ColorsConstants.defaultWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: ColorsConstants.textBlack.withValues(alpha: 0.2),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 14,
                  decoration: BoxDecoration(
                    color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 80,
                  height: 12,
                  decoration: BoxDecoration(
                    color: ColorsConstants.textBlack.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

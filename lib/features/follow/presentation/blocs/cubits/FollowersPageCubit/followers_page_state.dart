part of 'followers_page_cubit.dart';

@immutable
sealed class FollowersPageState {
  final bool loading;
  final List<FollowerEntity> followers;

  const FollowersPageState({this.loading = false, required this.followers});
}

final class FollowersPageUpdate extends FollowersPageState {
  const FollowersPageUpdate({required super.followers, super.loading});
}

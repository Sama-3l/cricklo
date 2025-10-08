// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';

class SearchPlayersResponseEntity {
  final List<SearchUserEntity> users;
  final int page;
  final int limit;

  SearchPlayersResponseEntity({
    required this.users,
    required this.page,
    required this.limit,
  });
}

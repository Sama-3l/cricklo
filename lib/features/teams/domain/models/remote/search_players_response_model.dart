// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/search_players_response_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_user_model.dart';

class SearchPlayersResponseModel {
  final List<SearchUserModel> users;
  final int page;
  final int limit;

  SearchPlayersResponseModel({
    required this.users,
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'users': users.map((x) => x.toJson()).toList(),
      'page': page,
      'limit': limit,
    };
  }

  factory SearchPlayersResponseModel.fromJson(Map<String, dynamic> json) {
    final map = json['data'];
    return SearchPlayersResponseModel(
      users: List<SearchUserModel>.from(
        (map['players'] as List<dynamic>).map<SearchUserModel>(
          (x) => SearchUserModel.fromJson(x),
        ),
      ),
      page: map['page'] as int,
      limit: map['limit'] as int,
    );
  }

  SearchPlayersResponseEntity toEntity() {
    return SearchPlayersResponseEntity(
      users: users.map((e) => e.toEntity()).toList(),
      page: page,
      limit: limit,
    );
  }
}

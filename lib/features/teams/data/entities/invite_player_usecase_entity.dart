// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';

class InvitePlayerUsecaseEntity {
  final List<SearchUserEntity> players;
  final String teamId;
  InvitePlayerUsecaseEntity({required this.players, required this.teamId});
}

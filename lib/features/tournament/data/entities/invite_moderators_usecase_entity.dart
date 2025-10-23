// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/search_user_entity.dart';

class InviteModeratorsUsecaseEntity {
  final List<SearchUserEntity> users;
  final String tournamentId;

  InviteModeratorsUsecaseEntity({
    required this.users,
    required this.tournamentId,
  });
}

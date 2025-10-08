import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/teams/data/entities/invite_player_usecase_entity.dart';
import 'package:cricklo/features/teams/domain/entities/invite_player_response_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/search_user_model.dart';
import 'package:cricklo/features/teams/domain/repo/team_repo.dart';
import 'package:dartz/dartz.dart';

class InvitePlayerUsecase
    extends UseCase<InvitePlayerResponseEntity, InvitePlayerUsecaseEntity> {
  final TeamRepo _teamRepo;

  InvitePlayerUsecase(this._teamRepo);

  @override
  Future<Either<Failure, InvitePlayerResponseEntity>> call(
    InvitePlayerUsecaseEntity entity,
  ) {
    return _teamRepo.invitePlayers(
      entity.teamId,
      entity.players.map((e) => SearchUserModel.fromEntity(e)).toList(),
    );
  }
}

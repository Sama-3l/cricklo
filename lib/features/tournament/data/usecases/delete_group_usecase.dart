import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:cricklo/features/tournament/data/entities/create_group_usecase_entity.dart';

import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteGroupUsecase
    extends UseCase<InviteResponseResponseEntity, CreateGroupUsecaseEntity> {
  final TournamentRepo _tournamentRepo;

  DeleteGroupUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, InviteResponseResponseEntity>> call(
    CreateGroupUsecaseEntity entity,
  ) {
    return _tournamentRepo.deleteGroup(entity.tournamentId, {
      "groupName": entity.groupName,
    });
  }
}

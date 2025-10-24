import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:cricklo/features/tournament/data/entities/edit_group_usecase_entity.dart';

import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class EditGroupUsecase
    extends UseCase<InviteResponseResponseEntity, EditGroupUsecaseEntity> {
  final TournamentRepo _tournamentRepo;

  EditGroupUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, InviteResponseResponseEntity>> call(
    EditGroupUsecaseEntity entity,
  ) {
    return _tournamentRepo.editGroup(entity.tournamentId, {
      "oldName": entity.oldGroupName,
      "newName": entity.newGroupName,
    });
  }
}

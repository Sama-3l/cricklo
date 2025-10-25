import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/follow/data/entities/follow_usecase_entity.dart';
import 'package:cricklo/features/follow/domain/entities/follow_response_entity.dart';
import 'package:cricklo/features/follow/domain/repo/follow_repo.dart';
import 'package:dartz/dartz.dart';

class FollowUsecase extends UseCase<FollowResponseEntity, FollowUsecaseEntity> {
  final FollowRepo _followRepo;

  FollowUsecase(this._followRepo);

  @override
  Future<Either<Failure, FollowResponseEntity>> call(
    FollowUsecaseEntity entity,
  ) {
    return _followRepo.follow(entity.entityId, {
      "entityType": entity.entityType.title,
    });
  }
}

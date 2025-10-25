import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/follow/data/entities/follow_usecase_entity.dart';
import 'package:cricklo/features/follow/domain/entities/get_followers_entity.dart';
import 'package:cricklo/features/follow/domain/repo/follow_repo.dart';
import 'package:dartz/dartz.dart';

class GetFollowersUsecase
    extends UseCase<GetFollowersEntity, FollowUsecaseEntity> {
  final FollowRepo _followRepo;

  GetFollowersUsecase(this._followRepo);

  @override
  Future<Either<Failure, GetFollowersEntity>> call(FollowUsecaseEntity entity) {
    return _followRepo.getFollowers(entity.entityId, {
      "entityType": entity.entityType.title,
    });
  }
}

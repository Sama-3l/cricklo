import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/follow/domain/entities/get_following_response_entity.dart';
import 'package:cricklo/features/follow/domain/repo/follow_repo.dart';
import 'package:dartz/dartz.dart';

class GetFollowingUsecase extends UseCase<GetFollowingResponseEntity, String> {
  final FollowRepo _followRepo;

  GetFollowingUsecase(this._followRepo);

  @override
  Future<Either<Failure, GetFollowingResponseEntity>> call(String entity) {
    return _followRepo.following(entity);
  }
}

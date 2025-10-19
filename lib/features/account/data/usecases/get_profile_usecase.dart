import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/account/domain/entities/get_profile_response_entity.dart';
import 'package:cricklo/features/mainapp/domain/repo/main_app_repo.dart';
import 'package:dartz/dartz.dart';

class GetProfileUsecase extends UseCase<GetProfileResponseEntity, String> {
  final MainAppRepository _repoImpl;

  GetProfileUsecase(this._repoImpl);

  @override
  Future<Either<Failure, GetProfileResponseEntity>> call(String entity) {
    return _repoImpl.getProfile(entity);
  }
}

import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/login/domain/entities/user_entitiy.dart';
import 'package:cricklo/features/mainapp/domain/repo/main_app_repo.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUserUsecase extends UseCase<UserEntity, NoParams> {
  final MainAppRepository _mainAppRepository;

  GetCurrentUserUsecase(this._mainAppRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams entity) {
    return _mainAppRepository.getCurrentUser();
  }
}

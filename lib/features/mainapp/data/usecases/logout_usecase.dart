import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/mainapp/domain/repo/main_app_repo.dart';
import 'package:cricklo/features/notifications/domain/entities/logout_entity.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase extends UseCase<LogoutEntity, NoParams> {
  final MainAppRepository _mainAppRepository;

  LogoutUsecase(this._mainAppRepository);

  @override
  Future<Either<Failure, LogoutEntity>> call(NoParams entity) {
    return _mainAppRepository.logout();
  }
}

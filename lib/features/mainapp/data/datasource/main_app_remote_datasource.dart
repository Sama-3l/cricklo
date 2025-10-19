import 'package:cricklo/features/account/domain/models/remote/get_profile_response_model.dart';
import 'package:cricklo/features/login/domain/models/remote/user_model.dart';
import 'package:cricklo/features/notifications/domain/models/remote/logout_model_remote.dart';
import 'package:cricklo/services/api_service.dart';

abstract class MainAppRemoteDatasource {
  Future<UserModel> getCurrentUser();
  Future<GetProfileResponseModel> getProfile(String id);
  Future<LogoutModelRemote> logout();
}

class MainAppRemoteDatasourceImpl implements MainAppRemoteDatasource {
  final ApiService apiService;

  MainAppRemoteDatasourceImpl(this.apiService);

  @override
  Future<UserModel> getCurrentUser() {
    return apiService.getCurrentUser();
  }

  @override
  Future<GetProfileResponseModel> getProfile(String id) {
    return apiService.getProfile(id);
  }

  @override
  Future<LogoutModelRemote> logout() {
    return apiService.logout();
  }
}

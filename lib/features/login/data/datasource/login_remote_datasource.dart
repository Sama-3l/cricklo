import 'package:cricklo/features/login/domain/models/remote/login_response_model.dart';
import 'package:cricklo/features/login/domain/models/remote/set_pin_response_model.dart';
import 'package:cricklo/features/login/domain/models/remote/user_model.dart';
import 'package:cricklo/features/notifications/domain/models/remote/logout_model_remote.dart';
import 'package:cricklo/services/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(String number, String countryCode);

  Future<LoginResponseModel> verifyOTP(
    String number,
    String otp,
    String countryCode,
  );

  Future<SetPinResponseModel> setPin(String number, String pin);

  Future<UserModel> onboarding(Map<String, dynamic> body);

  Future<LogoutModelRemote> loginUsingPin(Map<String, dynamic> body);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<LoginResponseModel> login(String number, String countryCode) async {
    return apiService.register({"phone": number, "countryCode": countryCode});
  }

  @override
  Future<LoginResponseModel> verifyOTP(
    String number,
    String otp,
    String countryCode,
  ) async {
    return apiService.verifyOTP(({
      "phone": number,
      "purpose": "register",
      "otp": otp,
    }));
  }

  @override
  Future<SetPinResponseModel> setPin(String number, String pin) async {
    return apiService.setPassword(({
      "phone": number,
      "purpose": "register",
      "password": pin,
    }));
  }

  @override
  Future<UserModel> onboarding(Map<String, dynamic> body) async {
    return apiService.onboarding(body);
  }

  @override
  Future<LogoutModelRemote> loginUsingPin(Map<String, dynamic> body) {
    return apiService.login(body);
  }
}

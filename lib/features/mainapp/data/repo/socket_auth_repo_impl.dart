import 'package:cricklo/features/mainapp/domain/repo/socket_auth_repo.dart';
import 'package:cricklo/services/auth_helper.dart';

class IAuthRepositoryImpl implements IAuthRepository {
  final AuthCookieHelper _cookieHelper;
  IAuthRepositoryImpl(this._cookieHelper);

  @override
  Future<String?> getAuthToken() async {
    return await _cookieHelper.getAuthToken();
  }
}

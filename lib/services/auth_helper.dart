import 'package:cookie_jar/cookie_jar.dart';

class AuthCookieHelper {
  final CookieJar cookieJar;
  final String baseUrl;

  AuthCookieHelper(this.cookieJar, this.baseUrl);

  Future<String?> getAuthToken() async {
    final uri = Uri.parse(baseUrl);
    final cookies = await cookieJar.loadForRequest(uri);

    final authCookie = cookies.firstWhere(
      (cookie) => cookie.name == 'token',
      orElse: () => Cookie('token', ''),
    );

    return authCookie.value.isNotEmpty ? authCookie.value : null;
  }
}

import 'package:sabiwork/services/config.dart';

class APIPath {
  // Auth routes
  static String userSignIn() => '${Config.baseUrl}/auth/login';
  static String userSignUp() => '${Config.baseUrl}/auth/register';
  static String updateAccount() => '${Config.baseUrl}/me';

  static String forgotPassword() => '${Config.baseUrl}/auth/forgot-password';
  static String updatePassword() => '${Config.baseUrl}/auth/change-password';

  static String countries() => '${Config.baseUrl}/countries';
  static String profile() => '${Config.baseUrl}/auth/getMe';
  static String genre() => '${Config.baseUrl}/genres';
  static String categories() => '${Config.baseUrl}/categories';
}

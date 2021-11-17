import 'package:sabiwork/services/config.dart';

class APIPath {
  // Auth routes
  static String userSignIn() => '${Config.baseUrl}/auth/login';
  static String userSignUp() => '${Config.baseUrl}/auth/register';
  static String updateAccount() => '${Config.baseUrl}/user';
  static String states() => '${Config.baseUrl}/metaData/states';
  static String lga(id) => '${Config.baseUrl}/metaData/lga/$id';

  static String forgotPassword() => '${Config.baseUrl}/auth/forgot-password';
  static String updatePassword() => '${Config.baseUrl}/auth/change-password';

  static String countries() => '${Config.baseUrl}/countries';
  static String profile() => '${Config.baseUrl}/auth/getMe';
  static String allJobs() => '${Config.baseUrl}/job';
  static String applyForJob(id) => '${Config.baseUrl}/job/$id';
}

import 'package:sabiwork/services/config.dart';

class APIPath {
  // Auth routes
  static String userSignIn() => '${Config.baseUrl}/auth/login';
  static String userSignUp() => '${Config.baseUrl}/auth/register';
  static String requestPasswordReset() =>
      '${Config.baseUrl}/auth/requestPasswordReset';
  static String updateAccount() => '${Config.baseUrl}/user';
  static String subscribeToFirebase() =>
      '${Config.baseUrl}/auth/subscribeFirebase';
  static String states() => '${Config.baseUrl}/metaData/states';
  static String lga(id) => '${Config.baseUrl}/metaData/lga/$id';

  static String forgotPassword() => '${Config.baseUrl}/auth/forgot-password';
  static String updatePassword() => '${Config.baseUrl}/auth/change-password';

  static String countries() => '${Config.baseUrl}/countries';
  static String profile() => '${Config.baseUrl}/auth/getMe';
  static String allJobs() => '${Config.baseUrl}/job';
  static String myJobs() => '${Config.baseUrl}/job/myJob/me';

  static String fetchApplicants(id) => '${Config.baseUrl}/applicants/all/$id';
  static String fetchApprovedApplicants(id) =>
      '${Config.baseUrl}/applicants/approved/$id';

  static String fetchApprovedJobs() =>
      '${Config.baseUrl}/applicants/approved/serviceProvider/mine';
  static String shortlisthApplicants(id) =>
      '${Config.baseUrl}/applicants/shortlist/$id';
  static String approveShortlisthApplicants(id) =>
      '${Config.baseUrl}/applicants/approve/$id';
  static String addJob() => '${Config.baseUrl}/job';
  static String applyForJob(id) => '${Config.baseUrl}/job/$id';
  static String startJob(id) =>
      '${Config.baseUrl}/applicants/approved/start/$id';
  static String confirmStartJob(id) =>
      '${Config.baseUrl}/applicants/approved/start-confirm/$id';
  static String endJob(id) => '${Config.baseUrl}/applicants/approved/end/$id';
  static String confirmEndJob(id) =>
      '${Config.baseUrl}/applicants/approved/end-confirm/$id';
}

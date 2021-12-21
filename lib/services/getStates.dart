import 'dart:io';

import 'package:get/get.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/applicantsModel.dart';
import 'package:sabiwork/models/approvedJobModel.dart';
import 'package:sabiwork/models/myJobsModel.dart';
import 'package:sabiwork/models/userModel.dart';

class Controller extends GetxController {
  final activeTab = 0.obs;
  // define loading state.
  final isLoading = false.obs;

  final isFetchingJobs = false.obs;

  final isFetchingMyJobs = false.obs;
  final isFetchingApplicants = false.obs;
  Rx<UserModel> userData = UserModel().obs;
  Rx<AllJobsModel> allJobs = AllJobsModel().obs;
  Rx<MyJobsModel> myJobs = MyJobsModel().obs;
  Rx<ApplicantsModel> allApplicants = ApplicantsModel().obs;
  Rx<ApplicantsModel> allApprovedApplicants = ApplicantsModel().obs;
  Rx<ApprovedJobModel> allApprovedJobs = ApprovedJobModel().obs;

  // update state
  void change(state) => isLoading.value = state;
  void updateJobFetchStatus(state) => isFetchingJobs.value = state;

  void updateMyJobFetchStatus(state) => isFetchingMyJobs.value = state;

  void updataeApplicantsFetchStatus(state) {
    isFetchingApplicants.value = state;
    isFetchingApplicants.refresh();
  }

  void setUserData(state) => userData.value = state;
  void resetUserData() => userData = UserModel().obs;
  void setAllJobs(state) {
    print('jobss $state');
    allJobs.value = state;
  }

  void setMyJobs(state) {
    print('jobss $state');
    myJobs.value = state;
  }

  void setAllApplicants(state) {
    print('jobss $state');
    allApplicants.value = state;
  }

  void setAllApprovedApplicants(state) {
    print('jobss $state');
    allApprovedApplicants.value = state;
  }

  void setAllApprovedJobs(state) {
    print('jobss $state');
    allApprovedJobs.value = state;
  }

  void resetApplicants() {
    allApplicants = ApplicantsModel().obs;
  }

  void resetApprovedApplicants() {
    allApprovedApplicants = ApplicantsModel().obs;
  }

  void resetApprovedJobs() {
    allApprovedJobs = ApprovedJobModel().obs;
  }

  void updateTab(state) => activeTab.value = state;
}

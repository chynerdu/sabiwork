import 'dart:io';

import 'package:get/get.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/userModel.dart';

class Controller extends GetxController {
  final activeTab = 0.obs;
  // define loading state.
  final isLoading = false.obs;

  final isFetchingJobs = false.obs;
  final userData = UserModel().obs;
  Rx<AllJobsModel> allJobs = AllJobsModel().obs;

  // update state
  void change(state) => isLoading.value = state;
  void updateJobFetchStatus(state) => isFetchingJobs.value = state;

  void setUserData(state) => userData.value = state;
  void setAllJobs(state) {
    print('jobss $state');
    allJobs.value = state;
  }

  void updateTab(state) => activeTab.value = state;
}

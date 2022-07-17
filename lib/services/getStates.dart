import 'dart:io';

import 'package:get/get.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/applicantsModel.dart';
import 'package:sabiwork/models/approvedJobModel.dart';
import 'package:sabiwork/models/messagesModel.dart' as MData;
import 'package:sabiwork/models/myAppliedJobs.dart';
import 'package:sabiwork/models/myJobsModel.dart';

import 'package:sabiwork/models/ongoingJobsModel.dart';
import 'package:sabiwork/models/reccentChatModel.dart';
import 'package:sabiwork/models/userModel.dart';

class Controller extends GetxController {
  final activeTab = 0.obs;
  final activeGender = 0.obs;
  // define loading state.
  final isLoading = false.obs;

  final activeRecipient = ''.obs;

  final isFetchingJobs = false.obs;

  final isFetchingMyJobs = false.obs;
  final isFetchingApplicants = false.obs;
  final isFetchingMessage = false.obs;
  Rx<UserModel> userData = UserModel().obs;
  Rx<AllJobsModel> allJobs = AllJobsModel().obs;
  Rx<MData.ChatMessagesModel> allMessages = MData.ChatMessagesModel().obs;

  Rx<MyJobsModel> myJobs = MyJobsModel().obs;

  Rx<MyJobsModel> myOpenJobs = MyJobsModel().obs;
  Rx<ActiveApplicantsModel> activeApplicants = ActiveApplicantsModel().obs;

  Rx<MyJobsModel> myClosedJobs = MyJobsModel().obs;

  Rx<MyAppliedJobModel> myAppliedJobs = MyAppliedJobModel().obs;
  Rx<ApplicantsModel> allApplicants = ApplicantsModel().obs;
  Rx<ApplicantsModel> allApprovedApplicants = ApplicantsModel().obs;
  Rx<ApprovedJobModel> allApprovedJobs = ApprovedJobModel().obs;
  Rx<RecentChatModel> recentChats = RecentChatModel().obs;

  // update state
  void change(state) => isLoading.value = state;
  void updateJobFetchStatus(state) => isFetchingJobs.value = state;

  void updateMyJobFetchStatus(state) => isFetchingMyJobs.value = state;

  void updateFetchingMessageStatus(state) => isFetchingMessage.value = state;

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

  void setAllMessages(state) {
    allMessages.value = state;
  }

  void setActiveRecipient(state) {
    activeRecipient.value = state;
  }

  void setRecentChats(state) {
    recentChats.value = state;
  }

  void setActiveApplicants(state) {
    activeApplicants.value = state;
  }

  void setMyJobs(state) {
    myJobs.value = state;
  }

  void updateMyJob(state) {
    if (myJobs.value.data == null) return;
    final index =
        myJobs.value.data!.indexWhere((element) => element.sId == state.sId);

    if (index != -1) {
      var updatedJob = myJobs.value.data![index];
      updatedJob = state;
      myJobs.value.data!.removeAt(index);
      myJobs.value.data!.insert(index, updatedJob);
      myJobs.refresh();
    }
  }

  void updateMyOpenJob(state) {
    if (myOpenJobs.value.data == null) return;
    final index = myOpenJobs.value.data!
        .indexWhere((element) => element.sId == state.sId);

    if (index != -1) {
      var updatedJob = myOpenJobs.value.data![index];
      updatedJob = state;
      myOpenJobs.value.data!.removeAt(index);
      myOpenJobs.value.data!.insert(index, updatedJob);
      myOpenJobs.refresh();
    }
  }

  void updateMyClosedJob(state) {
    if (myClosedJobs.value.data == null) return;
    final index = myClosedJobs.value.data!
        .indexWhere((element) => element.sId == state.sId);

    if (index != -1) {
      var updatedJob = myClosedJobs.value.data![index];
      updatedJob = state;
      myClosedJobs.value.data!.removeAt(index);
      myClosedJobs.value.data!.insert(index, updatedJob);
      myClosedJobs.refresh();
    }
  }

  void setMyOpenJobs(state) {
    myOpenJobs.value = state;
  }

  void setMyClosedJobs(state) {
    myClosedJobs.value = state;
  }

  void setMyAppliedJobs(state) {
    myAppliedJobs.value = state;
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

  void updateMessageList(rawData) {
    var item = MData.Data.fromJson(rawData);
    List<MData.Data>? messageCopy = allMessages.value.result!.data;
    messageCopy!.insert(0, item);
    allMessages.value.result!.data = messageCopy;
    allMessages.refresh();
  }

  void updateTab(state) => activeTab.value = state;

  void updateGender(state) => activeGender.value = state;
}

import 'package:get/get.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/applicantsModel.dart';
import 'package:sabiwork/models/applyJobModel.dart';
import 'package:sabiwork/models/approvedJobModel.dart';
import 'package:sabiwork/models/myAppliedJobs.dart';
import 'package:sabiwork/models/myJobsModel.dart';
import 'package:sabiwork/models/myJobsModel.dart' as myJob;

import 'package:sabiwork/models/ongoingJobsModel.dart';
import 'package:sabiwork/services/api_path.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/http_instance.dart';
import 'package:sabiwork/services/localStorage.dart';

class JobService {
  LocalStorage localStorage = LocalStorage();
  final _service = HttpInstance.instance;

  Future fetchAllJobs() async {
    Controller c = Get.put(Controller());
    try {
      c.updateJobFetchStatus(true);
      final result = await _service.getData(path: APIPath.allJobs());
      AllJobsModel decodedData = AllJobsModel.fromJson(result['result']);
      print('jobs $decodedData');
      c.setAllJobs(decodedData);
      c.updateJobFetchStatus(false);
      print('result : $result');
      c.change(false);
      return decodedData;
    } catch (e) {
      c.updateJobFetchStatus(true);
    }
  }

  Future fetchMyJobs() async {
    Controller c = Get.put(Controller());
    try {
      c.updateMyJobFetchStatus(true);
      final result = await _service.getData(path: APIPath.myJobs());
      MyJobsModel decodedData = MyJobsModel.fromJson(result['result']);
      print('jobs $decodedData');
      c.setMyJobs(decodedData);
      c.updateMyJobFetchStatus(false);
      print('result my jobs : $result');

      return decodedData;
    } catch (e) {
      c.updateMyJobFetchStatus(false);
    }
  }

  Future fetchMyOpenJobs() async {
    Controller c = Get.put(Controller());
    try {
      c.updateMyJobFetchStatus(true);
      final result = await _service.getData(path: APIPath.myOpenJobs());
      MyJobsModel decodedData = MyJobsModel.fromJson(result['result']);
      print('jobs $decodedData');
      c.setMyOpenJobs(decodedData);
      c.updateMyJobFetchStatus(false);

      return decodedData;
    } catch (e) {
      c.updateMyJobFetchStatus(false);
    }
  }

  Future fetchActiveApplicants() async {
    Controller c = Get.put(Controller());
    try {
      c.updateMyJobFetchStatus(true);
      final result =
          await _service.getData(path: APIPath.fetchActiveApplicants());
      ActiveApplicantsModel decodedData =
          ActiveApplicantsModel.fromJson(result);
      print('jobs $decodedData');
      c.setActiveApplicants(decodedData);
      c.updateMyJobFetchStatus(false);

      return decodedData;
    } catch (e) {
      c.updateMyJobFetchStatus(false);
    }
  }

  Future fetchMyClosedJobs() async {
    Controller c = Get.put(Controller());

    try {
      c.updateMyJobFetchStatus(true);
      final result = await _service.getData(path: APIPath.myClosedJobs());
      MyJobsModel decodedData = MyJobsModel.fromJson(result['result']);
      print('jobs $decodedData');
      c.setMyClosedJobs(decodedData);
      c.updateMyJobFetchStatus(false);

      return decodedData;
    } catch (e) {
      c.updateMyJobFetchStatus(false);
    }
  }

  Future updateMyJob(id, payload) async {
    Controller c = Get.put(Controller());
    final result = await _service.putData(APIPath.myJob(id), payload);
    print('result $result');
    myJob.MyJobData decodedData = myJob.MyJobData.fromJson(result['data']);
    print('jobs $decodedData');
    c.updateMyJob(decodedData);
    c.updateMyOpenJob(decodedData);
    c.updateMyClosedJob(decodedData);
    fetchMyJobs();
    fetchMyOpenJobs();
    fetchMyClosedJobs();
    return decodedData;
    // c.setMyClosedJobs(decodedData);
  }

  Future fetchAppliedJobs() async {
    Controller c = Get.put(Controller());
    try {
      c.updateMyJobFetchStatus(true);
      final result = await _service.getData(path: APIPath.myAppliedJobs());
      MyAppliedJobModel decodedData = MyAppliedJobModel.fromJson(result);
      print('jobs $decodedData');
      c.setMyAppliedJobs(decodedData);
      c.updateMyJobFetchStatus(false);
      print('result my applied jobs : $result');

      return decodedData;
    } catch (e) {
      c.updateMyJobFetchStatus(false);
      print('error fetching applied jobs $e');
    }
  }

  Future fetchApplicants(id) async {
    Controller c = Get.put(Controller());
    try {
      c.resetApplicants();

      c.updataeApplicantsFetchStatus(true);
      final result = await _service.getData(path: APIPath.fetchApplicants(id));

      // filter out approved applicants
      var updatedResult;
      if (c.allApprovedApplicants.value.data != null) {
        if (c.allApprovedApplicants.value.data!.length > 0) {
          var filteredList = [];
          var approvedApplicants = [];
          c.allApprovedApplicants.value.data!.forEach((item) {
            approvedApplicants.add(item.user!.id);
          });

          // result['result']['data'].forEach(
          //   (apllicant) =>
          //       c.allApprovedApplicants.value.data!.map((approvedApplicant) {
          //     if (approvedApplicant.user!.id != apllicant['user']['_id']) {
          //       print(
          //           'compared ${approvedApplicant.user!.id} to ${apllicant['user']['_id']}');
          //       print('added to list');
          //       filteredList.add(apllicant);
          //     }
          //   }),
          // );
          result['result']['data'].forEach((apllicant) {
            if (!approvedApplicants.contains(apllicant['user']['_id'])) {
              filteredList.add(apllicant);
            }
          });

          updatedResult = {
            ...result,
            'result': new Map<String, dynamic>.from(
                {...result['result'], 'data': filteredList})
          };
        } else {
          updatedResult = result;
        }
      } else {
        updatedResult = result;
      }

      ApplicantsModel decodedData =
          ApplicantsModel.fromJson(updatedResult['result']);

      c.setAllApplicants(decodedData);
      c.updataeApplicantsFetchStatus(false);
      print('result : $result');

      return decodedData;
    } catch (e) {
      c.updataeApplicantsFetchStatus(false);
    }
  }

  Future fetchApprovedApplicants(id) async {
    Controller c = Get.put(Controller());

    try {
      c.resetApprovedApplicants();

      c.updataeApplicantsFetchStatus(true);
      final result =
          await _service.getData(path: APIPath.fetchApprovedApplicants(id));
      ApplicantsModel decodedData = ApplicantsModel.fromJson(result['result']);
      print('applicants $decodedData');
      c.setAllApprovedApplicants(decodedData);
      c.updataeApplicantsFetchStatus(false);
      print('result : $result');

      return decodedData;
    } catch (e) {
      c.updataeApplicantsFetchStatus(false);
    }
  }

  Future fetchApprovedJobs() async {
    Controller c = Get.put(Controller());
    try {
      c.resetApprovedJobs();

      c.updataeApplicantsFetchStatus(true);
      final result = await _service.getData(path: APIPath.fetchApprovedJobs());
      ApprovedJobModel decodedData =
          ApprovedJobModel.fromJson(result['result']);
      print('applicants $decodedData');
      c.setAllApprovedJobs(decodedData);
      c.updataeApplicantsFetchStatus(false);
      print('result : $result');

      return decodedData;
    } catch (e) {
      c.updataeApplicantsFetchStatus(false);
    }
  }

  Future applyForJob(ApplyJobModel payload, id) async {
    final authResult =
        await _service.postData(APIPath.applyForJob(id), payload);
    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');
    await fetchAllJobs();
    return authResult;
  }

  Future shortlistApplicant({id, applicantId}) async {
    final authResult = await _service.postData(
        APIPath.shortlisthApplicants(id), {"applicant_id": "$applicantId"});
    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');

    return authResult;
  }

  Future approveShortlistApplicant({id, applicantId}) async {
    final authResult = await _service.postData(
        APIPath.approveShortlisthApplicants(id),
        {"applicant_id": "$applicantId"});
    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');

    return authResult;
  }

  Future startJob({approvedJobId}) async {
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      print('approved job $approvedJobId');

      final jobResult =
          await _service.getData(path: APIPath.startJob(approvedJobId));

      // final decodedData = UserModel.fromJson(jobResult);
      print('result : $jobResult');
      c.change(false);
      fetchApprovedJobs();

      return jobResult;
    } catch (e) {
      c.change(false);
    }
  }

  Future confirmStartJob({approvedJobId}) async {
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      final jobResult =
          await _service.getData(path: APIPath.confirmStartJob(approvedJobId));

      // final decodedData = UserModel.fromJson(jobResult);
      print('result : $jobResult');
      fetchApprovedApplicants(approvedJobId);

      return jobResult;
    } catch (e) {
      c.change(false);
    }
  }

  Future endJob({approvedJobId}) async {
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      final jobResult =
          await _service.getData(path: APIPath.endJob(approvedJobId));

      // final decodedData = UserModel.fromJson(jobResult);
      print('result : $jobResult');
      fetchApprovedJobs();
      return jobResult;
    } catch (e) {
      c.change(false);
    }
  }

  Future confirmEndJob({approvedJobId}) async {
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      final jobResult =
          await _service.getData(path: APIPath.confirmEndJob(approvedJobId));

      // final decodedData = UserModel.fromJson(jobResult);
      print('result : $jobResult');
      fetchApprovedApplicants(approvedJobId);
      return jobResult;
    } catch (e) {
      c.change(false);
    }
  }
}

filterList() {}

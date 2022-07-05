import 'package:get/get.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/applicantsModel.dart';
import 'package:sabiwork/models/applyJobModel.dart';
import 'package:sabiwork/models/approvedJobModel.dart';
import 'package:sabiwork/models/myAppliedJobs.dart';
import 'package:sabiwork/models/myJobsModel.dart';
import 'package:sabiwork/models/myJobsModel.dart' as myJob;
import 'package:sabiwork/services/api_path.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/http_instance.dart';
import 'package:sabiwork/services/localStorage.dart';

class JobService {
  LocalStorage localStorage = LocalStorage();
  final _service = HttpInstance.instance;

  Future fetchAllJobs() async {
    Controller c = Get.put(Controller());
    c.updateJobFetchStatus(true);
    final result = await _service.getData(path: APIPath.allJobs());
    AllJobsModel decodedData = AllJobsModel.fromJson(result['result']);
    print('jobs $decodedData');
    c.setAllJobs(decodedData);
    c.updateJobFetchStatus(false);
    print('result : $result');

    return decodedData;
  }

  Future fetchMyJobs() async {
    Controller c = Get.put(Controller());
    c.updateMyJobFetchStatus(true);
    final result = await _service.getData(path: APIPath.myJobs());
    MyJobsModel decodedData = MyJobsModel.fromJson(result['result']);
    print('jobs $decodedData');
    c.setMyJobs(decodedData);
    c.updateMyJobFetchStatus(false);
    print('result my jobs : $result');

    return decodedData;
  }

  Future fetchMyOpenJobs() async {
    Controller c = Get.put(Controller());
    c.updateMyJobFetchStatus(true);
    final result = await _service.getData(path: APIPath.myOpenJobs());
    MyJobsModel decodedData = MyJobsModel.fromJson(result['result']);
    print('jobs $decodedData');
    c.setMyOpenJobs(decodedData);
    c.updateMyJobFetchStatus(false);

    return decodedData;
  }

  Future fetchMyClosedJobs() async {
    Controller c = Get.put(Controller());
    c.updateMyJobFetchStatus(true);
    final result = await _service.getData(path: APIPath.myClosedJobs());
    MyJobsModel decodedData = MyJobsModel.fromJson(result['result']);
    print('jobs $decodedData');
    c.setMyClosedJobs(decodedData);
    c.updateMyJobFetchStatus(false);

    return decodedData;
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
    c.updateMyJobFetchStatus(true);
    final result = await _service.getData(path: APIPath.myAppliedJobs());
    MyAppliedJobModel decodedData = MyAppliedJobModel.fromJson(result);
    print('jobs $decodedData');
    c.setMyAppliedJobs(decodedData);
    c.updateMyJobFetchStatus(false);
    print('result my applied jobs : $result');

    return decodedData;
  }

  Future fetchApplicants(id) async {
    Controller c = Get.put(Controller());
    c.resetApplicants();

    c.updataeApplicantsFetchStatus(true);
    final result = await _service.getData(path: APIPath.fetchApplicants(id));
    print('length 22 ${result['result']['data'].length}');
    // filter out approved applicants
    var updatedResult;
    if (c.allApprovedApplicants.value.data != null &&
        result['result']['data'].length > 0) {
      var filteredList = result['result']['data']
          .where((apllicant) => c.allApprovedApplicants.value.data!.any(
              (approvedApplicant) =>
                  approvedApplicant.user!.id != apllicant['user']['_id']))
          .toList();

      updatedResult = {
        ...result,
        'result': new Map<String, dynamic>.from(
            {...result['result'], 'data': filteredList})
      };
    } else {
      updatedResult = result;
    }

    ApplicantsModel decodedData =
        ApplicantsModel.fromJson(updatedResult['result']);

    c.setAllApplicants(decodedData);
    c.updataeApplicantsFetchStatus(false);
    print('result : $result');

    return decodedData;
  }

  Future fetchApprovedApplicants(id) async {
    Controller c = Get.put(Controller());
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
  }

  Future fetchApprovedJobs() async {
    Controller c = Get.put(Controller());
    c.resetApprovedJobs();

    c.updataeApplicantsFetchStatus(true);
    final result = await _service.getData(path: APIPath.fetchApprovedJobs());
    ApprovedJobModel decodedData = ApprovedJobModel.fromJson(result['result']);
    print('applicants $decodedData');
    c.setAllApprovedJobs(decodedData);
    c.updataeApplicantsFetchStatus(false);
    print('result : $result');

    return decodedData;
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
    print('approved job $approvedJobId');
    final jobResult =
        await _service.getData(path: APIPath.startJob(approvedJobId));

    // final decodedData = UserModel.fromJson(jobResult);
    print('result : $jobResult');
    fetchApprovedJobs();
    return jobResult;
  }

  Future confirmStartJob({approvedJobId}) async {
    final jobResult =
        await _service.getData(path: APIPath.confirmStartJob(approvedJobId));

    // final decodedData = UserModel.fromJson(jobResult);
    print('result : $jobResult');
    fetchApprovedApplicants(approvedJobId);

    return jobResult;
  }

  Future endJob({approvedJobId}) async {
    final jobResult =
        await _service.getData(path: APIPath.endJob(approvedJobId));

    // final decodedData = UserModel.fromJson(jobResult);
    print('result : $jobResult');
    fetchApprovedJobs();
    return jobResult;
  }

  Future confirmEndJob({approvedJobId}) async {
    final jobResult =
        await _service.getData(path: APIPath.confirmEndJob(approvedJobId));

    // final decodedData = UserModel.fromJson(jobResult);
    print('result : $jobResult');
    fetchApprovedApplicants(approvedJobId);
    return jobResult;
  }
}

filterList() {}

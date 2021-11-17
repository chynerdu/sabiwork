import 'package:get/get.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/applyJobModel.dart';
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

  Future applyForJob(ApplyJobModel payload, id) async {
    final authResult =
        await _service.postData(APIPath.applyForJob(id), payload);
    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');
    await fetchAllJobs();
    return authResult;
  }
}

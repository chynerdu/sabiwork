import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sabiwork/models/changePasswordModel.dart';
import 'package:sabiwork/models/editProfileModel.dart';
import 'package:sabiwork/models/firebaseSubscribeModel.dart';
import 'package:sabiwork/models/otherInfoModel.dart';
import 'package:sabiwork/models/signinModel.dart';
import 'package:sabiwork/models/signupModel.dart';
import 'package:sabiwork/models/userModel.dart';
import 'package:sabiwork/services/getStates.dart';

import 'api_path.dart';
import 'http_instance.dart';
import 'localStorage.dart';

// class User {
//   User({@required this.token});
//   final String token;
// }

LocalStorage localStorage = LocalStorage();

class AuthService {
  final _service = HttpInstance.instance;
  late FirebaseMessaging messaging;
  FirebaseSubscribeModel firebaseSubscribeModel = FirebaseSubscribeModel();

  Future signIn(SigninModel payload) async {
    final authResult = await _service.postData(APIPath.userSignIn(), payload);
    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');
    await localStorage.setData(name: 'token', data: authResult['token']);
    await fetchProfile();
  }

  Future requestPasswordReset(SigninModel payload) async {
    final authResult =
        await _service.postData(APIPath.requestPasswordReset(), payload);
    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');
  }

  Future signUp(SignupModel payload) async {
    final authResult = await _service.postData(APIPath.userSignUp(), payload);
    print('result : $authResult');
    await localStorage.setData(name: 'token', data: authResult['token']);
    await fetchProfile();
    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');
  }

  Future upateAccount(OtherInfoModel payload) async {
    final authResult = await _service.putData(APIPath.updateAccount(), payload);
    await fetchProfile();
    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');
  }

  Future forgotPassword(dynamic payload) async {
    final authResult =
        await _service.postData(APIPath.forgotPassword(), payload);

    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');
  }

  Future updatePassword(ChangePasswordModel payload) async {
    final authResult =
        await _service.postData(APIPath.updatePassword(), payload);

    // final decodedData = UserModel.fromJson(authResult);
    print('result : $authResult');
  }

  Future fetchProfile() async {
    Controller c = Get.put(Controller());
    final result = await _service.getData(path: APIPath.profile());
    final decodedData = UserModel.fromJson(result['result']['data']);
    c.setUserData(decodedData);
    initFirebase('443');
    print('result : $result');

    return decodedData;
  }

  Future subscribeToFirebase(FirebaseSubscribeModel payload) async {
    try {
      final authResult =
          await _service.postData(APIPath.subscribeToFirebase(), payload);

      return authResult;
    } catch (e) {
      return e;
    }
  }

  Future fetchStates() async {
    Controller c = Get.put(Controller());
    c.updateJobFetchStatus(true);
    final result = await _service.getData(path: APIPath.states());

    print('result : $result');

    return result;
  }

  Future fetchLGA(id) async {
    Controller c = Get.put(Controller());
    c.updateJobFetchStatus(true);
    final result = await _service.getData(path: APIPath.lga(id));

    print('result : $result');

    return result;
  }

  initFirebase(accountId) {
    Firebase.initializeApp().whenComplete(() {
      messaging = FirebaseMessaging.instance;
      messaging.subscribeToTopic("newJob");
      messaging.getToken().then((value) async {
        print('firebase token $value');
        firebaseSubscribeModel.firebaseDeviceToken = value;

        var result = await subscribeToFirebase(firebaseSubscribeModel);
        print('subscribed $result');
      });
    });
    Firebase.initializeApp();
  }
}

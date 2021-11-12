import 'package:get/get.dart';
import 'package:sabiwork/models/userModel.dart';

class Controller extends GetxController {
  final activeTab = 0.obs;
  // define loading state.
  final isLoading = false.obs;
  final userData = UserModel().obs;

  // update state
  void change(state) => isLoading.value = state;

  void setUserData(state) => userData.value = state;
  void updateTab(state) => activeTab.value = state;
}

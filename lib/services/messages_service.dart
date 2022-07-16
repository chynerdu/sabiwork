import 'package:get/get.dart';
import 'package:sabiwork/models/messagesModel.dart';
import 'package:sabiwork/models/reccentChatModel.dart';
import 'package:sabiwork/services/api_path.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/http_instance.dart';
import 'package:sabiwork/services/localStorage.dart';

class MessageService {
  LocalStorage localStorage = LocalStorage();
  final _service = HttpInstance.instance;

  Future fetchMessage({recipientId}) async {
    Controller c = Get.put(Controller());
    try {
      c.setAllMessages(ChatMessagesModel());
      c.updateFetchingMessageStatus(true);
      print('receipient $recipientId');
      final result =
          await _service.getData(path: APIPath.allMessages(recipientId));
      ChatMessagesModel decodedData = ChatMessagesModel.fromJson(result);
      print('messages $decodedData');
      c.setAllMessages(decodedData);
      c.setActiveRecipient(recipientId);
      c.updateFetchingMessageStatus(false);
      print('result : $result');

      return decodedData;
    } catch (e) {
      c.updateFetchingMessageStatus(false);
    }
  }

  Future fetchRecentChats() async {
    Controller c = Get.put(Controller());
    try {
      c.updateFetchingMessageStatus(true);
      final result = await _service.getData(path: APIPath.recentChats());
      RecentChatModel decodedData = RecentChatModel.fromJson(result);
      print('messages $decodedData');
      c.setRecentChats(decodedData);
      c.updateFetchingMessageStatus(false);
      print('result : $result');

      return decodedData;
    } catch (e) {
      c.updateFetchingMessageStatus(false);
    }
  }
}

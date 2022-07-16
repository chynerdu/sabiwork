// ignore_for_file: avoid_print
import 'package:get/get.dart';

import 'package:sabiwork/services/config.dart';
import 'package:sabiwork/services/getStates.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketConnection {
  Socket socket = io(
      // 'https://a1e3-102-89-46-147.ngrok.io',
      Config.socketUrl,
      // dotenv.env['SOCKETURL'],
      OptionBuilder()
          .setPath('/socket.io/')
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableForceNewConnection()
          .build());

  startConnection() {
    print('connecting t socket');
    socket.connect();
    socket.on('connect', (data) {
      print('connected data ${socket.id}');
      joinChatRoom(socket);
      // join public room
    });
    socket.on('event', (data) => print(data));
    socket.on('error', (data) => print('connection error $data'));
    socket.on('connect_error', (data) {
      print('connection2 error $data');
    });

    socket.on('joined', (response) {
      // print('joined room ${response}');
    });

    socket.on('connectToRoom', (data) {});

    socket.on('newMessage', (data) {
      Controller c = Get.put(Controller());
      if (c.activeRecipient.value == data['data']['senderId']) {
        c.updateMessageList(data['data']);
      }
    });

    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    socket.onConnectError((e) {
      print('error $e');
    });
  }

  disconnectSocket() {
    print('disconnecting');

    socket.disconnect();

    socket.on('disconnect', (data) => print('Socket disconnected'));
  }

  joinChatRoom(IO.Socket socket) {
    Controller c = Get.put(Controller());
    var payload = {
      "userId": c.userData.value.id,
    };
    print('joing $payload');
    socket.emit('JoinPrivate', (payload));
  }

  sendMessage({message, recipientId}) {
    Controller c = Get.put(Controller());
    var data = {
      "recipientId": recipientId,
      "senderId": c.userData.value.id,
      "message": message

      // "senderId": recipientId,
      // "recipientId": c.userData.value.id,
      // "message": message
    };
    print('sending message $data');
    socket.emit('sendPrivateMessage', (data));
    c.updateMessageList(data);
  }
}

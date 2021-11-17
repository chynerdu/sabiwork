import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sabiwork/models/responseModel.dart';
import 'package:sabiwork/services/getStates.dart';

import 'dart:math';

import 'package:sabiwork/services/localStorage.dart';

Random random = new Random();
LocalStorage localStorage = LocalStorage();
int randomNumber = random.nextInt(100);

class HttpInstance {
  HttpInstance._();

  static final instance = HttpInstance._();

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "charset": "utf-8",
    "x-RequestID": "$randomNumber",
    "Authorization": ""
  };

  Future getData({required String path}) async {
    var token = await localStorage.getData(name: 'token');
    headers['Authorization'] = "Bearer $token";
    print('token ${headers['Authorization']}');
    Controller c = Get.put(Controller());
    print('path $path');
    try {
      c.change(true);
      Future<http.Response> apiResponse =
          http.get(Uri.parse(path), headers: headers);
      http.Response response = await apiResponse;
      print('api $path');
      print('response code ${response.statusCode}');
      print('response ${response.body}');
      c.change(false);
      if (response.statusCode < 200 || response.statusCode > 299) {
        throw ResponseModel.fromJson(jsonDecode(response.body));
      }
      return jsonDecode(response.body);
    } on SocketException catch (_) {
      c.change(false);
      throw 'Kindly, check your internet connection.';
    } on TimeoutException catch (_) {
      c.change(false);
      throw 'Request Timeout.';
    } on FormatException catch (_) {
      c.change(false);
      throw 'Error Occured.';
    } catch (e) {
      final ResponseModel error = e as ResponseModel;
      c.change(false);
      print('errr ${e.toString()} ');
      throw error.error ?? 'error occured';
    }
  }

  Future postData(String path, data) async {
    var token = await localStorage.getData(name: 'token');
    headers['Authorization'] = "Bearer $token";
    print('token ${headers['Authorization']}');
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      Future<http.Response> apiResponse = http.post(
        Uri.parse(path),
        body: jsonEncode(data),
        headers: headers,
      );
      http.Response response = await apiResponse;
      print('api $path');
      print('api body ${jsonEncode(data)}');
      print('response code ${response.statusCode}');
      print('response ${response.body}');
      c.change(false);
      if (response.statusCode < 200 || response.statusCode > 299) {
        throw ResponseModel.fromJson(jsonDecode(response.body));
      }
      ResponseModel decodedData =
          ResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode < 200 || response.statusCode > 299) {
        print('here');
        throw decodedData;
      }
      return decodedData.result ?? decodedData.message;
    } on SocketException catch (_) {
      c.change(false);
      throw 'Kindly, check your internet connection.';
    } on TimeoutException catch (_) {
      c.change(false);
      throw 'Request Timeout.';
    } on FormatException catch (_) {
      c.change(false);
      throw 'Error Occured.';
    } catch (e) {
      final ResponseModel error = e as ResponseModel;
      c.change(false);
      print('errr ${e.toString()} ');
      throw error.error ?? 'error occured';
    }
  }

  Future patchData(String path, data) async {
    var token = await localStorage.getData(name: 'token');
    headers['Authorization'] = "Bearer $token";
    print('token ${headers['Authorization']}');
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      Future<http.Response> apiResponse = http.patch(
        Uri.parse(path),
        body: jsonEncode(data),
        headers: headers,
      );
      http.Response response = await apiResponse;
      print('api $path');
      print('api body ${jsonEncode(data)}');
      print('response code ${response.statusCode}');
      print('response ${response.body}');
      c.change(false);
      if (response.statusCode < 200 || response.statusCode > 299) {
        throw ResponseModel.fromJson(jsonDecode(response.body));
      }
      ResponseModel decodedData =
          ResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode < 200 || response.statusCode > 299) {
        print('here');
        throw decodedData;
      }
      return decodedData.result ?? decodedData.message;
    } on SocketException catch (_) {
      c.change(false);
      throw 'Kindly, check your internet connection.';
    } on TimeoutException catch (_) {
      c.change(false);
      throw 'Request Timeout.';
    } on FormatException catch (_) {
      c.change(false);
      throw 'Error Occured.';
    } catch (e) {
      final ResponseModel error = e as ResponseModel;
      c.change(false);
      print('errr ${e.toString()} ');
      throw error.error ?? 'error occured';
    }
  }

  Future putData(String path, data) async {
    var token = await localStorage.getData(name: 'token');
    headers['Authorization'] = "Bearer $token";
    print('token ${headers['Authorization']}');
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      Future<http.Response> apiResponse = http.put(
        Uri.parse(path),
        body: jsonEncode(data),
        headers: headers,
      );
      http.Response response = await apiResponse;
      print('api $path');
      print('api body ${jsonEncode(data)}');
      print('response code ${response.statusCode}');
      print('response ${response.body}');
      c.change(false);
      if (response.statusCode < 200 || response.statusCode > 299) {
        throw ResponseModel.fromJson(jsonDecode(response.body));
      }
      ResponseModel decodedData =
          ResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode < 200 || response.statusCode > 299) {
        print('here');
        throw decodedData;
      }
      return decodedData.result ?? decodedData.message;
    } on SocketException catch (_) {
      c.change(false);
      throw 'Kindly, check your internet connection.';
    } on TimeoutException catch (_) {
      c.change(false);
      throw 'Request Timeout.';
    } on FormatException catch (_) {
      c.change(false);
      throw 'Error Occured.';
    } catch (e) {
      final ResponseModel error = e as ResponseModel;
      c.change(false);
      print('errr ${e.toString()} ');
      throw error.error ?? 'error occured';
    }
  }
}

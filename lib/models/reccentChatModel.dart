import 'package:sabiwork/models/messagesModel.dart' as messageData;
import 'package:sabiwork/models/userModel.dart';

class RecentChatModel {
  Result? result;

  RecentChatModel({this.result});

  RecentChatModel.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  Meta? meta;
  List<Data>? data;

  Result({this.meta, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  Null? page;
  Null? limit;
  int? total;
  Null? pages;
  int? nextPage;

  Meta({this.page, this.limit, this.total, this.pages, this.nextPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    pages = json['pages'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['pages'] = this.pages;
    data['nextPage'] = this.nextPage;
    return data;
  }
}

class Data {
  String? sId;
  String? host;
  UserModel? recipient;
  int? iV;
  messageData.Data? lastMessage;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.host,
      this.recipient,
      this.iV,
      this.lastMessage,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    host = json['host'];
    recipient = json['recipient'] != null
        ? new UserModel.fromJson(json['recipient'])
        : null;
    iV = json['__v'];
    lastMessage = json['lastMessage'] != null
        ? new messageData.Data.fromJson(json['lastMessage'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['host'] = this.host;
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    data['__v'] = this.iV;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

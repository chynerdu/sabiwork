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
  Docs? docs;
  List<UserModel>? senderData;
  List<UserModel>? recipientData;

  Data({this.sId, this.docs, this.senderData, this.recipientData});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    docs = json['docs'] != null ? new Docs.fromJson(json['docs']) : null;
    if (json['senderData'] != null) {
      senderData = <UserModel>[];
      json['senderData'].forEach((v) {
        senderData!.add(new UserModel.fromJson(v));
      });
    }
    if (json['recipientData'] != null) {
      recipientData = <UserModel>[];
      json['recipientData'].forEach((v) {
        recipientData!.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.docs != null) {
      data['docs'] = this.docs!.toJson();
    }
    if (this.senderData != null) {
      data['senderData'] = this.senderData!.map((v) => v.toJson()).toList();
    }
    if (this.recipientData != null) {
      data['recipientData'] =
          this.recipientData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Docs {
  String? senderId;
  String? recipient;
  String? message;
  String? createdAt;

  Docs({this.senderId, this.recipient, this.message, this.createdAt});

  Docs.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    recipient = json['recipient'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['recipient'] = this.recipient;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

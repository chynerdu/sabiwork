import 'package:sabiwork/models/myJobsModel.dart';
import 'package:sabiwork/models/userModel.dart';

class ActiveApplicantsModel {
  Result? result;

  ActiveApplicantsModel({this.result});

  ActiveApplicantsModel.fromJson(Map<String, dynamic> json) {
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
  List<ActiveApplicantData>? data;

  Result({this.meta, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <ActiveApplicantData>[];
      json['data'].forEach((v) {
        data!.add(new ActiveApplicantData.fromJson(v));
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
  int? page;
  int? limit;
  int? total;
  int? pages;
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

class ActiveApplicantData {
  String? sId;
  String? jobApplicantStatus;
  bool? iActive;
  MyJobData? job;
  UserModel? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ActiveApplicantData({
    this.sId,
    this.jobApplicantStatus,
    this.iActive,
    this.job,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ActiveApplicantData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobApplicantStatus = json['jobApplicantStatus'];
    iActive = json['iActive'];
    // job = json['job'];
    job = json['job'] != null ? new MyJobData.fromJson(json['job']) : null;
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['jobApplicantStatus'] = this.jobApplicantStatus;
    data['iActive'] = this.iActive;
    data['job'] = this.job;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;

    return data;
  }
}

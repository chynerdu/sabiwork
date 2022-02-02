import 'package:sabiwork/models/userModel.dart';

class ApplicantsModel {
  List<ApplicantData>? data;

  ApplicantsModel({this.data});

  ApplicantsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new ApplicantData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApplicantData {
  String? sId;
  String? job;
  String? jobApplicantStatus;
  bool? iActive;
  UserModel? user;
  String? message;
  String? createdAt;
  int? iV;

  ApplicantData(
      {this.sId,
      this.job,
      this.jobApplicantStatus,
      this.iActive,
      this.user,
      this.message,
      this.createdAt,
      this.iV});

  ApplicantData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    job = json['job'];
    jobApplicantStatus = json['jobApplicantStatus'];
    iActive = json['iActive'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    message =
        json['message'] != null ? json['message'] : 'No additional information';
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['job'] = this.job;
    data['jobApplicantStatus'] = this.jobApplicantStatus;
    data['iActive'] = this.iActive;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

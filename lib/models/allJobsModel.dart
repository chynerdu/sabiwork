import 'package:sabiwork/models/userModel.dart';

class AllJobsModel {
  List<Data>? data;

  AllJobsModel({this.data});

  AllJobsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? jobType;
  int? applicantCount;
  List<String>? shortlistedApplicants;
  String? sId;
  String? description;
  String? additionalDetails;
  int? numberOfWorkers;
  int? pricePerWorker;
  UserModel? user;
  String? createdAt;
  int? iV;

  Data(
      {this.jobType,
      this.applicantCount,
      this.shortlistedApplicants,
      this.sId,
      this.description,
      this.additionalDetails,
      this.numberOfWorkers,
      this.pricePerWorker,
      this.user,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    jobType = json['job_type'];
    applicantCount = json['applicant_count'];
    shortlistedApplicants = json['shortlistedApplicants'].cast<String>();
    sId = json['_id'];
    description = json['description'];
    additionalDetails = json['additionalDetails'] ?? 'No additional details';
    numberOfWorkers = json['number_of_workers'];
    pricePerWorker = json['price_per_worker'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_type'] = this.jobType;
    data['applicant_count'] = this.applicantCount;
    data['shortlistedApplicants'] = this.shortlistedApplicants;
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['additionalDetails'] = this.additionalDetails;

    data['number_of_workers'] = this.numberOfWorkers;
    data['price_per_worker'] = this.pricePerWorker;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

// class User {
//   String? role;
//   List<String>? portfolio;
//   bool? firstTimeLogin;
//   String? sId;
//   String? firstName;
//   String? lastName;
//   String? phone;
//   String? email;
//   String? gender;
//   String? profileImage;
//   String? createdAt;
//   int? iV;

//   User(
//       {this.role,
//       this.portfolio,
//       this.firstTimeLogin,
//       this.sId,
//       this.firstName,
//       this.lastName,
//       this.phone,
//       this.email,
//       this.gender,
//       this.profileImage,
//       this.createdAt,
//       this.iV});

//   User.fromJson(Map<String, dynamic> json) {
//     role = json['role'];
//     portfolio = json['portfolio'].cast<String>();
//     firstTimeLogin = json['firstTimeLogin'];
//     sId = json['_id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     phone = json['phone'];
//     email = json['email'];
//     gender = json['gender'];
//     profileImage = json['profileImage'];
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['role'] = this.role;
//     data['portfolio'] = this.portfolio;
//     data['firstTimeLogin'] = this.firstTimeLogin;
//     data['_id'] = this.sId;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['gender'] = this.gender;
//     data['profileImage'] = this.profileImage;
//     data['createdAt'] = this.createdAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
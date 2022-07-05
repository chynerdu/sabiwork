import 'package:sabiwork/models/userModel.dart';

class MyJobsModel {
  List<MyJobData>? data;

  MyJobsModel({this.data});

  MyJobsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        // check for null description
        if (v['description'] != 'null') data!.add(new MyJobData.fromJson(v));
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

class MyJobData {
  String? jobType;
  int? applicantCount;
  List<String>? shortlistedApplicants;
  String? sId;
  List<String>? jobImages;
  String? jobStatus;
  String? isActive;
  String? description;
  String? additionalDetails;
  dynamic numberOfWorkers;
  dynamic pricePerWorker;
  UserModel? user;
  String? state;
  String? lga;
  String? address;

  String? createdAt;
  int? iV;

  MyJobData(
      {this.jobType,
      this.applicantCount,
      this.shortlistedApplicants,
      this.sId,
      this.jobImages,
      this.description,
      this.jobStatus,
      this.isActive,
      this.additionalDetails,
      this.numberOfWorkers,
      this.pricePerWorker,
      this.state,
      this.lga,
      this.address,
      this.user,
      this.createdAt,
      this.iV});

  MyJobData.fromJson(Map<String, dynamic> json) {
    jobType = json['job_type'] ?? '-';
    jobImages = json['job_images'].cast<String>();

    applicantCount = json['applicant_count'];
    shortlistedApplicants = json['shortlistedApplicants'].cast<String>();
    sId = json['_id'];
    lga = json['lga'] == 'null' ? 'Not specified' : json['lga'];
    state = json['state'] ?? '';
    jobStatus = json['jobStatus'] ?? 'Closed';
    isActive = json['isActive'];
    address = json['address'];
    description = json['description'] ?? '-';
    additionalDetails = json['additionalDetails'] ?? 'No additional details';
    numberOfWorkers = int.tryParse(json['number_of_workers']) ?? 0;
    pricePerWorker = int.tryParse(json['price_per_worker']) ?? 0;
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_type'] = this.jobType;
    data['job_images'] = this.jobImages;

    data['applicant_count'] = this.applicantCount;
    data['shortlistedApplicants'] = this.shortlistedApplicants;
    data['_id'] = this.sId;
    data['lga'] = this.lga;
    data['state'] = this.state;
    data['jobStatus'] = this.jobStatus;
    data['isActive'] = this.isActive;
    data['address'] = this.address;
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

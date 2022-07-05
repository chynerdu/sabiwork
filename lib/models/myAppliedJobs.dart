class MyAppliedJobModel {
  Result? result;

  MyAppliedJobModel({this.result});

  MyAppliedJobModel.fromJson(Map<String, dynamic> json) {
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

class Job {
  String? sId;
  Data? job;
  String? message;
  String? createdAt;
  int? iV;

  Job({this.sId, this.job, this.message, this.createdAt, this.iV});

  Job.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    job = json['job'] != null ? new Data.fromJson(json['job']) : null;
    message = json['message'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Data {
  String? jobType;
  List<String>? jobImages;
  String? jobStatus;
  bool? iActive;
  String? sId;
  String? description;
  String? numberOfWorkers;
  String? pricePerWorker;
  String? additionalDetails;
  String? state;
  String? lga;
  String? address;
  User? user;
  String? createdAt;
  int? iV;

  Data(
      {this.jobType,
      this.jobImages,
      this.jobStatus,
      this.iActive,
      this.sId,
      this.description,
      this.numberOfWorkers,
      this.pricePerWorker,
      this.additionalDetails,
      this.state,
      this.lga,
      this.address,
      this.user,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    jobType = json['job_type'];
    jobImages = json['job_images'].cast<String>();
    jobStatus = json['jobStatus'];
    iActive = json['iActive'];
    sId = json['_id'];
    description = json['description'];
    numberOfWorkers = json['number_of_workers'];
    pricePerWorker = json['price_per_worker'];
    additionalDetails = json['additionalDetails'];
    state = json['state'];
    lga = json['lga'];
    address = json['address'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_type'] = this.jobType;
    data['job_images'] = this.jobImages;
    data['jobStatus'] = this.jobStatus;
    data['iActive'] = this.iActive;
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['number_of_workers'] = this.numberOfWorkers;
    data['price_per_worker'] = this.pricePerWorker;
    data['additionalDetails'] = this.additionalDetails;
    data['state'] = this.state;
    data['lga'] = this.lga;
    data['address'] = this.address;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? role;
  bool? firstTimeLogin;
  String? sId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? gender;
  String? createdAt;
  int? iV;
  String? firebaseDeviceToken;
  String? address;
  String? lga;
  String? profileImage;
  String? state;
  String? vIdentity;

  User(
      {this.role,
      this.firstTimeLogin,
      this.sId,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.gender,
      this.createdAt,
      this.iV,
      this.firebaseDeviceToken,
      this.address,
      this.lga,
      this.profileImage,
      this.state,
      this.vIdentity});

  User.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    firstTimeLogin = json['firstTimeLogin'];
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    firebaseDeviceToken = json['firebaseDeviceToken'];
    address = json['address'];
    lga = json['lga'];
    profileImage = json['profileImage'];
    state = json['state'];
    vIdentity = json['vIdentity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['firstTimeLogin'] = this.firstTimeLogin;
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['firebaseDeviceToken'] = this.firebaseDeviceToken;
    data['address'] = this.address;
    data['lga'] = this.lga;
    data['profileImage'] = this.profileImage;
    data['state'] = this.state;
    data['vIdentity'] = this.vIdentity;
    return data;
  }
}

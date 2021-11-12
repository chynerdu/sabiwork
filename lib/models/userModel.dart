class UserModel {
  String? phone;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  bool? firstTimeLogin;
  String? createdAt;
  String? gender;
  String? role;

  UserModel({
    this.phone,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.firstTimeLogin,
    this.createdAt,
    this.gender,
    this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    id = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    firstTimeLogin = json['firstTimeLogin'];
    createdAt = json['createdAt'];
    gender = json['gender'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['_id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['isActivated'] = this.firstTimeLogin;
    data['createdAt'] = this.createdAt;
    data['gender'] = this.gender;
    data['role'] = this.role;

    return data;
  }
}

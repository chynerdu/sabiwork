class SignupModel {
  String? firstName;
  String? lastName;
  String? email;
  String? countryId;
  String? password;

  SignupModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.countryId,
      this.password});

  SignupModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryId = json['countryId'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['countryId'] = this.countryId;
    data['password'] = this.password;

    return data;
  }
}

class EditProfileModel {
  String? firstName;
  String? lastName;

  String? countryId;

  EditProfileModel({
    this.firstName,
    this.lastName,
    this.countryId,
  });

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];

    countryId = json['countryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;

    data['countryId'] = this.countryId;

    return data;
  }
}

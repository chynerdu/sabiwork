class ChangePasswordModel {
  String? currentPassword;
  String? newPassword;

  String? confirmPassword;

  ChangePasswordModel({
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];

    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPassword'] = this.currentPassword;
    data['newPassword'] = this.newPassword;

    data['confirmPassword'] = this.confirmPassword;

    return data;
  }
}

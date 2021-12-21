class FirebaseSubscribeModel {
  // String? userId;
  String? firebaseDeviceToken;

  FirebaseSubscribeModel({this.firebaseDeviceToken});

  FirebaseSubscribeModel.fromJson(Map<String, dynamic> json) {
    // userId = json['userId'];
    firebaseDeviceToken = json['firebaseDeviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['userId'] = this.userId;
    data['firebaseDeviceToken'] = this.firebaseDeviceToken;
    return data;
  }
}

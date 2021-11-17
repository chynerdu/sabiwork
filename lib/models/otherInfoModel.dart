import 'package:http/http.dart';

class OtherInfoModel {
  String? state;
  String? lga;
  String? phone;
  String? address;
  String? lat;
  String? long;
  String? vIdentity;
  String? profileImage;

  OtherInfoModel(
      {this.state,
      this.lga,
      this.address,
      this.phone,
      this.lat,
      this.long,
      this.profileImage,
      this.vIdentity});

  OtherInfoModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    lga = json['lga'];
    address = json['address'];
    phone = json['phone'];
    lat = json['lat'];
    long = json['long'];
    vIdentity = json['vIdentity'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['lga'] = this.lga;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['vIdentity'] = this.vIdentity;
    data['profileImage'] = this.profileImage;

    return data;
  }
}

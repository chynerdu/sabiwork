import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabiwork/models/userModel.dart';
import 'package:sabiwork/services/getStates.dart';

class ProfileImage extends StatelessWidget {
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());

    return Obx(() {
      if (c.userData.value.profileImage != null) {
        return Container(
          // radius: 50,

          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${c.userData.value.profileImage}'))),
        );
      } else {
        return Container(
          // radius: 50,

          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: c.userData.value.gender == 'male'
                      ? AssetImage('assets/images/male.jpg')
                      : AssetImage('assets/images/female.jpg'))),
        );
      }
    });
  }
}

class ProfileImageSAvatar extends StatelessWidget {
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());

    return Obx(() {
      if (c.userData.value.profileImage != null) {
        return CircleAvatar(
          backgroundImage: NetworkImage('${c.userData.value.profileImage}'),
        );
      } else {
        return CircleAvatar(
          backgroundImage: c.userData.value.gender == 'male'
              ? AssetImage('assets/images/male.jpg')
              : AssetImage('assets/images/female.jpg'),
        );
      }
    });
  }
}

class UsersProfileImageSAvatar extends StatelessWidget {
  UserModel? user;
  UsersProfileImageSAvatar({this.user});
  Widget build(BuildContext context) {
    if (user!.profileImage != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage('${user!.profileImage}'),
      );
    } else {
      return CircleAvatar(
        backgroundImage: user!.gender == 'male'
            ? AssetImage('assets/images/male.jpg')
            : AssetImage('assets/images/female.jpg'),
      );
    }
  }
}

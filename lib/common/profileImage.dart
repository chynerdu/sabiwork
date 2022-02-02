import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/models/userModel.dart';
import 'package:sabiwork/services/getStates.dart';

class ProfileImage extends StatelessWidget {
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());

    return Obx(() {
      if (c.userData.value.profileImage != null) {
        return Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: CustomColors.PrimaryColor,
            ),
            child: Center(
                child: Container(
              // radius: 50,

              width: 43,
              height: 43,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${c.userData.value.profileImage}'))),
            )));
      } else {
        return Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: CustomColors.PrimaryColor,
            ),
            child: Container(
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
            ));
      }
    });
  }
}

class ProfileImageBig extends StatelessWidget {
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());

    return Obx(() {
      if (c.userData.value.profileImage != null) {
        return Container(
            width: 105,
            height: 105,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: CustomColors.PrimaryColor,
            ),
            child: Center(
                child: Container(
              // radius: 50,

              width: 103,
              height: 103,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${c.userData.value.profileImage}'))),
            )));
      } else {
        return Container(
            width: 105,
            height: 105,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: CustomColors.PrimaryColor,
            ),
            child: Container(
              // radius: 50,

              width: 103,
              height: 103,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: c.userData.value.gender == 'male'
                          ? AssetImage('assets/images/male.jpg')
                          : AssetImage('assets/images/female.jpg'))),
            ));
      }
    });
  }
}

class ProfileImageSAvatar extends StatelessWidget {
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());

    return GestureDetector(onTap: () {
      Navigator.pushNamed(context, MyProfileRoute);
    }, child: Obx(() {
      if (c.userData.value.profileImage != null) {
        return MainAvatar2(
            child: CircleAvatar(
          backgroundImage: NetworkImage('${c.userData.value.profileImage}'),
        ));
      } else {
        return MainAvatar2(
            child: CircleAvatar(
          backgroundImage: c.userData.value.gender == 'male'
              ? AssetImage('assets/images/male.jpg')
              : AssetImage('assets/images/female.jpg'),
        ));
      }
    }));
  }
}

class UsersProfileImageSAvatar extends StatelessWidget {
  UserModel? user;
  UsersProfileImageSAvatar({this.user});
  Widget build(BuildContext context) {
    if (user!.profileImage != null) {
      return MainAvatar2(
          child: CircleAvatar(
        backgroundImage: NetworkImage('${user!.profileImage}'),
      ));
    } else {
      return MainAvatar2(
          child: CircleAvatar(
        backgroundImage: user!.gender == 'male'
            ? AssetImage('assets/images/male.jpg')
            : AssetImage('assets/images/female.jpg'),
      ));
    }
  }
}

class UsersProfileImageSAvatarx2 extends StatelessWidget {
  UserModel? user;
  UsersProfileImageSAvatarx2({this.user});
  Widget build(BuildContext context) {
    if (user!.profileImage != null) {
      return MainAvatar(
          child: CircleAvatar(
        radius: 45,
        backgroundImage: NetworkImage('${user!.profileImage}'),
      ));
    } else {
      return MainAvatar(
          child: CircleAvatar(
        backgroundImage: user!.gender == 'male'
            ? AssetImage('assets/images/male.jpg')
            : AssetImage('assets/images/female.jpg'),
      ));
    }
  }
}

class MainAvatar extends StatelessWidget {
  final Widget child;
  MainAvatar({required this.child});
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 46, backgroundColor: CustomColors.PrimaryColor, child: child);
  }
}

class MainAvatar2 extends StatelessWidget {
  final Widget child;
  MainAvatar2({required this.child});
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 21, backgroundColor: CustomColors.PrimaryColor, child: child);
  }
}

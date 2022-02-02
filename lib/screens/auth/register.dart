import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';

import 'package:get/get.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/inputText.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/signupModel.dart';
import 'package:sabiwork/screens/auth/complete-registration.dart';
import 'package:sabiwork/services/auth_service.dart';
import 'package:sabiwork/services/getStates.dart';

class Register extends StatefulWidget {
  final String? userType;
  Register({this.userType});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  final AuthService authService = AuthService();
  final SignupModel signupModel = SignupModel();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  bool obscurePassword = true;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dispose() {
    Controller c = Get.put(Controller());
    c.updateGender(0);
    super.dispose();
  }

  submit(context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      if (signupModel.gender == null) {
        customFlushBar.showErrorFlushBar(
            title: 'Required field',
            body: 'Please select gender',
            context: context);
        return;
      }
      _formKey.currentState!.save();
      signupModel.role = widget.userType;
      final result = await authService.signUp(signupModel);
      print('result $result');
      Get.to((CompleteRegistration()));
      // Navigator.pushNamed(context, CompleteRegistrationRoute);

      // Get.to(Tabs());
    } catch (e) {
      // show flushbar
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    setState(() {});
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  // Widget genderSelection() {
  //   return GenderSelection(
  //     maleText: "Male", //default Male
  //     femaleText: "Female", //default Female
  //     linearGradient: LinearGradient(
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //         colors: [Color(0xfff08024), Color(0xffebb78d)]),
  //     selectedGenderIconBackgroundColor:
  //         CustomColors.PrimaryColor, // default red
  //     checkIconAlignment: Alignment.centerRight, // default bottomRight
  //     // selectedGenderCheckIcon: null, // default Icons.check
  //     onChanged: (Gender gender) {
  //       if (gender == Gender.Male) {
  //         signupModel.gender = "male";
  //       } else
  //         signupModel.gender = "female";

  //       print(gender);
  //     },
  //     equallyAligned: true,
  //     animationDuration: Duration(milliseconds: 400),
  //     isCircular: true, // default : true,
  //     isSelectedGenderIconCircular: true,
  //     opacityOfGradient: 0.6,
  //     padding: const EdgeInsets.all(3),
  //     size: 50, //default : 120
  //   );
  // }

  Widget build(BuildContext context) {
    print('arguement ${widget.userType}');
    return SafeArea(
        child: Scaffold(
            key: _scaffoldkey,
            body: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 89),
                            SvgPicture.asset('assets/SabiWork.svg'),
                            SizedBox(height: 66),
                            Text(
                                widget.userType == 'client'
                                    ? 'Create an account to post Jobs, drop am as e dey hot!!😎'
                                    : 'Create an account to apply to open jobs.😏',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            SizedBox(height: 66),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GenderSelectionContainer(
                                  signupModel: signupModel),
                            ),
                            SizedBox(height: 25),
                            Input(
                              hintText: 'John',
                              labelText: 'Enter first name',
                              validator: (String? value) {
                                if (value == '')
                                  return 'First name cannot be empty';
                              },
                              onSaved: (String? value) {
                                signupModel.firstName = value;
                              },
                            ),
                            SizedBox(height: 18),
                            Input(
                              hintText: 'Doe',
                              labelText: 'Enter last name',
                              validator: (String? value) {
                                if (value == '')
                                  return 'Last name cannot be empty';
                              },
                              onSaved: (String? value) {
                                signupModel.lastName = value;
                              },
                            ),
                            SizedBox(height: 18),
                            Input(
                              keyboard: KeyboardType.EMAIL,
                              hintText: 'johndoe@mail.com',
                              labelText: 'Enter email address',
                              validator: (String? value) {
                                if (value == '') return 'Email cannot be empty';
                              },
                              onSaved: (String? value) {
                                signupModel.email = value;
                              },
                            ),
                            SizedBox(height: 18),
                            Input(
                              obscureText: obscurePassword,
                              hintText: 'Password',
                              labelText: 'Enter your password',
                              validator: (String? value) {
                                if (value == '')
                                  return 'Password cannot be empty';
                                else if (value!.length < 5)
                                  return 'Password must be 6 characters or more';
                              },
                              onSaved: (String? value) {
                                signupModel.password = value;
                              },
                              prefix: Icon(
                                Icons.lock,
                                color: CustomColors.PrimaryColor,
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    toggleObscurePassword();
                                    rebuildAllChildren(context);
                                  },
                                  child: Icon(
                                      obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: CustomColors.PrimaryColor)),
                            ),
                            SizedBox(height: 10),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    'Password must be more than 5 characters',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: CustomColors.PrimaryColor,
                                        fontWeight: FontWeight.w500))),
                            SizedBox(height: 60),
                            SWbutton(
                              title: 'Create account',
                              onPressed: () {
                                // print(signupModel.gender);
                                submit(context);
                              },
                            ),
                            SizedBox(height: 13),
                            Align(
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: 'By signing up, you agree to our',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' Terms & Conditons',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // navigate to desired screen
                                            }),
                                      TextSpan(
                                        text: ' and',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10),
                                      ),
                                      TextSpan(
                                          text: ' Privacy Policy',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // navigate to desired screen
                                            }),
                                    ]),
                              ),
                            ),
                            SizedBox(height: 68),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already a member?',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(width: 5),
                                InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, LoginRoute),
                                    child: Text('Sign In',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: CustomColors.PrimaryColor,
                                            fontWeight: FontWeight.w700)))
                              ],
                            ),
                            SizedBox(height: 40),
                          ],
                        ))))));
  }
}

class GenderSelectionContainer extends StatelessWidget {
  final SignupModel signupModel;

  GenderSelectionContainer({required this.signupModel});
  int activeGender = 1;
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    return Obx(() => FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      signupModel.gender = "male";
                      c.updateGender(1);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(
                                  top: 0, bottom: 0, right: 5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/icons/male.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: AnimatedOpacity(
                                opacity: c.activeGender.value == 1 ? 0.6 : 0.0,
                                duration: const Duration(milliseconds: 500),
                                child: c.activeGender.value == 1
                                    ? Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(0xfff08024),
                                                  Color(0xffebb78d)
                                                ],
                                                tileMode: TileMode.clamp,
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                stops: [0.0, 1.0]),
                                            shape: BoxShape.circle),
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        Text('Male',
                            style: c.activeGender.value == 1
                                ? TextStyle(
                                    fontSize: 19,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600,
                                  )
                                : const TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ))
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      signupModel.gender = "female";
                      c.updateGender(2);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(
                                  top: 0, bottom: 0, right: 5.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/icons/female.png"),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover)),
                              child: AnimatedOpacity(
                                opacity: c.activeGender.value == 2 ? 0.6 : 0.0,
                                duration: const Duration(milliseconds: 500),
                                child: c.activeGender.value == 2
                                    ? Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(0xfff08024),
                                                  Color(0xffebb78d)
                                                ],
                                                tileMode: TileMode.clamp,
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                stops: [0.0, 1.0]),
                                            shape: BoxShape.circle),
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        Text('Female',
                            style: c.activeGender.value == 2
                                ? TextStyle(
                                    fontSize: 19,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600,
                                  )
                                : const TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));

    // Center(
    //     child: GenderPickerWithImage(
    //   // showOtherGender: true,
    //   verticalAlignedText: false,
    //   selectedGender: Gender.Male,
    //   linearGradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [Color(0xfff08024), Color(0xffebb78d)]),
    //   // default red
    //   selectedGenderTextStyle: TextStyle(
    //       color: CustomColors.PrimaryColor, fontWeight: FontWeight.bold),
    //   unSelectedGenderTextStyle:
    //       TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
    //   onChanged: (Gender? gender) {
    //     if (gender == Gender.Male) {
    //       signupModel.gender = "male";
    //     } else
    //       signupModel.gender = "female";

    //     print(gender);
    //   },
    //   equallyAligned: true,
    //   animationDuration: Duration(milliseconds: 300),
    //   isCircular: true,
    //   // default : true,
    //   opacityOfGradient: 0.4,
    //   padding: const EdgeInsets.all(3),
    //   size: 50, //default : 40
    // ));
  }
}

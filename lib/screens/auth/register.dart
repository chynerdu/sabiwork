import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:get/get.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/inputText.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/signupModel.dart';
import 'package:sabiwork/screens/auth/complete-registration.dart';
import 'package:sabiwork/services/auth_service.dart';

class Register extends StatefulWidget {
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  submit(context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      signupModel.role = "service-provider"; //TODO: Remove later
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

  Widget genderSelection() {
    return GenderSelection(
      maleText: "Male", //default Male
      femaleText: "Female", //default Female
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xfff08024), Color(0xffebb78d)]),
      selectedGenderIconBackgroundColor:
          CustomColors.PrimaryColor, // default red
      checkIconAlignment: Alignment.centerRight, // default bottomRight
      // selectedGenderCheckIcon: null, // default Icons.check
      onChanged: (Gender gender) {
        if (gender == Gender.Male) {
          signupModel.gender = "male";
        } else
          signupModel.gender = "female";

        print(gender);
      },
      equallyAligned: true,
      animationDuration: Duration(milliseconds: 400),
      isCircular: true, // default : true,
      isSelectedGenderIconCircular: true,
      opacityOfGradient: 0.6,
      padding: const EdgeInsets.all(3),
      size: 50, //default : 120
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                        Text('Create An Account To Apply For Jobs',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        SizedBox(height: 66),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: genderSelection(),
                        ),
                        SizedBox(height: 18),
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
                            if (value == '') return 'Last name cannot be empty';
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
                              return 'Password must 6 characters or more';
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
                            submit(context);
                          },
                        ),
                        SizedBox(height: 13),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: 'By signing up, you aggree to our',
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
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                            SizedBox(width: 5),
                            InkWell(
                                onTap: () =>
                                    Navigator.pushNamed(context, LoginRoute),
                                child: Text('Sign In',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.PrimaryColor,
                                        fontWeight: FontWeight.w700)))
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    )))));
  }
}

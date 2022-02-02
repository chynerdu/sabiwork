import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/inputText.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/signinModel.dart';
import 'package:sabiwork/screens/auth/forgot-password.dart';
import 'package:sabiwork/screens/home/tabs.dart';
import 'package:get/get.dart';
import 'package:sabiwork/services/auth_service.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final AuthService authService = AuthService();
  final SigninModel signinModel = SigninModel();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  bool obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  submit(context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      final result = await authService.signIn(signinModel);
      print('result $result');
      Get.to(Tabs());
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

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 89),
                        SvgPicture.asset('assets/SabiWork.svg'),
                        SizedBox(height: 66),
                        Text('Login To Your Account.',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        SizedBox(height: 66),
                        Input(
                          hintText: 'Email Address',
                          prefix: Icon(Icons.email,
                              color: CustomColors.PrimaryColor),
                          validator: (String? value) {
                            if (value == '') return 'Email cannot be empty';
                          },
                          onSaved: (String? value) {
                            signinModel.email = value;
                          },
                        ),
                        SizedBox(height: 39),
                        Input(
                          hintText: 'Password',
                          obscureText: obscurePassword,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                toggleObscurePassword();
                                rebuildAllChildren(context);
                              },
                              child: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white)),
                          validator: (String? value) {
                            if (value == '')
                              return 'Password cannot be empty';
                            else if (value!.length < 5)
                              return 'Password must 6 characters or more';
                          },
                          onSaved: (String? value) {
                            signinModel.password = value;
                          },
                          prefix: Icon(
                            Icons.lock,
                            color: CustomColors.PrimaryColor,
                          ),
                          // suffixIcon: Icon(Icons.visibility_off)
                        ),
                        SizedBox(height: 10.5),
                        GestureDetector(
                            onTap: () => Get.to(ForgotPassword()),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('Forgot password?',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.PrimaryColor,
                                        fontWeight: FontWeight.w500)))),
                        SizedBox(height: 92.65),
                        SWbutton(
                          title: 'Login',
                          onPressed: () {
                            submit(context);
                            // Get.to(Tabs());
                            // Get.to(JobDetails());
                          },
                        ),
                        SizedBox(height: 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don’t have an account?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                            SizedBox(width: 5),
                            InkWell(
                                onTap: () =>
                                    // Get.to((CompleteRegistration())),
                                    Navigator.pushNamed(context, UserTypesRoute),
                                child: Text('Sign Up',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.PrimaryColor,
                                        fontWeight: FontWeight.w700)))
                          ],
                        )
                      ],
                    )))));
  }
}

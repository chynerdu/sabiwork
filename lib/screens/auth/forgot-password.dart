import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/inputText.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/signinModel.dart';
import 'package:sabiwork/screens/auth/complete-registration.dart';
import 'package:sabiwork/screens/home/tabs.dart';
import 'package:sabiwork/screens/serviceProvider/job-details.dart';
import 'package:get/get.dart';
import 'package:sabiwork/services/auth_service.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
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
                        Text('Forgot Password',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        SizedBox(height: 5),
                        Text(
                            'A link will be sent to your email to reset your password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
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
                        SizedBox(height: 92.65),
                        SWbutton(
                          title: 'Continue',
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
                                    Navigator.pushNamed(context, RegisterRoute),
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

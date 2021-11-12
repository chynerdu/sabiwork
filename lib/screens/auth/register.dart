import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/inputText.dart';
import 'package:sabiwork/helpers/customColors.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                    Input(
                      hintText: 'John',
                      labelText: 'Enter first name',
                      validator: (String? value) {
                        // if (value == '')
                        //   return 'Password cannot be empty';
                        // else if (value!.length < 5)
                        //   return 'Password must 6 characters or more';
                      },
                      onSaved: (String? value) {
                        // signinModel.password = value;
                      },
                    ),
                    SizedBox(height: 39),
                    Input(
                      hintText: 'Doe',
                      labelText: 'Enter last name',
                      validator: (String? value) {
                        // if (value == '')
                        //   return 'Password cannot be empty';
                        // else if (value!.length < 5)
                        //   return 'Password must 6 characters or more';
                      },
                      onSaved: (String? value) {
                        // signinModel.password = value;
                      },
                    ),
                    SizedBox(height: 39),
                    Input(
                      hintText: 'johndoe@mail.com',
                      labelText: 'Enter email address',
                      validator: (String? value) {
                        // if (value == '')
                        //   return 'Password cannot be empty';
                        // else if (value!.length < 5)
                        //   return 'Password must 6 characters or more';
                      },
                      onSaved: (String? value) {
                        // signinModel.password = value;
                      },
                    ),
                    SizedBox(height: 39),
                    Input(
                        hintText: 'Password',
                        labelText: 'Enter your password',
                        validator: (String? value) {
                          // if (value == '')
                          //   return 'Password cannot be empty';
                          // else if (value!.length < 5)
                          //   return 'Password must 6 characters or more';
                        },
                        onSaved: (String? value) {
                          // signinModel.password = value;
                        },
                        prefix: Icon(
                          Icons.lock,
                          color: CustomColors.PrimaryColor,
                        ),
                        suffixIcon: Icon(Icons.visibility_off)),
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text('Password must be more than 5 characters',
                            style: TextStyle(
                                fontSize: 11,
                                color: CustomColors.PrimaryColor,
                                fontWeight: FontWeight.w500))),
                    SizedBox(height: 92.65),
                    SWbutton(
                      title: 'Create account',
                      onPressed: () {
                        Navigator.pushNamed(context, CompleteRegistrationRoute);
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
                ))));
  }
}

import 'package:flutter/material.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/inputText.dart';
import 'package:sabiwork/helpers/customColors.dart';

class CompleteRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return CompleteRegistrationState();
  }
}

class CompleteRegistrationState extends State<CompleteRegistration> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [TextButton(onPressed: () {}, child: Text('Skip for now'))],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 39),
                    Text('Hi Chichi,',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500)),
                    Text('complete your profile info',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500)),
                    SizedBox(height: 30),
                    Input(
                      hintText: 'Gender',
                      labelText: 'Male',
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
                      hintText: 'Enter phone number',
                      labelText: '08098765565',
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
                        hintText: 'State of residence',
                        labelText: 'Lagos',
                        validator: (String? value) {
                          // if (value == '')
                          //   return 'Password cannot be empty';
                          // else if (value!.length < 5)
                          //   return 'Password must 6 characters or more';
                        },
                        onSaved: (String? value) {
                          // signinModel.password = value;
                        },
                        suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    SizedBox(height: 39),
                    Input(
                        hintText: 'Area',
                        labelText: 'Surulere',
                        validator: (String? value) {
                          // if (value == '')
                          //   return 'Password cannot be empty';
                          // else if (value!.length < 5)
                          //   return 'Password must 6 characters or more';
                        },
                        onSaved: (String? value) {
                          // signinModel.password = value;
                        },
                        suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    SizedBox(height: 10),
                    Input(
                        hintText: 'Enter your NIN',
                        validator: (String? value) {
                          // if (value == '')
                          //   return 'Password cannot be empty';
                          // else if (value!.length < 5)
                          //   return 'Password must 6 characters or more';
                        },
                        onSaved: (String? value) {
                          // signinModel.password = value;
                        },
                        suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text('Why do we need your NIN?',
                            style: TextStyle(
                                fontSize: 11,
                                color: CustomColors.PrimaryColor,
                                fontWeight: FontWeight.w500))),
                    SizedBox(height: 92.65),
                    SWbutton(
                      title: 'Next',
                      onPressed: () {},
                    ),
                    SizedBox(height: 13),
                    SizedBox(height: 40),
                  ],
                ))));
  }
}

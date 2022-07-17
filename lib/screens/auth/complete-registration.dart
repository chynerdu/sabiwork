import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/inputText.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/otherInfoModel.dart';
import 'package:sabiwork/models/signupModel.dart';
import 'package:sabiwork/screens/home/tabs.dart';
import 'package:sabiwork/services/api_path.dart';
import 'package:sabiwork/services/auth_service.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:dio/dio.dart' hide MultipartFile;
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart' hide Response;

// import 'package:http/http.dart' as http;

class CompleteRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return CompleteRegistrationState();
  }
}

class CompleteRegistrationState extends State<CompleteRegistration> {
  final AuthService authService = AuthService();
  final OtherInfoModel otherInfoModel = OtherInfoModel();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  TextEditingController stateController = TextEditingController();
  TextEditingController lgaController = TextEditingController();
  bool isLoading = false;
  List stateList = [];
  List lgaList = [];
  File? imageFile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  fetchStates() async {
    try {
      var states = await authService.fetchStates();
      setState(() {
        stateList = states['result']['data'];
      });
    } catch (e) {
      print(e);
    }
  }

  fetchLGA(id) async {
    try {
      lgaList = [];
      var lga = await authService.fetchLGA(id);
      setState(() {
        lgaList = lga['data'];
      });
    } catch (e) {
      print(e);
    }
  }

  submit1(context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      var byteData = imageFile!.readAsBytesSync();

      // var multipartFile =
      //     await http.MultipartFile.fromPath('profileImage', imageFile!.path

      // byteData,
      // filename: 'profileImage-${DateTime.now().second}.jpg',
      // contentType: MediaType("file", "jpg"),
      // );
      // otherInfoModel.profileImage = multipartFile;

      final result = await authService.upateAccount(otherInfoModel);
      print('result $result');

      // Navigator.pushNamed(context, CompleteRegistrationRoute);

      Get.to(Tabs());
    } catch (e) {
      // show flushbar
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  submit(context) async {
    Controller c = Get.put(Controller());
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      c.change(true);
      var token = await localStorage.getData(name: 'token');

      // get file length
      var length = await imageFile!.length(); //imageFile is your image file
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      }; // ignore this headers if there is no authentication

      // string to uri
      var uri = Uri.parse('${APIPath.updateAccount()}/${c.userData.value.id}');

      // create multipart request
      var request = new http.MultipartRequest("PUT", uri);
      print('uri $uri');
      var byteData = imageFile!.readAsBytesSync();

      // var multipartFile = http.MultipartFile.fromBytes(
      //   'profileImage',
      //   byteData,
      //   filename: 'profileImage-${DateTime.now().second}.jpg',
      //   contentType: MediaType("file", "jpg"),
      // );

      var multipartFile = await http.MultipartFile.fromPath(
        'profileImage',
        imageFile!.path,
        contentType: MediaType("image", "jpg"),
      );

      // add file to multipart
      // request.files.add(multipartFileSign);
      // request.files.add(await http.MultipartFile.fromPath(
      //   'profileImage',
      //   imageFile!.readAsBytesSync(),
      //   contentType: new MediaType('application', 'x-tar'),
      // ));
      //add headers
      request.headers.addAll(headers);
      request.files.add(multipartFile);
      //adding params
      request.fields['phone'] = '${otherInfoModel.phone}';
      request.fields['state'] = '${otherInfoModel.state}';
      request.fields['lga'] = '${otherInfoModel.lga}';
      request.fields['vIdentity'] = '${otherInfoModel.vIdentity}';
      request.fields['address'] = '${otherInfoModel.address}';

      // send
      var response = await request.send();

      print(response.statusCode);
      // listen for response
      var stringResponse = await response.stream.toBytes();
      var responseString = String.fromCharCodes(stringResponse);
      print(responseString);
      c.change(false);

      if (response.statusCode == 201 || response.statusCode == 200) {
        await authService.fetchProfile();
        Get.to(Tabs());
      } else {
        customFlushBar.showErrorFlushBar(
            title: 'Error occured', body: '$responseString', context: context);
        return;
      }
    } catch (e) {
      print('error $e');
      c.change(false);
    }
  }

  submit2(context) async {
    Controller c = Get.put(Controller());
    try {
      c.change(true);
      var token = await localStorage.getData(name: 'token');

      Dio dio = new Dio(BaseOptions(
        headers: {"authorization": token},
      ));
      dio.options.contentType = 'application/json';
      // dio.options.headers['contentType'] = "application/x-www-form-urlencoded";
      // dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers["authorization"] = "token $token";
      FormData formData = new FormData.fromMap({
        // "profileImage":
        //     // UploadFileInfo(imageFile, basename(imageFile!.path)),
        //     await MultipartFile.fromFile('${imageFile?.path}',
        //         filename: imageFile?.path.split('/').last ?? 'image.jpeg',
        //         contentType: new MediaType("image", "jpeg")),
        "phone": '${otherInfoModel.phone}',
        "state": '${otherInfoModel.state}',
        "lga": '${otherInfoModel.lga}',
        "vIdentity": '${otherInfoModel.vIdentity}',
        "address": '${otherInfoModel.address}'
      }); // just like JS
      // formData.add("inimageFile",
      //     new UploadFileInfo(imageFile, basename(imageFile!.path)));
      // formData.add("phone", '${otherInfoModel.phone}');
      // formData.add("state", '${otherInfoModel.state}');
      // formData.add("lga", '${otherInfoModel.lga}');
      // formData.add("vIdentity", '${otherInfoModel.vIdentity}');
      // formData.add("address", '${otherInfoModel.address}');
      print('here');
      var response = await dio.put(
        '${APIPath.updateAccount()}/${c.userData.value.id}',
        data: formData,
        // options: Options(
        //     // method: 'PUT',
        //     responseType: ResponseType.json // or ResponseType.JSON
        //     )
      );
      print(response);

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");
      c.change(false);
      if (response.statusCode != 201) {
        customFlushBar.showErrorFlushBar(
            title: 'Error occured', body: '${response.data}', context: context);
        return;
      }

      Get.to(Tabs());

      // dio.post('${APIPath.updateAccount()}/${c.userData.value.id}', data: formData, options: Options(
      //     method: 'POST',
      //     responseType: ResponseType.json // or ResponseType.JSON
      // ))
      //     .then((r) {
      //   setState(() {
      //     var data = json.decode(r.toString());
      //     if(data["apiMessage"].contains('Saved')){
      //       warningAlert("Attendance Saved", "Your attendance saved Successfully",context);
      //     }
      //   });
      // }).catchError(print);

    } catch (e) {
      print('error $e');
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
      c.change(false);
    }
  }

  initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchStates();
    });
    super.initState();
  }

  _displayDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Container(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Text('Select states',
                        style: TextStyle(color: Colors.black)),
                    actions: [
                      GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: Colors.black)),
                      SizedBox(width: 10),
                    ],
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: ListView.builder(
                        itemCount: stateList.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  stateController.text =
                                      stateList[index]['state_label'];

                                  // signupModel.countryId =
                                  //     countries[index]['id'];
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).pop();
                                  fetchLGA(stateList[index]['state_id']);
                                });
                              },
                              child: Text(
                                '${stateList[index]['state_label']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    height: 2),
                              ));
                        },
                      ),
                    ),
                  ))),
        );
      },
    );
  }

  _displayLGADialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Container(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Text(
                        'Select Local Government in ${stateController.text}',
                        style: TextStyle(color: Colors.black)),
                    actions: [
                      GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: Colors.black)),
                      SizedBox(width: 10),
                    ],
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: ListView.builder(
                        itemCount: lgaList.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  lgaController.text =
                                      lgaList[index]['lga_label'];
                                  // signupModel.countryId =
                                  //     countries[index]['id'];
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).pop();
                                });
                              },
                              child: Text(
                                '${lgaList[index]['lga_label']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    height: 2),
                              ));
                        },
                      ),
                    ),
                  ))),
        );
      },
    );
  }

  /// Get from gallery
  _getFromGallery(context) async {
    Navigator.pop(context);
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
      // imageFile = File(pickedFile.path);

      // setState(() {
      //   imageFile = File(pickedFile.path);
      //   print('selected $imageFile');

      // });
    }
  }

  /// Crop Image
  _cropImage(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
        print('selected $imageFile');
      });
    }
  }

  /// Get from camera
  _getFromCamera(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: CustomColors.PrimaryColor),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: CustomColors.PrimaryColor,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromGallery(context);
                    },
                    title: Text("Upload From Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: CustomColors.PrimaryColor,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: CustomColors.PrimaryColor,
                  ),
                  ListTile(
                    onTap: () {
                      _getFromCamera(context);
                    },
                    title: Text("Use Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: CustomColors.PrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());

    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            leading: Container(),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              TextButton(
                  onPressed: () {
                    Get.to(Tabs());
                  },
                  child: Text('Skip for now'))
            ],
          ),
          body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 39),
                          Text('Hi ${c.userData.value.firstName},',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500)),
                          Text('complete your profile info',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500)),
                          SizedBox(height: 30),
                          // Input(
                          //   hintText: 'Gender',
                          //   labelText: 'Male',
                          //   validator: (String? value) {
                          //     // if (value == '')
                          //     //   return 'Password cannot be empty';
                          //     // else if (value!.length < 5)
                          //     //   return 'Password must 6 characters or more';
                          //   },
                          //   onSaved: (String? value) {
                          //     // signinModel.password = value;
                          //   },
                          // ),
                          // SizedBox(height: 39),
                          GestureDetector(
                              onTap: () => _showChoiceDialog(context),
                              child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: CustomColors.PrimaryColor,
                                  child: imageFile == null
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 53,
                                          child: Image.asset(
                                              'assets/images/upload.png',
                                              width: 80,
                                              height: 80),
                                          // backgroundImage:
                                          //     AssetImage('assets/images/upload.png' ),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 53,
                                          backgroundImage:
                                              FileImage(imageFile!),
                                        ))),
                          SizedBox(height: 18),
                          Input(
                            labelText: 'Enter phone number',
                            keyboard: KeyboardType.PHONE,
                            hintText: '08098765565',
                            validator: (String? value) {
                              if (value == '')
                                return 'Phone numbercannot be empty';
                              else if (value!.length < 11)
                                return 'Phone number must 11 characters or more';
                            },
                            onSaved: (String? value) {
                              otherInfoModel.phone = value;
                            },
                          ),
                          SizedBox(height: 18),
                          Input(
                              onTap: () => _displayDialog(context),
                              // enabled: false,
                              readOnly: true,
                              controller: stateController,
                              hintText: 'State of residence',
                              labelText: 'State',
                              validator: (String? value) {
                                if (stateController.text == '')
                                  return 'Please select state';
                              },
                              onSaved: (String? value) {
                                otherInfoModel.state = stateController.text;
                              },
                              suffixIcon: Icon(Icons.keyboard_arrow_down)),
                          SizedBox(height: 18),

                          Input(
                              onTap: () => _displayLGADialog(context),
                              enabled:
                                  stateController.text != '' ? true : false,
                              readOnly: true,
                              hintText: 'Area',
                              labelText: 'LGA',
                              controller: lgaController,
                              validator: (String? value) {
                                if (lgaController.text == '')
                                  return 'Please select Local Government';
                              },
                              onSaved: (String? value) {
                                otherInfoModel.lga = lgaController.text;
                              },
                              suffixIcon: Icon(Icons.keyboard_arrow_down)),

                          SizedBox(height: 18),
                          Input(
                            labelText: 'Enter address',
                            hintText: 'No:, street, area, state',
                            validator: (String? value) {
                              if (value == '') return 'address cannot be empty';
                            },
                            onSaved: (String? value) {
                              otherInfoModel.address = value;
                            },
                          ),
                          SizedBox(height: 18),
                          Input(
                              hintText: 'Enter your NIN',
                              validator: (String? value) {
                                if (value == '') return 'NIN cannot be empty';
                              },
                              onSaved: (String? value) {
                                otherInfoModel.vIdentity = value;
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
                            onPressed: () {
                              submit(context);
                            },
                          ),
                          SizedBox(height: 13),
                          SizedBox(height: 40),
                        ],
                      )))));
    });
  }
}

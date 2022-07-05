import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http_parser/http_parser.dart';
// import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/inputText.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/addJobModel.dart';
import 'package:sabiwork/models/applyJobModel.dart';
import 'package:sabiwork/screens/home/tabs.dart';
import 'package:sabiwork/services/api_path.dart';
import 'package:sabiwork/services/auth_service.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/job_service.dart';
import 'package:sabiwork/helpers/stringHelpers.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http/http.dart' as http;

class AddJob extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddJobState();
  }
}

class AddJobState extends State<AddJob> {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  final JobService jobService = JobService();
  int tabIndex = 0;

  final ApplyJobModel applyJobModel = ApplyJobModel();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  bool obscurePassword = true;
  Controller c = Get.put(Controller());
  final AuthService authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController stateController = TextEditingController();
  TextEditingController lgaController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  AddjobModel addjobModel = AddjobModel();
  bool isLoading = false;
  List stateList = [];
  List lgaList = [];
  List<XFile>? _imageFileList = [];
  bool usStateInProfile = false;

  List categoryList = [
    {"label": "Indoor"},
    {"label": "Outdoor"},
    {"label": "Mix"},
  ];

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

  initState() {
    super.initState();
    usStateInProfile = false;
    fetchStates();
  }

  /// Get from gallery
  _getFromGallery(context) async {
    Navigator.pop(context);
    final pickedFileList = await _picker.pickMultiImage(
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFileList != null) {
      setState(() {
        for (var image in pickedFileList) _imageFileList!.add(image);

        print('image length ${_imageFileList!.length}');
      });
      print('image $_imageFileList');
      print('image length ${_imageFileList!.length}');
    }
  }

  /// Get from camera
  _getFromCamera(context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFileList!.add(pickedFile);
      });
    }
    Navigator.pop(context);
  }

  submit(context) async {
    FocusScope.of(context).unfocus();
    Controller c = Get.put(Controller());

    List<http.MultipartFile> newList = [];

    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      c.change(true);
      var token = await localStorage.getData(name: 'token');

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      }; // ignore this headers if there is no authentication

      // string to uri
      var uri = Uri.parse('${APIPath.addJob()}');

      // create multipart request
      var request = new http.MultipartRequest("POST", uri);
      print('uri $uri');

      for (var img in _imageFileList!) {
        if (img.path != '') {
          var multipartFiles = await http.MultipartFile.fromPath(
            'job_images',
            img.path,
            contentType: MediaType("image", "jpg"),
          );
          newList.add(multipartFiles);
        }
      }

      //add headers
      request.headers.addAll(headers);
      request.files.addAll(newList);
      //adding params
      request.fields['job_type'] = '${addjobModel.category}';
      request.fields['state'] = '${addjobModel.state}';
      request.fields['lga'] = '${addjobModel.lga}';
      request.fields['address'] = '${addjobModel.address}';
      request.fields['description'] = '${addjobModel.description}';
      request.fields['price_per_worker'] = '${addjobModel.pricePerWorker}';
      request.fields['number_of_workers'] = '${addjobModel.numberOfWorkers}';
      request.fields['additionalDetails'] = '${addjobModel.additionalDetails}';

      // send
      var response = await request.send();

      print(response.statusCode);
      // listen for response
      var stringResponse = await response.stream.toBytes();
      var responseString = String.fromCharCodes(stringResponse);
      print(responseString);
      c.change(false);

      if (response.statusCode == 201 || response.statusCode == 200) {
        customFlushBar.showSuccessFlushBar(
            title: 'Job Posted',
            body: 'Your job has been posted',
            context: context);
        setState(() {
          addjobModel = AddjobModel();
        });
        await jobService.fetchMyJobs();
        onItemTap();
        // Navigator.pop(context);
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

                                  addjobModel.state =
                                      stateList[index]['state_label'];
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

  _displayCategoryDialog(BuildContext context) {
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
                    title: Text('Select Job Category',
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
                        itemCount: categoryList.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  categoryController.text =
                                      categoryList[index]['label'];

                                  addjobModel.category =
                                      categoryList[index]['label'];

                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).pop();
                                });
                              },
                              child: Text(
                                '${categoryList[index]['label']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
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
                                  addjobModel.lga = lgaList[index]['lga_label'];
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

  void onItemTap() {
    Controller c = Get.put(Controller());
    setState(() {
      // _selectedIndex = index;
      c.updateTab(0);
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          onItemTap();
          return true;
        },
        child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: SafeArea(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(20, 31, 20, 20),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () => onItemTap(),
                                  // Navigator.pop(context),
                                  child: Icon(Icons.arrow_back)),
                              Text('Post a Job',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff555555),
                                      fontSize: 18)),
                              GestureDetector(child: Icon(Icons.more_vert))
                            ],
                          ),
                          SizedBox(height: 49),
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Job Category *',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff4A4A4A))),
                                            SizedBox(height: 6),
                                            Input(
                                              onTap: () =>
                                                  _displayCategoryDialog(
                                                      context),
                                              // enabled: false,
                                              readOnly: true,
                                              controller: categoryController,
                                              hintText: 'select category',
                                              validator: (String? value) {
                                                if (value == '')
                                                  return 'select category';
                                              },
                                              onSaved: (String? value) {},
                                            ),
                                            SizedBox(height: 20),
                                            Text('Title *',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff4A4A4A))),
                                            SizedBox(height: 6),
                                            Input(
                                              hintText:
                                                  'e.g I need someone to clean my house',
                                              validator: (String? value) {
                                                // if (value == '')
                                                //   return 'Enter title';
                                              },
                                              onSaved: (String? value) {
                                                addjobModel.description = value;
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            Text('Description',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff4A4A4A))),
                                            SizedBox(height: 6),
                                            Input(
                                              maxLines: 5,
                                              hintText: 'Describe the job',
                                              validator: (String? value) {
                                                if (value == '')
                                                  return 'Enter title';
                                              },
                                              onSaved: (String? value) {
                                                addjobModel.additionalDetails =
                                                    value;
                                              },
                                            ),
                                            SizedBox(height: 30),
                                            GestureDetector(
                                                onTap: () =>
                                                    _showChoiceDialog(context),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        'Attach photos (Optional)',
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xff4A4A4A))),
                                                    SizedBox(width: 19),
                                                    SvgPicture.asset(
                                                        'assets/icons/photo.svg')
                                                  ],
                                                )),
                                            SizedBox(height: 20),
                                            _imageFileList != null
                                                ? _imageFileList!.length > 0
                                                    ? Container(
                                                        height: 200,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          key: UniqueKey(),
                                                          itemCount:
                                                              _imageFileList!
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  index) {
                                                            return Stack(
                                                                children: [
                                                                  Container(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              5,
                                                                              5,
                                                                              15,
                                                                              5),
                                                                      // radius: 50,

                                                                      child: Semantics(
                                                                          label: 'job_images',
                                                                          child: Container(
                                                                            decoration:
                                                                                BoxDecoration(boxShadow: [
                                                                              BoxShadow(blurRadius: 4.0, spreadRadius: 0.3)
                                                                            ], borderRadius: BorderRadius.circular(3), color: Colors.white),
                                                                            child:
                                                                                Image.file(File(_imageFileList![index].path)),
                                                                          ))),
                                                                  Positioned(
                                                                      right: 3,
                                                                      child: GestureDetector(
                                                                          onTap: () {
                                                                            print('index $index');
                                                                            setState(() {
                                                                              _imageFileList!.removeAt(index);
                                                                            });
                                                                          },
                                                                          child: Icon(Icons.close_outlined, size: 20, color: Colors.red[700]))),
                                                                ]);
                                                          },
                                                        ))
                                                    : Container()
                                                : Container(),
                                            SizedBox(height: 40),
                                            Row(
                                              children: [
                                                Text('State',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xff4A4A4A))),
                                                Text(
                                                    ' or use same location in profile',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: CustomColors
                                                            .PrimaryColor)),
                                                SizedBox(width: 10),
                                                SizedBox(
                                                    height: 22,
                                                    width: 18,
                                                    child: Transform.scale(
                                                        scale: 0.9,
                                                        child: Checkbox(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3)),
                                                          value:
                                                              usStateInProfile,
                                                          activeColor:
                                                              CustomColors
                                                                  .PrimaryColor,
                                                          onChanged:
                                                              (bool? value) {
                                                            print(
                                                                'value $value');
                                                            // This is where we update the state when the checkbox is tapped
                                                            setState(() {
                                                              usStateInProfile =
                                                                  value!;
                                                            });
                                                          },
                                                        ))),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            if (usStateInProfile == false)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Input(
                                                      onTap: () =>
                                                          _displayDialog(
                                                              context),
                                                      // enabled: false,
                                                      readOnly: true,
                                                      controller:
                                                          stateController,
                                                      hintText: 'Select state',
                                                      validator:
                                                          (String? value) {
                                                        if (value == '')
                                                          return 'Select state';
                                                      },
                                                      onSaved:
                                                          (String? value) {},
                                                      suffixIcon: Icon(Icons
                                                          .keyboard_arrow_down)),
                                                  SizedBox(height: 20),
                                                  Text('Local Government *',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Color(
                                                              0xff4A4A4A))),
                                                  SizedBox(height: 6),
                                                  Input(
                                                      onTap: () =>
                                                          _displayLGADialog(
                                                              context),
                                                      enabled:
                                                          stateController
                                                                      .text !=
                                                                  ''
                                                              ? true
                                                              : false,
                                                      readOnly: true,
                                                      controller: lgaController,
                                                      hintText:
                                                          'Select local government',
                                                      validator:
                                                          (String? value) {
                                                        if (value == '')
                                                          return 'Select local government';
                                                      },
                                                      onSaved:
                                                          (String? value) {},
                                                      suffixIcon: Icon(Icons
                                                          .keyboard_arrow_down)),
                                                  SizedBox(height: 20),
                                                ],
                                              ),
                                            Text('Adress *',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff4A4A4A))),
                                            SizedBox(height: 6),
                                            Input(
                                              hintText: 'Enter address',
                                              validator: (String? value) {
                                                if (value == '')
                                                  return 'Enter address';
                                              },
                                              onSaved: (String? value) {
                                                addjobModel.address = value;
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            Text('No of Workers *',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff4A4A4A))),
                                            SizedBox(height: 6),
                                            Input(
                                              keyboard: KeyboardType.NUMBER,
                                              hintText:
                                                  'How many people do you need',
                                              validator: (String? value) {
                                                if (value == '')
                                                  return 'Enter number of workers';
                                              },
                                              onSaved: (String? value) {
                                                addjobModel.numberOfWorkers =
                                                    value;
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            Text('Budget *',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff4A4A4A))),
                                            SizedBox(height: 6),
                                            Input(
                                              keyboard: KeyboardType.NUMBER,
                                              hintText:
                                                  'What is your budget for this job (Per person)',
                                              validator: (String? value) {
                                                if (value == '')
                                                  return 'Enter budget';
                                              },
                                              onSaved: (String? value) {
                                                addjobModel.pricePerWorker =
                                                    value;
                                              },
                                            ),
                                            SizedBox(height: 42),
                                            SWbutton(
                                              title: 'Post Job',
                                              onPressed: () {
                                                submit(context);
                                              },
                                            ),
                                          ]))))
                        ]))))));
  }
}

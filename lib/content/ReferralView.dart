import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:referral_app/cache/cache.dart';
import 'package:referral_app/widget/InputHelper.dart';
import '../providers/model_classes/ReferralRecord.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:email_validator/email_validator.dart';

class ReferralView extends StatefulWidget {
  const ReferralView({super.key});

  @override
  State<ReferralView> createState() => _ReferralViewState();
}

class _ReferralViewState extends State<ReferralView> {
  final _formKey = GlobalKey<FormState>();
  final patientNameController = TextEditingController();
  final patientPhoneController = TextEditingController();
  final patientEmailController = TextEditingController();
  final referringDoctorNameController = TextEditingController();
  final referringDoctorPhoneController = TextEditingController();
  final referringDoctorEmailController = TextEditingController();
  final consultTypes = ReferralRecord.consultTypes;
  late String _consultType = consultTypes[0];
  final commentsController = TextEditingController();

  late Future<String?> cachedDoctorName;
  late Future<String?> cachedDoctorPhone;
  late Future<String?> cachedDoctorEmail;

  //elevated button grey out - waiting for server
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    log('cache retrieval');
    cachedDoctorName = LocalCache.getValue(LocalCache.doctorName);
    cachedDoctorPhone = LocalCache.getValue(LocalCache.doctorPhone);
    cachedDoctorEmail = LocalCache.getValue(LocalCache.doctorEmail);
    log(
      'retrieved \ncachedDoctorName $cachedDoctorName \ncachedDoctorPhone $cachedDoctorPhone \ncachedDoctorEmail $cachedDoctorEmail',
    );
  }

  @override
  void dispose() {
    patientNameController.dispose();
    patientPhoneController.dispose();
    patientEmailController.dispose();
    referringDoctorNameController.dispose();
    referringDoctorPhoneController.dispose();
    referringDoctorEmailController.dispose();
    commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            //for landscape and tablet orientations
            maxWidth: 600,
          ),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(
                        height: 24,
                        width: 28,
                        'assets/svg/Park_Ave_OMS_square.svg',
                        semanticsLabel: 'Park Avenue OMS',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      'Referral Form',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Montserrat-Medium',
                      ),
                    ),
                  ],
                ),
              ),
              formWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Container formWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Patient', style: TextStyle(fontSize: 24)),
            ),
            InputHelper(
              name: "Name",
              controller: patientNameController,
              hintText: 'John Doe',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            InputHelper(
              name: "Phone Number",
              controller: patientPhoneController,
              type: TextInputType.phone,
              hintText: 'XXX-XXX-XXXX',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your number';
                }
                if (!PhoneNumber.parse(
                      value,
                      destinationCountry: IsoCode.US,
                    ).isValid() &&
                    !PhoneNumber.parse(
                      value,
                      destinationCountry: IsoCode.CA,
                    ).isValid()) {
                  return 'Please enter a valid number';
                }
                log('fine correct number');
                return null;
              },
            ),
            InputHelper(
              name: "Email",
              controller: patientEmailController,
              type: TextInputType.emailAddress,
              hintText: 'patient@gmail.com',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Referring Doctor', style: TextStyle(fontSize: 24)),
            ),
            FutureBuilder<String?>(
              future: cachedDoctorName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return InputHelper(
                  name: "Name",
                  controller: referringDoctorNameController,
                  hintText: 'Dr. Doctor',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  initialValue: snapshot.data,
                );
              },
            ),
            FutureBuilder<String?>(
              future: cachedDoctorPhone,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return InputHelper(
                  name: "Phone Number",
                  controller: referringDoctorPhoneController,
                  type: TextInputType.phone,
                  hintText: 'XXX-XXX-XXXX',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your number';
                    }
                    if (!PhoneNumber.parse(
                          value,
                          destinationCountry: IsoCode.US,
                        ).isValid() &&
                        !PhoneNumber.parse(
                          value,
                          destinationCountry: IsoCode.CA,
                        ).isValid()) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  initialValue: snapshot.data,
                );
              },
            ),
            FutureBuilder<String?>(
              future: cachedDoctorName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return InputHelper(
                  name: "Email",
                  controller: referringDoctorEmailController,
                  type: TextInputType.emailAddress,
                  hintText: 'doctor@gmail.com',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  initialValue: snapshot.data,
                );
              },
            ),
            DropdownButtonFormField<String>(
              items: consultTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              initialValue: _consultType,
              onChanged: (value) {
                setState(() {
                  _consultType = value!;
                });
              },
            ),
            InputHelper(
              name: "Comments",
              controller: commentsController,
              validator: (value) {
                return null;
              },
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLoading ? Colors.grey : Colors.black,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey, width: 1),
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Montserrat-Medium',
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => isLoading = true); //disables button
                            //http request made, responses possible: 200, 400, 404

                            /// PRODUCTION DO THIS
                            /// comment out next 2
                            /// uncomments the 2 after
                            int response = 200;
                            await Future.delayed(Duration(seconds: 1));
                            // int response = await submitForm();
                            // log(response.toString());
                            

                            String info = '';
                            if (response == 200) {
                              info = 'Form Submitted!';
                            } else if (response == 400) {
                              info = 'User Error.';
                            } else {
                              info = 'Server Error. Try again.';
                            }

                            // check mounting to prevent runtime error
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(info),
                                  backgroundColor: (response == 200)
                                      ? const Color.fromARGB(255, 71, 71, 71)
                                      : Colors.red, // makes the snackbar red
                                ),
                              );
                            }

                            setState(
                              () => isLoading = false,
                            ); // re-enable button

                            log('santiy1');
                            //success
                            if (response == 200) {
                              log('end response start');
                              //saves referring doctor information
                              await cache();
                              //clears only patient information
                              clearForm();
                            }
                          }
                        },
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> submitForm() async {
    final record = getReferralRecord();
    int response = await serverPOSTrequest(record);
    return response;
  }

  ReferralRecord getReferralRecord() {
    final patientName = patientNameController.text;
    final patientPhone = patientPhoneController.text;
    final patientEmail = patientEmailController.text;
    final referringDoctorName = referringDoctorNameController.text;
    final referringDoctorPhone = referringDoctorPhoneController.text;
    final referringDoctorEmail = referringDoctorEmailController.text;
    // _consultType
    final comments = commentsController.text;

    return ReferralRecord(
      patientName: patientName,
      patientPhone: patientPhone,
      patientEmail: patientEmail,
      referringDoctorName: referringDoctorName,
      referringDoctorPhone: referringDoctorPhone,
      referringDoctorEmail: referringDoctorEmail,
      consultType: _consultType,
      comments: comments,
    );
  }

  Future<int> serverPOSTrequest(ReferralRecord record) async {
    final response = await http.post(
      Uri.parse(ReferralRecord.BACKEND_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(record.toJson()),
    );
    //ok, submitted
    if (response.statusCode == 200) {
      return 200;
      //user error
    } else if (response.statusCode == 400) {
      return 400;
      //unexpected response
    } else {
      //should only be 404 or 500s
      return 404;
    }
  }

  void clearForm() {
    patientNameController.clear();
    patientPhoneController.clear();
    patientEmailController.clear();
    commentsController.clear();
  }

  Future<bool> cache() async {
    log('cache process:');
    ReferralRecord record = getReferralRecord();
    bool set1 = await LocalCache.setValue(
      LocalCache.doctorName,
      record.referringDoctorName,
    );
    bool set2 = await LocalCache.setValue(
      LocalCache.doctorPhone,
      record.referringDoctorPhone,
    );
    bool set3 = await LocalCache.setValue(
      LocalCache.doctorEmail,
      record.referringDoctorEmail,
    );
    log('cache success 1: ${set1} 2: ${set2} 3: ${set3}');
    return set1 && set2 && set3; //true if all success
  }
}

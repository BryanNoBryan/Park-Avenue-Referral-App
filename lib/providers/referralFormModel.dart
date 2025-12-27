import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../navigation/MyNavigator.dart';

import 'package:flutter/foundation.dart';

import 'model_classes/ReferralRecord.dart';
// import 'UserDatabase.dart';
// import 'database.dart';



/// NOTE FOR SELF:
/// WE PROBABLY DONT NEED FANCY CHANGENOTIFIER AND PROVIDER IN THIS CASE
/// SINCE WE'RE ONLY DEALING IN ONE PAGE
/// I WROTE THIS JUST IN CASE I WANTED TO USE IT
/// TO LATER SELF: JUST IMPLEMENT IT IN THE PAGE INSTEAD!!!!

class ReferralFormModel extends ChangeNotifier {
  late final ReferralRecord record;

  static const String BACKEND_URL = ReferralRecord.BACKEND_URL;

  void init(
    String patientName,
    String patientPhone,
    String patientEmail,
    String referringDoctorName,
    String referringDoctorPhone,
    String referringDoctorEmail,
    String consultType, {
    String? comments,
  }) {
    record = ReferralRecord(
      patientName: patientName,
      patientPhone: patientPhone,
      patientEmail: patientEmail,
      referringDoctorName: referringDoctorName,
      referringDoctorPhone: referringDoctorPhone,
      referringDoctorEmail: referringDoctorEmail,
      consultType: consultType,
      comments: comments,
    );
  }


  Future<int> serverPOSTrequest() async {
    final response = await http.post(
      Uri.parse(BACKEND_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(record.toJson()),
    );

    //decode e.g.
    //Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    // my way: Album.fromJson(response.body);

    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 400) {
      return 400;
    } else { //should only be 404 or 500s
      return 404;
    }
  }
}

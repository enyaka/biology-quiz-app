import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CloudFirestoreLayer {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool addBug(int? questionID, String? question, String bug) {
    Map<String, dynamic> bugMap = {};
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);

    bugMap['questionID'] = questionID;
    bugMap['question'] = question;
    bugMap['bug'] = bug;
    bugMap['date'] = myTimeStamp;
    try {
      _firestore
          .collection('bugReports')
          .add(bugMap)
          .then((value) => debugPrint(''));
      return true;
    } catch (e) {
      return false;
    }
  }
}

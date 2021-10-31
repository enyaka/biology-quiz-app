// ignore_for_file: must_be_immutable

import 'package:enyaka_biology_quiz/locator.dart';
import 'package:enyaka_biology_quiz/service/cloud_firestore_layer.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum BugReason { birinci, ikinci, ucuncu, dorduncu }

class BugReport extends StatefulWidget {
  String bug = 'Soru hatalı.';
  final int questionID;
  final String question;

  BugReport({
    Key? key,
    required this.questionID,
    required this.question,
  }) : super(key: key);

  @override
  _BugReportState createState() => _BugReportState();
}

class _BugReportState extends State<BugReport> {
  BugReason? _bugReason = BugReason.birinci;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('HATA BİLDİR'),
      elevation: 5,
      content: Column(
        children: [
          ListTile(
            title: Text(
              'Soru hatalı.',
              style: TextStyle(fontSize: 15.sp),
            ),
            leading: Radio(
              value: BugReason.birinci,
              groupValue: _bugReason,
              onChanged: (BugReason? value) {
                setState(() {
                  _bugReason = value;
                  widget.bug = 'Soru hatalı.';
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Sorunun cevabı yanlış',
              style: TextStyle(fontSize: 15.sp),
            ),
            leading: Radio(
              value: BugReason.ikinci,
              groupValue: _bugReason,
              onChanged: (BugReason? value) {
                setState(() {
                  _bugReason = value;
                  widget.bug = 'Sorunun cevabı yanlış,';
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Soru Müfdredat dışı.',
              style: TextStyle(fontSize: 15.sp),
            ),
            leading: Radio(
              value: BugReason.ucuncu,
              groupValue: _bugReason,
              onChanged: (BugReason? value) {
                setState(() {
                  _bugReason = value;
                  widget.bug = 'Soru Müfdredat dışı.';
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Diğer',
              style: TextStyle(fontSize: 15.sp),
            ),
            leading: Radio(
              value: BugReason.dorduncu,
              groupValue: _bugReason,
              onChanged: (BugReason? value) {
                setState(() {
                  _bugReason = value;
                  widget.bug = 'Diğer,';
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Geri')),
        TextButton(
            onPressed: () {
              CloudFirestoreLayer _cloudFireBaseLayer =
                  locator<CloudFirestoreLayer>();
              bool response = _cloudFireBaseLayer.addBug(
                  widget.questionID, widget.question, widget.bug);
              response
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hata iletildi.')))
                  : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Hata iletilemedi! İnternet bağlantınızı kontrol ediniz')));

              Navigator.pop(context);
            },
            child: const Text('Gönder')),
      ],
    );
  }
}

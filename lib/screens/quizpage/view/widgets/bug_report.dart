// ignore_for_file: must_be_immutable

import 'package:enyaka_biology_quiz/locator.dart';
import 'package:enyaka_biology_quiz/service/cloud_firestore_layer.dart';
import 'package:enyaka_biology_quiz/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants.dart';

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
  final String _title = 'HATA BİLDİR';
  final String _firstOption = 'Soru hatalı.';
  final String _secondOption = 'Sorunun cevabı yanlış';
  final String _thirdOption = 'Soru Müfdredat dışı.';
  final String _fourthOption = 'Diğer';
  final String _backButtonText = 'Geri';
  final String _sendButtonText = 'Gönder';
  final String _succesMessage = 'Hata iletildi.';
  final String _errorMessage =
      'Hata iletilemedi! İnternet bağlantınızı kontrol ediniz';
  @override
  Widget build(BuildContext context) {
    final _theme = BlocProvider.of<ThemeCubit>(context);
    final _backgroundColor =
        _theme.isDark ? kDarkModeBackrgoundColor : kWhiteModeBackgroundColor;
    final _textColor = _theme.isDark ? Colors.white : Colors.grey[800];
    return AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      scrollable: true,
      backgroundColor: _backgroundColor,
      title: Text(
        _title,
        style: TextStyle(color: _textColor),
      ),
      elevation: 5,
      content: Column(
        children: [
          ListTile(
            title: Text(
              _firstOption,
              style: TextStyle(fontSize: 15.sp, color: _textColor),
            ),
            leading: Radio(
              value: BugReason.birinci,
              groupValue: _bugReason,
              onChanged: (BugReason? value) {
                setState(() {
                  _bugReason = value;
                  widget.bug = _firstOption;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              _secondOption,
              style: TextStyle(fontSize: 15.sp, color: _textColor),
            ),
            leading: Radio(
              value: BugReason.ikinci,
              groupValue: _bugReason,
              onChanged: (BugReason? value) {
                setState(() {
                  _bugReason = value;
                  widget.bug = _secondOption;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              _thirdOption,
              style: TextStyle(fontSize: 15.sp, color: _textColor),
            ),
            leading: Radio(
              value: BugReason.ucuncu,
              groupValue: _bugReason,
              onChanged: (BugReason? value) {
                setState(() {
                  _bugReason = value;
                  widget.bug = _thirdOption;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              _fourthOption,
              style: TextStyle(fontSize: 15.sp, color: _textColor),
            ),
            leading: Radio(
              value: BugReason.dorduncu,
              groupValue: _bugReason,
              onChanged: (BugReason? value) {
                setState(() {
                  _bugReason = value;
                  widget.bug = _fourthOption;
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
            child: Text(_backButtonText)),
        TextButton(
            onPressed: () {
              CloudFirestoreLayer _cloudFireBaseLayer =
                  locator<CloudFirestoreLayer>();
              bool response = _cloudFireBaseLayer.addBug(
                  widget.questionID, widget.question, widget.bug);
              response
                  ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(_succesMessage),
                      duration: const Duration(milliseconds: 1000),
                    ))
                  : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(milliseconds: 1000),
                      content: Text(_errorMessage)));

              Navigator.pop(context);
            },
            child: Text(_sendButtonText)),
      ],
    );
  }
}

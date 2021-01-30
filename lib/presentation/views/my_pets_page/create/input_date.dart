// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/utils/date_formatter.dart';

class InputDate extends StatefulWidget {
  const InputDate({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  String _date;

  @override
  void initState() {
    _date = '選択してください';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Color(0xFFF5F6F9),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: Color(0xFFFF7643),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 1, child: Container(child: Text(widget.text))),
                  Flexible(
                    flex: 2,
                    child: FlatButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime.now().add(Duration(days: 365)),
                              onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                                setState(() {
                                  _date = DateFormatter.generateStr(date);
                                });
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.jp);
                        },
                        child: Text(
                          _date,
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

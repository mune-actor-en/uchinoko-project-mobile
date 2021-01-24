// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/utils/date_formatter.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

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
              icon,
              color: Color(0xFFFF7643),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 1, child: Container(child: Text(text))),
                  Flexible(flex: 2, child: TextFormField()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileGender extends StatefulWidget {
  const ProfileGender({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  _ProfileGenderState createState() => _ProfileGenderState();
}

class _ProfileGenderState extends State<ProfileGender> {
  String _gender = '未選択';

  void _onChange(String val) {
    setState(() {
      _gender = val;
    });
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
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.venus, color: Colors.redAccent,),
                        Radio(
                          value: 'female',
                          groupValue: _gender,
                          onChanged: _onChange,
                        ),
                        Expanded(child: Container()),
                        Icon(FontAwesomeIcons.mars, color: Colors.blueAccent,),
                        Radio(
                          value: 'male',
                          groupValue: _gender,
                          onChanged: _onChange,
                        ),
                      ],
                    ),
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

class ProfileBirthday extends StatefulWidget {
  const ProfileBirthday({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  _ProfileBirthdayState createState() => _ProfileBirthdayState();
}

class _ProfileBirthdayState extends State<ProfileBirthday> {
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
                              minTime: DateTime(1950, 1, 1),
                              maxTime: DateTime.now(), onChanged: (date) {
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

class ProfileDate extends StatefulWidget {
  const ProfileDate({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  _ProfileDateState createState() => _ProfileDateState();
}

class _ProfileDateState extends State<ProfileDate> {
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

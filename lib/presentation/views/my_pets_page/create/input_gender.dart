// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputGender extends StatefulWidget {
  const InputGender({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  _InputGenderState createState() => _InputGenderState();
}

class _InputGenderState extends State<InputGender> {
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
                        Icon(
                          FontAwesomeIcons.venus,
                          color: Colors.redAccent,
                        ),
                        Radio(
                          value: 'female',
                          groupValue: _gender,
                          onChanged: _onChange,
                        ),
                        Expanded(child: Container()),
                        Icon(
                          FontAwesomeIcons.mars,
                          color: Colors.blueAccent,
                        ),
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

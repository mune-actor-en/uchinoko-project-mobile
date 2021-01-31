// Flutter imports:
import 'package:flutter/material.dart';

class InputSpecialPoint extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function(String) callback;

  const InputSpecialPoint({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.callback,
  }) : super(key: key);


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
                  Flexible(flex: 2, child: TextFormField(
                    onSaved: (val){
                      print('onSave');
                      callback(val);
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

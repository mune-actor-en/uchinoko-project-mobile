// Flutter imports:
import 'package:flutter/material.dart';
import 'package:uchinoko_project_mobile/presentation/utils/get_screen_size.dart';
import 'package:uchinoko_project_mobile/presentation/views/login_page/login_page.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/views/register_page/register_header.dart';
import 'package:uchinoko_project_mobile/presentation/views/register_page/register_input.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = getScreenSize(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.cyan[500], Colors.cyan[300], Colors.cyan[400]]),
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 54, right: 30),
                width: size.width,
                alignment: Alignment.centerRight,
                child: Text(
                  'ログイン',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RegisterHeader(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: RegisterInput(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

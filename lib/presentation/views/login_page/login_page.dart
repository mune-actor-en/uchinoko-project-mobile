// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/views/login_page/input_wrapper.dart';
import 'package:uchinoko_project_mobile/presentation/views/login_page/login_header.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 80,
            ),
            LoginHeader(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: InputWrapper(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

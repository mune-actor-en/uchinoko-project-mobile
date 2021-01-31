// Flutter imports:
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:uchinoko_project_mobile/application/providers.dart';
import 'package:uchinoko_project_mobile/presentation/utils/get_screen_size.dart';
import 'package:flutter_riverpod/all.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/views/login_page/input_wrapper.dart';
import 'package:uchinoko_project_mobile/presentation/views/login_page/login_header.dart';
import 'package:uchinoko_project_mobile/presentation/views/register_page/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin {

  @override
  void afterFirstLayout(BuildContext context) {
    context.read(petsNotifierProvider).fetchPets();
  }

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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 54, right: 30),
                width: size.width,
                alignment: Alignment.centerRight,
                child: Text(
                  '新規登録',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
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

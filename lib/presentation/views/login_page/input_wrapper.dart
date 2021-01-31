// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/all.dart';

// Project imports:
import 'package:uchinoko_project_mobile/application/providers.dart';
import 'package:uchinoko_project_mobile/application/controller/session_notifier.dart';
import 'package:uchinoko_project_mobile/presentation/views/timeline_page/index/timeline_screen.dart';

class InputWrapper extends StatefulWidget {
  @override
  _InputWrapperState createState() => _InputWrapperState();
}

class _InputWrapperState extends State<InputWrapper> {
  String email;
  String password;

  void setEmail(String str) {
    email = str;
  }

  void setPassword(String str) {
    password = str;
  }

  void submit(BuildContext context) {
    context.read(sessionNotifierProvider).login(
      email: email,
      password: password,
    );
  }

  @override
  void initState() {
    email = 'hoge002@gmail.com';
    password = 'hoge002';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: InputField(
              setEmail: setEmail,
              setPassword: setPassword,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 40,
          ),
          ProviderListener(
            provider: sessionNotifierProvider.state,
            onChange: (context, state) {
              if (state is SessionError) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
              } else if (state is SessionComplete) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => TimelineScreen()),
                );
              }
            },
            child: Consumer(
              builder: (context, watch, child) {
                final state = watch(sessionNotifierProvider.state);

                if (state is SessionJudge) {
                  return GestureDetector(
                    onTap: () => submit(context),
                    child: Button(),
                  );
                } else if (state is SessionTrying) {
                  return ButtonInProgress();
                } else {
                  return GestureDetector(
                    onTap: () => submit(context),
                    child: Button(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  InputField({this.setEmail, this.setPassword});

  final void Function(String) setEmail;
  final void Function(String) setPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))),
          child: TextField(
            onChanged: (e) => setEmail(e),
            decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))),
          child: TextField(
            onChanged: (e) => setPassword(e),
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Enter your password",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.cyan[500],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "Login",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ButtonInProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.cyan[500],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

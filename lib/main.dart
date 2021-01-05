import 'package:flutter/material.dart';
import 'package:uchinoko_project_mobile/presentation/views/drawerScreen.dart';
import 'package:uchinoko_project_mobile/presentation/views/homeScreen.dart';

void main(){
  runApp(MaterialApp(home: HomePage(),
    theme: ThemeData(
        fontFamily: 'Circular'
    ),
  ));
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen()
        ],
      ),
    );
  }
}

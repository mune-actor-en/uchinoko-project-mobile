// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/all.dart';

// Project imports:
import 'package:uchinoko_project_mobile/application/providers.dart';
import 'package:uchinoko_project_mobile/presentation/utils/configuration.dart';
import 'package:uchinoko_project_mobile/presentation/views/login_page/login_page.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryGreen,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(9),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      "https://user-images.githubusercontent.com/46050182/100489814-01167a00-315a-11eb-885b-2156062cc5bf.png"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Uchinoko',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: drawerItems
                .map((element) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  print("menu item is tapped!");
                  if (element['screen'] != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => element['screen'],
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      element['icon'],
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(element['title'],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))
                  ],
                ),
              ),
            ))
                .toList(),
          ),
          Container(),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Settings',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Text('ログアウトします。\nよろしいですか？'),
                        actions: [
                          Row(
                            children: [
                              InkWell(
                                child: Container(
                                  child: Text(
                                    'キャンセル',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 6),
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 6),
                                  child: Text(
                                    'ログアウト',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                ),
                                onTap: () {
                                  context
                                      .read(sessionNotifierProvider)
                                      .logout();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoginPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

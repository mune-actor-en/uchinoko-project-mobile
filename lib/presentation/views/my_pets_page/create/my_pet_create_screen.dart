// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/presentation/utils/configuration.dart';
import 'package:uchinoko_project_mobile/presentation/utils/get_screen_size.dart';
import 'package:uchinoko_project_mobile/presentation/views/all/drawer_screen.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/create_body.dart';

class MyPetCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          _Screen(),
        ],
      ),
    );
  }
}

class _Screen extends StatefulWidget {
  @override
  __ScreenState createState() => __ScreenState();
}

class __ScreenState extends State<_Screen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 50, right: 20),
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isDrawerOpen
                        ? IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                isDrawerOpen = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                xOffset = 230;
                                yOffset = 150;
                                scaleFactor = 0.6;
                                isDrawerOpen = true;
                              });
                            }),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('うちの子 登録'),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryGreen,
                            ),
                            Text('uchinoko island'),
                          ],
                        ),
                      ],
                    ),
                    Text('登録', style: TextStyle(color: Colors.lightBlue),)
                  ],
                ),
              ),
              Container(
                height: size.height - 120,
                // color: Colors.greenAccent,
                child: CreateBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetTile extends StatelessWidget {
  const PetTile({@required this.pet}) : super();

  final PetModel pet;

  @override
  ListTile build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
      leading: CircleAvatar(
        backgroundColor: primaryGreen,
        backgroundImage: NetworkImage(pet.imagePath),
        radius: 36,
      ),
      title: Text(pet.name),
      subtitle: Text(
        "スコティッシュ・フォールド",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        child: "male" == pet.sex
            ? Icon(
                FontAwesomeIcons.mars,
                size: 32,
                color: Colors.blueAccent,
              )
            : Icon(
                FontAwesomeIcons.venus,
                size: 32,
                color: Colors.redAccent,
              ),
      ),
    );
  }
}

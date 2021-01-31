// Flutter imports:
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/all.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uchinoko_project_mobile/application/providers.dart';

// Project imports:
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/presentation/utils/configuration.dart';
import 'package:uchinoko_project_mobile/presentation/utils/get_screen_size.dart';
import 'package:uchinoko_project_mobile/presentation/views/all/drawer_screen.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/create_select_pic.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/input_birthday.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/input_date.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/input_gender.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/input_name.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/input_special_point.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/index/my_pets_index_screen.dart';

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

  final _formKey = GlobalKey<FormState>();
  String imgBase64;
  String name;
  String gender;
  String birthday;
  String pickupDate;
  String specialPoint;

  void setName(String str) {
    name = str;
    print('set worked');
  }

  void setGender(String str) => gender = str;

  void setBirthday(String str) => birthday = str;

  void setPickupDate(String str) => pickupDate = str;

  void setSpecialPoint(String str) => specialPoint = str;

  void setPicToBase64(String imgPath) => imgBase64 = imgPath;

  void printProperty() {
    print('======================================================');
    print('name: $name');
    print('gender: $gender');
    print('birthday: $birthday');
    print('pickupDate: $pickupDate');
    print('specialPoint: $specialPoint');
    print('imgBase64: $imgBase64');
    print('======================================================');
  }

  Future<void> createPet(BuildContext context) async {
    final PetModel pet = PetModel(
      name: name,
      sex: gender,
      birthday: birthday,
      pickupDate: pickupDate,
      imagePath: imgBase64,
      userId: context.read(sessionNotifierProvider).getUserId(),
    );
    final String jwt = context.read(sessionNotifierProvider).getJwt();
    await context.read(petsNotifierProvider).createPet(pet, jwt);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => MyPetsIndexScreen()),
    );
  }

  @override
  void initState() {
    imgBase64 = '';
    name = '';
    gender = '';
    birthday = '';
    pickupDate = '';
    specialPoint = '';
    super.initState();
  }

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
                    InkWell(
                      onTap: () {
                        _formKey.currentState.save();
                        printProperty();
                        createPet(context);
                      },
                      child: Text(
                        '登録',
                        style: TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: size.height - 120,
                // color: Colors.greenAccent,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CreateSelectPic(
                          callback: setPicToBase64,
                        ),
                        SizedBox(height: 20),
                        InputName(
                          // name: '',
                          text: "なまえ",
                          icon: FontAwesomeIcons.signature,
                          callback: setName,
                        ),
                        InputGender(
                          // sex: '',
                          text: "性別",
                          icon: FontAwesomeIcons.venusMars,
                          callback: setGender,
                        ),
                        InputBirthday(
                          // dateTime: null,
                          text: "お誕生日",
                          icon: FontAwesomeIcons.calendarAlt,
                          callback: setBirthday,
                        ),
                        InputDate(
                          text: "お迎え日",
                          icon: FontAwesomeIcons.car,
                          callback: setPickupDate,
                        ),
                        InputSpecialPoint(
                          // description: '',
                          text: "うちの子の推しポイント",
                          icon: FontAwesomeIcons.fish,
                          callback: setSpecialPoint,
                        ),
                      ],
                    ),
                  ),
                ),
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

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/presentation/utils/configuration.dart';
import 'package:uchinoko_project_mobile/presentation/utils/date_formatter.dart';
import 'package:uchinoko_project_mobile/presentation/utils/get_screen_size.dart';
import 'package:uchinoko_project_mobile/presentation/views/all/drawer_screen.dart';

class MyPetShowScreen extends StatelessWidget {
  final PetModel pet;

  const MyPetShowScreen({this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          _Screen(pet: pet),
        ],
      ),
    );
  }
}

class _Screen extends StatefulWidget {
  final PetModel pet;

  const _Screen({this.pet});

  @override
  __ScreenState createState() => __ScreenState();
}

class __ScreenState extends State<_Screen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context);

    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 50, right: 20),
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('うちの子 詳細'),
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
                  Text(
                    '編集',
                    style: TextStyle(color: Colors.lightBlue),
                  )
                ],
              ),
            ),
            Container(
              height: size.height - 120,
              // color: Colors.greenAccent,
              child: _Body(pet: widget.pet),
            ),
          ],
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

class _Body extends StatelessWidget {
  final PetModel pet;

  const _Body({this.pet});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(imgUrl: pet.imagePath),
          SizedBox(height: 20),
          ProfileMenu(
            name: pet.name,
            text: "なまえ",
            icon: FontAwesomeIcons.signature,
            press: () {},
          ),
          ProfileGender(
            sex: pet.sex,
            text: "性別",
            icon: FontAwesomeIcons.venusMars,
            press: () {},
          ),
          ProfileBirthday(
            dateTime: DateTime.parse(pet.birthday),
            text: "お誕生日",
            icon: FontAwesomeIcons.calendarAlt,
            press: () {},
          ),
          ProfileDate(
            dateTime: DateTime.parse(pet.pickupDate),
            text: "お迎え日",
            icon: FontAwesomeIcons.car,
            press: () {},
          ),
          _ProfileDescription(
            description: 'なし',
            text: "うちの子の推しポイント",
            icon: FontAwesomeIcons.fish,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class ProfilePic extends StatefulWidget {
  final String imgUrl;

  const ProfilePic({
    Key key,
    this.imgUrl,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black12,
            backgroundImage: NetworkImage(widget.imgUrl),
            // : Image.file(_image),
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
    @required this.name,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;
  final String name;

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
                  Flexible(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.center, child: Text(name)),
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

class ProfileGender extends StatefulWidget {
  const ProfileGender({
    Key key,
    @required this.sex,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String sex;
  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  _ProfileGenderState createState() => _ProfileGenderState();
}

class _ProfileGenderState extends State<ProfileGender> {
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
                    child: widget.sex == 'female'
                        ? Align(
                            alignment: Alignment.center,
                            child: Icon(
                              FontAwesomeIcons.venus,
                              color: Colors.redAccent,
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Icon(
                              FontAwesomeIcons.mars,
                              color: Colors.blueAccent,
                            ),
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

class ProfileBirthday extends StatefulWidget {
  const ProfileBirthday({
    Key key,
    @required this.dateTime,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;
  final DateTime dateTime;

  @override
  _ProfileBirthdayState createState() => _ProfileBirthdayState();
}

class _ProfileBirthdayState extends State<ProfileBirthday> {
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
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        DateFormatter.generateStr(widget.dateTime),
                      ),
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

class ProfileDate extends StatefulWidget {
  const ProfileDate({
    Key key,
    @required this.dateTime,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;
  final DateTime dateTime;

  @override
  _ProfileDateState createState() => _ProfileDateState();
}

class _ProfileDateState extends State<ProfileDate> {
  String _date;

  @override
  void initState() {
    _date = '選択してください';
    super.initState();
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
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        DateFormatter.generateStr(widget.dateTime),
                      ),
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

class _ProfileDescription extends StatelessWidget {
  const _ProfileDescription({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
    @required this.description,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;
  final String description;

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
                  Flexible(flex: 2, child: Container(alignment: Alignment.center,child: Text(description))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

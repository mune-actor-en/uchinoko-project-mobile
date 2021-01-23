import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uchinoko_project_mobile/presentation/views/profile/components/profile_menu.dart';
import 'package:uchinoko_project_mobile/presentation/views/profile/components/profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "なまえ",
            icon: FontAwesomeIcons.signature,
            press: () {},
          ),
          ProfileGender(
            text: "性別",
            icon: FontAwesomeIcons.venusMars,
            press: () {},
          ),
          ProfileBirthday(
            text: "お誕生日",
            icon: FontAwesomeIcons.calendarAlt,
            press: () {},
          ),
          ProfileDate(
            text: "お迎え日",
            icon: FontAwesomeIcons.car,
            press: () {},
          ),
          ProfileMenu(
            text: "うちの子の推しポイント",
            icon: FontAwesomeIcons.fish,
            press: () {},
          ),
        ],
      ),
    );
  }
}

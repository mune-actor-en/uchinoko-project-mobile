// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/create_select_pic.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/input_birthday.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/input_date.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/input_gender.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/input_name.dart';

class CreateBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CreateSelectPic(),
          SizedBox(height: 20),
          InputName(
            // name: '',
            text: "なまえ",
            icon: FontAwesomeIcons.signature,
            press: () {},
          ),
          InputGender(
            // sex: '',
            text: "性別",
            icon: FontAwesomeIcons.venusMars,
            press: () {},
          ),
          InputBirthday(
            // dateTime: null,
            text: "お誕生日",
            icon: FontAwesomeIcons.calendarAlt,
            press: () {},
          ),
          InputDate(
            text: "お迎え日",
            icon: FontAwesomeIcons.car,
            press: () {},
          ),
          InputName(
            // description: '',
            text: "うちの子の推しポイント",
            icon: FontAwesomeIcons.fish,
            press: () {},
          ),
        ],
      ),
    );
  }
}

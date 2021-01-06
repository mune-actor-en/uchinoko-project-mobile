import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uchinoko_project_mobile/main.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_index_screen.dart';

Color primaryGreen = Colors.cyan[600];
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Cats', 'iconPath': 'assets/images/cat.png'},
  {'name': 'Dogs', 'iconPath': 'assets/images/dog.png'},
  {'name': 'Bunnies', 'iconPath': 'assets/images/rabbit.png'},
  {'name': 'Parrots', 'iconPath': 'assets/images/parrot.png'},
  {'name': 'Horses', 'iconPath': 'assets/images/horse.png'}
];

List<Map> drawerItems=[
  {
    'icon': FontAwesomeIcons.home,
    'title' : 'タイムライン',
    'screen': HomePage(),
  },
  {
    'icon': FontAwesomeIcons.paw,
    'title' : 'うちの子 一覧',
    'screen': MyPetsIndexScreen(),
  },
  {
    'icon': FontAwesomeIcons.plus,
    'title' : 'うちの子 追加'
  },
  {
    'icon': Icons.favorite,
    'title' : 'お気に入り'
  },
  {
    'icon': Icons.mail,
    'title' : 'メッセージ'
  },
  {
    'icon': FontAwesomeIcons.userAlt,
    'title' : 'アカウント'
  },
];
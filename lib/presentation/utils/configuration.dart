// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/create/my_pet_create_screen.dart';
import 'package:uchinoko_project_mobile/presentation/views/my_pets_page/index/my_pets_index_screen.dart';
import 'package:uchinoko_project_mobile/presentation/views/timeline_page/create/timeline_post_screen.dart';
import 'package:uchinoko_project_mobile/presentation/views/timeline_page/index/timeline_screen.dart';

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
    'screen': TimelineScreen(),
  },
  {
    'icon': FontAwesomeIcons.paw,
    'title' : 'うちの子 一覧',
    'screen': MyPetsIndexScreen(),
  },
  {
    'icon': FontAwesomeIcons.folderPlus,
    'title' : 'うちの子 追加',
    'screen': MyPetCreateScreen(),
  },
  {
    'icon': FontAwesomeIcons.plusSquare,
    'title' : 'うちの子 投稿',
    'screen': TimelinePostScreen(),
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

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/views/all/drawer_screen.dart';
import 'package:uchinoko_project_mobile/presentation/views/timeline_page/index/timeline_body.dart';

class TimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          TimelineBody(),
        ],
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

// Project imports:
import 'package:uchinoko_project_mobile/presentation/views/configuration.dart';

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        height: 66,
        width: 66,
        child: LiquidCircularProgressIndicator(
          value: 0.25,
          valueColor: AlwaysStoppedAnimation(primaryGreen),
          backgroundColor: Colors.white,
          borderColor: primaryGreen,
          borderWidth: 3.0,
          direction: Axis.vertical,
          center: Text(
            "Loading...",
            style: TextStyle(fontSize: 10.0),
          ),
        ),
      ),
    );
  }
}

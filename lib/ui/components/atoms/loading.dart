import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(Gap.m),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ProjectColor.main),
      ),
    );
  }
}

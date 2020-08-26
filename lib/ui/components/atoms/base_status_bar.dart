import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class BaseStatusBar extends StatelessWidget {
  final Widget child;

  const BaseStatusBar({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColor.black1,
      child: SafeArea(
        child: child,
      ),
    );
  }
}

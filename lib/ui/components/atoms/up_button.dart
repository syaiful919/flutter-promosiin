import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class UpButton extends StatelessWidget {
  final VoidCallback onTap;

  const UpButton({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(Gap.xxs),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ProjectColor.accent,
        ),
        child: Icon(
          Icons.arrow_upward,
          color: ProjectColor.white1,
        ),
      ),
    );
  }
}

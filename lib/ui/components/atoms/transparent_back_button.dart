import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class TransparentBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const TransparentBackButton({Key key, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(Gap.s),
        margin: EdgeInsets.all(Gap.s),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusSize.s),
          color: ProjectColor.white2.withOpacity(0.8),
        ),
        child: Icon(
          Icons.arrow_back_ios,
          color: ProjectColor.black2,
        ),
      ),
      onTap: () => onTap(),
    );
  }
}

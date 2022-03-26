import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class TransparentIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const TransparentIconButton({
    Key key,
    @required this.onTap,
    this.icon = Icons.arrow_back_ios,
  }) : super(key: key);

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
          icon,
          color: ProjectColor.black2,
        ),
      ),
      onTap: () => onTap(),
    );
  }
}

import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class SectionRow extends StatelessWidget {
  final String title;
  final Widget icon;
  final String subtitle;
  final VoidCallback subtitleAction;
  final VoidCallback iconAction;

  final bool showSubtitle;

  const SectionRow({
    Key key,
    this.title,
    this.subtitle,
    this.subtitleAction,
    this.showSubtitle = true,
    this.icon,
    this.iconAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Gap.m, Gap.zero, Gap.m, Gap.zero),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: TypoStyle.title500,
          ),
          if (showSubtitle && subtitle != null)
            GestureDetector(
              onTap: () => subtitleAction(),
              child: Text(
                subtitle,
                style: TypoStyle.caption,
              ),
            ),
          if (showSubtitle && icon != null)
            GestureDetector(onTap: () => iconAction(), child: icon)
        ],
      ),
    );
  }
}

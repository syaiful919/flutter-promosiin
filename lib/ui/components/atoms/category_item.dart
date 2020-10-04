import 'package:base_project/utils/project_icons.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:base_project/extension/extended_string.dart';

class CategoryItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String id;
  final String name;
  final VoidCallback onTap;

  const CategoryItem({
    Key key,
    this.isFirst = false,
    this.isLast = false,
    this.name,
    this.onTap,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 70,
        height: 110,
        margin: EdgeInsets.only(
          left: isFirst ? Gap.m : Gap.zero,
          right: isLast ? Gap.m : Gap.s,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Gap.m),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                getAssetIcon(id),
                color: ProjectColor.main,
              ),
            ),
            SizedBox(
              height: Gap.xs,
            ),
            Text(
              name.capitalize(),
              style: TypoStyle.caption,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

String getAssetIcon(String id) {
  switch (id) {
    case "c1":
      return ProjectIcons.food;
    case "c2":
      return ProjectIcons.electro;
    case "c3":
      return ProjectIcons.hobby;
    case "c4":
      return ProjectIcons.fashion;
    case "c5":
      return ProjectIcons.craft;
    case "c6":
      return ProjectIcons.health;
    case "c7":
      return ProjectIcons.furniture;
    case "c8":
      return ProjectIcons.kitchen;

    default:
      return ProjectIcons.other;
  }
}

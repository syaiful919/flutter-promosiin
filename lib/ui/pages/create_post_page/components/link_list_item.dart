import 'package:base_project/model/entity/post_model.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class LinkListItem extends StatelessWidget {
  final ExternalLink link;
  final int index;
  final Function(ExternalLink, int) editAction;
  final Function(int) removeAction;

  const LinkListItem({
    Key key,
    this.link,
    this.index,
    this.editAction,
    this.removeAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Gap.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: Gap.s),
          Expanded(
            child: Text(
              link.title,
              style: TypoStyle.paragraph,
            ),
          ),
          GestureDetector(
            onTap: () => editAction(link, index),
            child: Icon(Icons.edit, color: ProjectColor.grey1),
          ),
          SizedBox(width: Gap.m),
          GestureDetector(
            onTap: () => removeAction(index),
            child: Icon(Icons.delete, color: ProjectColor.grey1),
          ),
        ],
      ),
    );
  }
}

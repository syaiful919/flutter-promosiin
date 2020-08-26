import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class DetailAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback backAction;
  final bool showBackButton;

  DetailAppBar({
    Key key,
    @required this.title,
    this.backAction,
    this.showBackButton = true,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _DetailAppBarState createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TypoStyle.pageTitle,
      ),
      centerTitle: true,
      backgroundColor: ProjectColor.main,
      leading: widget.showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: ProjectColor.white1,
              ),
              onPressed: () => widget.backAction())
          : null,
    );
  }
}

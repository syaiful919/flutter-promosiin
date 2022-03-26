import 'package:base_project/utils/project_images.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          ProjectImages.empty,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        SizedBox(height: Gap.m),
        Text(
          "Belum ada postingan",
          style: TypoStyle.title,
        ),
      ],
    )));
  }
}

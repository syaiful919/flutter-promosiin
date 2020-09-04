import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class HtmlContainer extends StatelessWidget {
  final String data;
  final Map<String, Style> style;
  final Function(String) onLinkTap;

  const HtmlContainer({
    @required this.data,
    this.style,
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      shrinkWrap: true,
      data: data,
      style: style,
      onLinkTap: (url) => onLinkTap(url),
    );
  }
}

// style example
Map<String, Style> style = {
  "html": Style(
    backgroundColor: ProjectColor.white1,
    padding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
  ),
  "p": Style(padding: EdgeInsets.only(left: Gap.s))
};

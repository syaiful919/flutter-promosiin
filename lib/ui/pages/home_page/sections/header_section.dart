import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Header extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(context, model) {
    return SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.fromLTRB(Gap.m, Gap.l, Gap.m, Gap.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Selamat datang",
            style: TypoStyle.head600,
          ),
          Text(
            "Cari promo apa hari ini?",
            style: TypoStyle.title,
          ),
        ],
      ),
    ));
  }
}
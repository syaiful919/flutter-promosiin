import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/blank_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BlankViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => BlankViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Blank Page",
                  style: TypoStyle.sectionLabel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

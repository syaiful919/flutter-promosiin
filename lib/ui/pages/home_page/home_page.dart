import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<HomeViewModel>.reactive(
        onModelReady: (model) => model.firstLoad(context: context),
        viewModelBuilder: () => HomeViewModel(),
        builder: (_, model, __) => Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: Gap.m),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Home Page",
                  style: TypoStyle.sectionLabel.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Gap.m),
                BaseButton(
                  title: "Go to Stream Sample Page",
                  onPressed: () => model.goToStreamSamplePage(),
                ),
                SizedBox(height: Gap.m),
                BaseButton(
                  title: "Go to Multiple Stream Sample Page",
                  onPressed: () => model.goToMultipleStreamSamplePage(),
                )
              ],
            ),
          ),
        ),
      );
}

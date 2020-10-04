import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/pages/widget_experiment_page/examples/image_picker_example.dart';
import 'package:base_project/viewmodel/widget_experiment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetExperimentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WidgetExperimentViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => WidgetExperimentViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          body: ImagePickerExample(),
        ),
      ),
    );
  }
}

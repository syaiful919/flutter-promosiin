import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/widget_experiment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ImagePickerExample extends ViewModelWidget<WidgetExperimentViewModel> {
  const ImagePickerExample({Key key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetExperimentViewModel model,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Gap.m),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          (model.image == null)
              ? Text("No selected image")
              : AspectRatio(aspectRatio: 1, child: Image.file(model.image)),
          SizedBox(height: Gap.s),
          BaseButton(
            title: "Pick form gallery",
            onPressed: () => model.openGallery(),
          ),
          SizedBox(height: Gap.s),
          BaseButton(
            title: "Open camera",
            onPressed: () => model.openCamera(),
          ),
        ],
      ),
    );
  }
}

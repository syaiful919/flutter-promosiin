import 'package:base_project/ui/components/atoms/base_button.dart';
import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/ui/components/molecules/detail_appbar.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/multiple_stream_sample_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MultipleStreamSamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultipleStreamSampleViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => MultipleStreamSampleViewModel(),
      builder: (_, model, __) => BaseStatusBar(
        child: Scaffold(
          appBar: DetailAppBar(
            title: "Multiple Stream Sample Page",
            backAction: () => model.goBack(),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  model.cartCount.toString(),
                  style: TypoStyle.paragraph,
                ),
                SizedBox(height: Gap.m),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: BaseButton(
                        title: "-",
                        onPressed: () => model.decrement(),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: BaseButton(
                        title: "+",
                        onPressed: () => model.increment(),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

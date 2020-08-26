import 'package:base_project/ui/components/atoms/base_status_bar.dart';
import 'package:base_project/viewmodel/in_app_webview_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stacked/stacked.dart';

class InAppWebviewPage extends StatefulWidget {
  final String redirectUrl;
  const InAppWebviewPage({@required this.redirectUrl});

  @override
  _InAppWebviewPageState createState() => _InAppWebviewPageState();
}

class _InAppWebviewPageState extends State<InAppWebviewPage> {
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return BaseStatusBar(
      child: ViewModelBuilder.reactive(
        onModelReady: (model) => model.firstLoad(context: context),
        viewModelBuilder: () => InAppWebviewViewModel(),
        builder: (_, model, __) => Scaffold(
          body: Container(
            child: WillPopScope(
              onWillPop: () async {
                try {
                  bool canGoBack = await webView.canGoBack();
                  if (canGoBack) {
                    webView.goBack();
                    return false;
                  } else {
                    model.goBack();
                    return true;
                  }
                } catch (e) {
                  print(">>> error $e");
                }
                return true;
              },
              child: InAppWebView(
                initialUrl: widget.redirectUrl,
                initialHeaders: {},
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(debuggingEnabled: true),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {},
                onLoadStop: (InAppWebViewController controller, String url) {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}

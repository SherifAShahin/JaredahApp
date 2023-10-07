import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {

  var controller;

  WebviewScreen(
      this.controller,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jaredah',
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

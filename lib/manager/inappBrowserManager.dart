import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    print("Started $url");
  }

  @override
  Future onLoadStop(url) async {
    print("Stopped $url");
  }

  @override
  void onReceivedError(WebResourceRequest request, WebResourceError error) {
    print("Can't load ${request.url}.. Error: ${error.description}");
  }

  @override
  void onProgressChanged(progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("Browser closed!");
  }
}

class MyInAppWebView extends InAppWebView {
  MyInAppWebView({super.key});

  Future onBrowserCreated() async {
    print("Browser Created!");
  }
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad(bool) {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

class InAppBrowserManager {
  static final InAppBrowserManager _instance = InAppBrowserManager._internal();
  factory InAppBrowserManager() => _instance;
  InAppBrowserManager._internal();

  static InAppBrowserManager getInstance() {
    return _instance;
  }

  final MyInAppBrowser browser = MyInAppBrowser();

  var settings = InAppBrowserClassSettings(
    browserSettings: InAppBrowserSettings(
      hideUrlBar: true,
      hideToolbarTop: false,
      hideDefaultMenuItems: true,
      toolbarTopBackgroundColor: Colors.white,
      toolbarBottomBackgroundColor: Colors.white,
      hideToolbarBottom: true,
    ),
    webViewSettings: InAppWebViewSettings(
      javaScriptEnabled: true,
    ),
  );

  void openBrowser({required String url}) async {
    await browser.openUrlRequest(
      urlRequest: URLRequest(url: WebUri(url)),
      settings: settings,
    );
  }
}

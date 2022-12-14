import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class StoryPage extends StatelessWidget {
  final String url;
  const StoryPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
        ],
      ),
    );
  }
}

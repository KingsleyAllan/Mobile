// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PayPalWebView extends StatefulWidget {
//   final String url;

//   PayPalWebView({required this.url});

//   @override
//   _PayPalWebViewState createState() => _PayPalWebViewState();
// }

// class _PayPalWebViewState extends State<PayPalWebView> {
//   late WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     // No need for separate Android WebView initialization with the latest versions
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pay with PayPal'),
//       ),
//       body: PayWebView(
//         initialUrl: widget.url,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//         },
//         navigationDelegate: (NavigationRequest request) {
//           if (request.url.contains('success')) {
//             Navigator.pop(context, 'success');
//           } else if (request.url.contains('cancel')) {
//             Navigator.pop(context, 'cancel');
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     );
//   }
// }

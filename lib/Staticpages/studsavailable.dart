import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sizer/sizer.dart';

class StudsAvailable extends StatefulWidget {
  const StudsAvailable({super.key});

  @override
  _StudsAvailableState createState() => _StudsAvailableState();
}

class _StudsAvailableState extends State {
  late InAppWebViewController inappwebview;
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
          var islast = inappwebview.canGoBack();

          if (await islast) {
            inappwebview.goBack();
            return false;
          }
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 223, 39, 39)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Studs Available',
                style: TextStyle(
                    shadows: const [
                      Shadow(
                        blurRadius: 10.0, // shadow blur
                        color: Color.fromARGB(255, 223, 71, 45), // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      ),
                    ],
                    fontSize: 18.sp,
                    decorationColor: Colors.red,
                    color: const Color.fromARGB(255, 194, 97, 33),
                    // color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: const EdgeInsets.all(6),
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                      url: WebUri.uri(Uri.parse(
                          "https://new-demo.inkcdogs.org/studs-available")),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      inappwebview = controller;
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        _progress = progress / 100;
                      });
                    },
                  ),
                  // InAppWebView(
                  //   initialUrlRequest: URLRequest(
                  //       url: Uri.parse("https://new-demo.inkcdogs.org/studs-available")),
                  //   onWebViewCreated: (InAppWebViewController controller) {
                  //     inappwebview = controller;
                  //   },
                  //   onProgressChanged:
                  //       (InAppWebViewController controll, int progress) {
                  //     setState(() {
                  //       _progress = progress / 100;
                  //     });
                  //   },
                  // ),
                  // _progress < 1
                  //     ? Container(
                  //         child: LinearProgressIndicator(
                  //           value: _progress,
                  //         ),
                  //       )
                  //     : SizedBox()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

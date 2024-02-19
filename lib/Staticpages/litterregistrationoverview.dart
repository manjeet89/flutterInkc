import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sizer/sizer.dart';

class LitterRegistrationOverView extends StatefulWidget {
  @override
  _LitterRegistrationOverView createState() => _LitterRegistrationOverView();
}

class _LitterRegistrationOverView extends State {
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
                icon: Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 223, 39, 39)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Litter Registration',
                style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 10.0, // shadow blur
                        color: Color.fromARGB(255, 223, 71, 45), // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      ),
                    ],
                    fontSize: 18.sp,
                    decorationColor: Colors.red,
                    color: Color.fromARGB(255, 194, 97, 33),
                    // color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.all(6),
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse(
                            "https://www.inkc.in/assets/newapp/inkc-app/litter-registration.html")),
                    onWebViewCreated: (InAppWebViewController controller) {
                      inappwebview = controller;
                    },
                    onProgressChanged:
                        (InAppWebViewController controll, int progress) {
                      setState(() {
                        _progress = progress / 100;
                      });
                    },
                  ),
                  _progress < 1
                      ? Container(
                          child: LinearProgressIndicator(
                            value: _progress,
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

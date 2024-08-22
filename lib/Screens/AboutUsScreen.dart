import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';


import '../Themes.dart';
import '../main.dart';
import 'Settings.dart';


class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  WebViewController _controller = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadHtmlFromAssets();

  }
  String fileText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: WHITE,
            elevation: 0,
            flexibleSpace: customDialogues.header(
              context: context,
              text: "ABout Us ",
            ),
            leading: Container(),
          ),
          body: SafeArea(

            child: Scaffold(
              backgroundColor: WHITE,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                /*child: WebView(
                  initialUrl: 'about:blank',
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                    _loadHtmlFromAssets();
                  },
                ),*/
                // child: WebViewWidget(
                //   controller: _controller,
                //   // initialUrl: 'about:blank',
                //   // onWebViewCreated: (WebViewController webViewController) {
                //   //   _controller = webViewController;
                //   //   _loadHtmlFromAssets();
                //   // },
                // ),
                child: Container(
                  child: Html(
                    data: fileText,
                    style: {
                      "body": Style(
                        fontSize: FontSize(16.0),
                        color: Colors.black,
                      ),
                    },
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }

  Widget header(){
    return Stack(
      children: [

        Container(
          height: 60,
          child: Row(
            children: [
              SizedBox(width: 15,),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Settings()));
                },
                child: Image.asset("assets/back.png",
                  height: 25,
                  width: 22,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _loadHtmlFromAssets() async {
    fileText = await rootBundle.loadString('assets/aboutus.html');
    setState(() {});
    // String fileText = await rootBundle.loadString('assets/aboutus.html');
    // _controller.loadRequest( Uri.dataFromString(
    //     mimeType: 'text/html',
    //     fileText,
    //     encoding: Encoding.getByName('utf-8')
    // ));
  }
}


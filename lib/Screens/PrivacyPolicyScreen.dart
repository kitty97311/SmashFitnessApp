import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../CustomWidgets/CustomDialogues.dart';
import '../Modals/privacypolicy.dart';
import '../Themes.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

import 'TabsScreen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  WebViewController _controller = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrivacy();
  }

  PrivacyPolicy? privacyPolicy;
  bool isLoading = false;
  getPrivacy() async {
    setState(() {
      isLoading = true;
    });

    final _response = await http
        .get(Uri.parse(
            "https://customise.freaktemplate.com/dayworkout/api/get_terms"))
        .catchError((e) {
      showCustomDialog(
          context: context,
          title: 'Error',
          msg: e.toString(),
          btnYesText: 'Ok',
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    });
    print(
        "setting screen------------terms and condition============${Uri.parse("https://customise.freaktemplate.com/dayworkout/api/get_terms")}");
    final _jsonResponse = jsonDecode(_response.body);
    print("========================>${_jsonResponse}");

    print("HomeScreen/" + _jsonResponse.toString());
    if (_response.statusCode == 200) {
      print("=====================${_response.statusCode}");
      setState(() {
        privacyPolicy = PrivacyPolicy.fromJson(_jsonResponse);
        print(
            "==============================>>>>${privacyPolicy?.about?.tremsCondi}");
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showCustomDialog(
          context: context,
          title: "Error",
          msg: "FAILED_TO_LOAD_DATA",
          btnYesText: "Ok",
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
      print("HomeScreen/error/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: BLACK,
          appBar: AppBar(
            toolbarHeight: 55,
            elevation: 0,
            backgroundColor: BLACK,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: BLACK,
                    boxShadow: [
                      BoxShadow(
                          color: LIGHT_GREY_TEXT,
                          spreadRadius: 0.1,
                          blurRadius: 4)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: WHITE,
                  size: 18,
                ),
              ),
            ),
            title: t.boldText(text: 'Privacy Policy', color: WHITE, size: 25),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Scaffold(
              backgroundColor: BLACK,
              body: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Html(
                              data: privacyPolicy?.about?.tremsCondi.toString(),
                              style: {
                                "body": Style(
                                  fontSize: FontSize(ipad ? 30 : 15.0),
                                  fontFamily: 'Regular',
                                  color: WHITE,
                                )
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          )),
    );
  }
}

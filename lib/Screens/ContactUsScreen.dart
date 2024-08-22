import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../CustomWidgets/CustomDialogues.dart';
import '../Modals/aboutusclass.dart';
import '../Themes.dart';
import '../main.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  WebViewController _controller = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAbout();

  }
  AboutUsClass? aboutUsClass;
  bool isLoading=false;
   getAbout() async {
    setState(() {
      isLoading=true;
    });

    final _response = await http.get(Uri.parse("https://customise.freaktemplate.com/dayworkout/api/get_aboutus")).
    catchError((e) {
      showCustomDialog(context: context, title: "Errro", msg: e.toString(),
        btnYesText: 'Ok', onPressedBtnYes: () {Navigator.pop(context);});
    });
    print("settingscreen------------aboutus============${Uri.parse("https://customise.freaktemplate.com/dayworkout/api/get_aboutus")}");
    final _jsonResponse = jsonDecode(_response.body);
    print("========================>${_jsonResponse}");

    print("HomeScreen/" + _jsonResponse.toString());
    if (_response.statusCode == 200 ) {
      print("=====================${_response.statusCode}");
      setState(() {
        aboutUsClass = AboutUsClass.fromJson(_jsonResponse);
        print("==============================>>>>${aboutUsClass!.about!.aboutUs}");

        isLoading=false;

      });
    } else {
      setState(() {
        isLoading=false;
      });
      showCustomDialog(
          context: context,
          title: 'Error',
          msg: 'FAILED_TO_LOAD_DATA',
          btnYesText: 'ok',
          onPressedBtnYes: () {
            Navigator.pop(context);
          }
      );
      print("HomeScreen/error/");
    }
  }
  //String fileText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: WHITE,
          //   elevation: 0,
          //   flexibleSpace: customDialogues.header(
          //     context: context,
          //     text: "About US",
          //   ),
          //   leading: Container(),
          // ),
          appBar: AppBar(
            backgroundColor: WHITE,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text(
              "About US",
              style: TextStyle(
                fontSize: ipad ? 30 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Bold',
              ),
            ),
            // flexibleSpace: customDialogues.header(
            //   context: context,
            //   text: "PrivacyPolicy",
            // ),
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Row(
                children: [
                  SizedBox(width: 10,),Image.asset("assets/setting/back.png",height: 20,width: 30,),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Scaffold(
              backgroundColor: WHITE,
              body: isLoading ?Center(child: CircularProgressIndicator(),): Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Html(
                      data: aboutUsClass!.about!.aboutUs.toString(),style: {
                      "body": Style(
                        fontSize: FontSize(ipad ? 30: 15),
                        fontFamily: 'Regular',
                        color: Colors.black.withOpacity(0.6),

                      )},
                    ),

                  ],
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
}


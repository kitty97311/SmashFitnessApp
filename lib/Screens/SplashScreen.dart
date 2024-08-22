import 'dart:async';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:exercise_app/Screens/SetUpProfileScreen.dart';
import 'package:exercise_app/Themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TabsScreen.dart';
import '../main.dart';
import 'Start.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAndStoreToken();
    isIpad();
  }

  findPPIofDevice() {
    setState(() {
      HEIGHT = MediaQuery.of(context).size.height;
      WIDTH = MediaQuery.of(context).size.width;
      print("Height & Width");
      print(HEIGHT);
      print(WIDTH);
      getAndStoreToken();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    findPPIofDevice();
    return Scaffold(
      backgroundColor: BLACK,
      body: Stack(
        children: [
          Center(
            child: Container(
                width: 200,
                height: 200,
                child: OverflowBox(
                  minWidth: 0,
                  maxWidth: double.infinity,
                  minHeight: 0,
                  maxHeight: size.height,
                  child: Image.asset(
                    "assets/splash/bg1.png",
                    fit: BoxFit.cover,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  getAndStoreToken() async {
    SharedPreferences.getInstance().then((value) async {
      //first time
      if (value.getBool("isTokenStored") ?? false) {
        print(await FirebaseMessaging.instance.getToken());
        callHomeScreen();
      } else if (value.getBool("isTokenStored") == null) {
        FirebaseMessaging.instance.getToken().then((value) {
          storeToken(value);
        }).catchError((e) {
          print("SplashScreen/Token Retrieving Error----- :" + e.toString());
          value.setBool("isTokenStored", false);
          callIntroSlider();
        });
      } else if (value.getBool("isTokenStored") == false) {
        FirebaseMessaging.instance.getToken().then((value) {
          storeToken(value);
        }).catchError((e) {
          print("SplashScreen/Token Retrieving Error :" + e.toString());
          value.setBool("isTokenStored", false);
          callHomeScreen();
        });
      }
    });
  }

  callIntroSlider() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Start()));
  }

  callHomeScreen() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getBool("isUserRegistered") ?? false) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TabsScreen()));
      });
    } else {
      if (mounted) {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Start()));
        });
      }
    }
  }

  isIpad() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;
    if (info.model?.toLowerCase() == "ipad") {
      ipad = true;
      print(ipad);
    }
  }

  storeToken(token) async {
    print('token value----------$token');
    print(
        "SplashScreen/$SERVER_ADDRESSLive/api/tokan_data?token=$token&type=android");
    await post(Uri.parse(
            "$SERVER_ADDRESSLive/api/tokan_data?token=$token&type=android"))
        .then((value) {
      final jsonResponse = jsonDecode(value.body);
      print("SplashScreen/" + jsonResponse.toString());
      print(
          "SplashScreen===================/$SERVER_ADDRESSLive/api/tokan_data?token=$token&type=android");
      if (value.statusCode == 200 && jsonResponse['data']['success'] == "1") {
        SharedPreferences.getInstance().then((value) {
          value.setBool("isTokenStored", true);
          callIntroSlider();
        });
      }
    }).catchError((e) {
      print("SplashScreenError/" + e.toString());
      SharedPreferences.getInstance().then((value) {
        value.setBool("isTokenStored", false);
        callIntroSlider();
      });
    });
  }
}

import 'package:exercise_app/Screens/SetUpProfileScreen.dart';
import 'package:exercise_app/Screens/Login.dart';
import '../AllText.dart';
import '../Themes.dart';
import 'package:exercise_app/CustomWidgets/CustomTextWidget.dart';
import 'package:exercise_app/main.dart';
import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  CustomTextWidget customWidgetClass = CustomTextWidget();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BLACK,
      body: Stack(
        children: [
          Center(
            child: Container(
                width: 200,
                height: 200,
                margin: EdgeInsets.only(top: 80),
                child: OverflowBox(
                  minWidth: 0,
                  maxWidth: double.infinity,
                  minHeight: 0,
                  maxHeight: size.height - 150,
                  child: Image.asset(
                    "assets/splash/bg1.png",
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "assets/splash/smashgreen.png",
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SetUpProfileScreen()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: PRIMARY,
                ),
                child: Center(
                  child: customWidgetClass.boldText(
                      text: START2, color: BLACK, size: ipad ? 35 : 25),
                ),
              ),
            ),
            const SizedBox(height: 30),
            customWidgetClass.regularText(
                text: 'Already have an account?',
                color: DARK_GREY_TEXT,
                size: ipad ? 35 : 16),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login(type: 1)));
              },
              child: customWidgetClass.mediumText(
                  text: 'Sign in with an existing account',
                  color: PRIMARY,
                  size: ipad ? 35 : 18),
            ),
            const SizedBox(height: 100),
          ])
        ],
      ),
    );
  }
}

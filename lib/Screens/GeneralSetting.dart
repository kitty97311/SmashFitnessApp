import 'package:exercise_app/Screens/PrivacyPolicyScreen.dart';
import 'package:exercise_app/Screens/UnitSetting.dart';
import 'package:flutter/material.dart';

import '../Themes.dart';
import '../main.dart';

class GeneralSetting extends StatefulWidget {
  @override
  _GeneralSettingState createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      color: LIGHT_GREY_TEXT, spreadRadius: 0.1, blurRadius: 4)
                ],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Icon(
              Icons.arrow_back_ios,
              color: WHITE,
              size: 18,
            ),
          ),
        ),
        title: t.boldText(text: 'General Settings', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(children: [
        // InkWell(
        //     onTap: () {},
        //     child: Container(
        //         width: double.infinity,
        //         padding: EdgeInsets.all(15),
        //         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10), color: GRAY),
        //         child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Icon(Icons.alarm, color: PRIMARY, size: 25),
        //               SizedBox(width: 15),
        //               t.mediumText(
        //                   text: 'Remind me to workout everyday',
        //                   size: 18,
        //                   color: WHITE)
        //             ]))),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UnitSetting()));
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: GRAY),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.compass_calibration, color: PRIMARY, size: 25),
                      SizedBox(width: 15),
                      t.mediumText(
                          text: 'Metric & Imperial Units',
                          size: 18,
                          color: WHITE)
                    ]))),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen()));
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: GRAY),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.remove_red_eye_outlined,
                          color: PRIMARY, size: 25),
                      SizedBox(width: 15),
                      t.mediumText(
                          text: 'Privacy Policy', size: 18, color: WHITE)
                    ]))),
      ]),
    );
  }
}

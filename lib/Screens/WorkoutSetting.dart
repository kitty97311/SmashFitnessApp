import 'package:exercise_app/LocalDatabase/CustomWorkoutsClass.dart';
import 'package:exercise_app/LocalDatabase/HabitClass.dart';
import 'package:exercise_app/LocalDatabase/ProgressClass.dart';
import 'package:exercise_app/LocalDatabase/TrackerClass.dart';
import 'package:exercise_app/Screens/PlusMinus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Themes.dart';
import '../main.dart';
import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';

class WorkoutSetting extends StatefulWidget {
  @override
  _WorkoutSettingState createState() => _WorkoutSettingState();
}

class _WorkoutSettingState extends State<WorkoutSetting> {
  ProgressClass progressClass = ProgressClass();
  HabitClass habitClass = HabitClass();
  TrackerClass trackerClass = TrackerClass();

  int countdown = 0;
  int rest = 0;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        countdown = value.getInt("countdown") ?? 3;
        rest = value.getInt("rest") ?? 4;
      });
    });
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
        title: t.boldText(text: 'Workout Settings', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(children: [
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlusMinus(1)));
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
                      Icon(Icons.airline_seat_recline_extra,
                          color: PRIMARY, size: 25),
                      SizedBox(width: 15),
                      t.mediumText(
                          text: 'Training Rest', size: 18, color: WHITE),
                      Spacer(),
                      t.mediumText(text: '$rest secs', color: PRIMARY, size: 18)
                    ]))),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlusMinus(0)));
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
                      Icon(Icons.timer_outlined, color: PRIMARY, size: 25),
                      SizedBox(width: 15),
                      t.mediumText(
                          text: 'Countdown Time', size: 18, color: WHITE),
                      Spacer(),
                      t.mediumText(
                          text: '$countdown secs', color: PRIMARY, size: 18)
                    ]))),
        InkWell(
            onTap: () {
              SharedPreferences.getInstance().then((value) {
                List<String> dates = value.getStringList("dates") ?? [];
                print(dates);
                showCustomDialog(
                  context: context,
                  title: "Confirm",
                  msg: "Are you sure to restart the progress?",
                  btnYesText: YES,
                  btnNoText: NO,
                  onPressedBtnYes: () {
                    workoutBox.clear();
                    for (String date in dates) {
                      progressClass.clearData(date: date);
                    }
                    habitClass.clearData();
                    trackerClass.clearData();
                    Navigator.pop(context);
                  },
                  onPressedButtonNo: () {
                    Navigator.pop(context);
                  },
                );
              });
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
                      Icon(Icons.restart_alt, color: PRIMARY, size: 25),
                      SizedBox(width: 15),
                      t.mediumText(
                          text: 'Restart Progress', size: 18, color: WHITE),
                    ])))
      ]),
    );
  }
}

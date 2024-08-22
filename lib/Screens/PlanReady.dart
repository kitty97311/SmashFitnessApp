import 'package:exercise_app/Screens/Plan2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'dart:async';
import 'package:exercise_app/CustomWidgets/CustomCheck.dart';
import '../Themes.dart';

CustomCheck customCheck = CustomCheck();

class PlanReady extends StatefulWidget {
  @override
  _PlanReadyState createState() => _PlanReadyState();
}

class _PlanReadyState extends State<PlanReady> {
  String goal = '';
  String duration = '';
  String level = '';
  int commitperweek = 0;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      getPlan();
    });
  }

  getPlan() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    goal = sp.getString('goal')!;
    duration = sp.getString('duration')!;
    level = sp.getString('level')!;
    commitperweek = sp.getInt('commitperweek')!;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BLACK,
      body: ListView(
        children: [
          SizedBox(height: 30),
          // Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16),
          //     child: Row(children: [
          //       IconButton(
          //         onPressed: () {},
          //         icon: Container(
          //           width: 30,
          //           height: 30,
          //           alignment: Alignment.center,
          //           padding: EdgeInsets.only(left: 8),
          //           decoration: BoxDecoration(
          //               shape: BoxShape.rectangle,
          //               color: BLACK,
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: LIGHT_GREY_TEXT,
          //                     spreadRadius: 0.5,
          //                     blurRadius: 6)
          //               ],
          //               borderRadius: BorderRadius.all(Radius.circular(5))),
          //           child: Icon(
          //             Icons.arrow_back_ios,
          //             color: WHITE,
          //             size: 18,
          //           ),
          //         ),
          //       ),
          //     ])),
          Center(
              child: customCheck.confirm(
                  size: 40,
                  iconSize: 25,
                  backgroundColor: BLACK,
                  iconColor: PRIMARY)),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: customTextWidget.mediumText(
                  text: 'Your Plan is ready!',
                  color: WHITE,
                  size: 25,
                  alignment: TextAlign.center)),
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: GRAY, borderRadius: BorderRadius.circular(15)),
              child: Stack(children: [
                Positioned(
                    right: 0, child: Image.asset('assets/setup/gainer.png')),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: customTextWidget.mediumText(
                          text: 'Full Body Gainer for Ardy',
                          color: PRIMARY,
                          size: 22)),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: Row(children: [
                        Image.asset('assets/setup/target.png'),
                        SizedBox(width: 5),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customTextWidget.regularText(
                                  text: 'Goal',
                                  color: LIGHT_GREY_TEXT,
                                  size: 15),
                              customTextWidget.regularText(
                                  text: goal, color: WHITE, size: 15),
                            ])
                      ])),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: Row(children: [
                        Image.asset('assets/setup/calendar.png'),
                        SizedBox(width: 5),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customTextWidget.regularText(
                                  text: 'Duration',
                                  color: LIGHT_GREY_TEXT,
                                  size: 15),
                              customTextWidget.regularText(
                                  text: duration, color: WHITE, size: 15),
                            ])
                      ])),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: Row(children: [
                        Image.asset('assets/setup/lift.png'),
                        SizedBox(width: 5),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customTextWidget.regularText(
                                  text: 'Difficulty',
                                  color: LIGHT_GREY_TEXT,
                                  size: 15),
                              customTextWidget.regularText(
                                  text: level, color: WHITE, size: 15),
                            ])
                      ])),
                  SizedBox(height: 20)
                ])
              ])),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(children: [
                Expanded(
                  flex: 10,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                          height: 120,
                          child: Stack(children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset(
                                'assets/setup/workout.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: PRIMARY),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            duration,
                                            style: TextStyle(
                                                color: PRIMARY, fontSize: 18),
                                          )),
                                      SizedBox(height: 5),
                                      customTextWidget.regularText(
                                          text: 'per workout',
                                          color: WHITE,
                                          size: 16),
                                    ]))
                          ]))),
                ),
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                    flex: 10,
                    child: Container(
                        height: 120,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: GRAY,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customTextWidget.regularText(
                                  text: '${commitperweek + 1} Workout',
                                  color: WHITE,
                                  size: 18),
                              customTextWidget.regularText(
                                  text: 'per week', color: WHITE, size: 15),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(children: [
                                    Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: customCheck.confirm()),
                                    Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: commitperweek > 0
                                            ? customCheck.confirm()
                                            : customCheck.cancel()),
                                    Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: commitperweek > 1
                                            ? customCheck.confirm()
                                            : customCheck.cancel()),
                                    Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: commitperweek > 2
                                            ? customCheck.confirm()
                                            : customCheck.cancel()),
                                  ])),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  child: Row(children: [
                                    Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: commitperweek > 3
                                            ? customCheck.confirm()
                                            : customCheck.cancel()),
                                    Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: commitperweek > 4
                                            ? customCheck.confirm()
                                            : customCheck.cancel()),
                                    Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: commitperweek > 5
                                            ? customCheck.confirm()
                                            : customCheck.cancel()),
                                  ])),
                            ])))
              ])),
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: GRAY, borderRadius: BorderRadius.circular(15)),
              child: Stack(children: [
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset('assets/setup/plan.png')),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: customTextWidget.mediumText(
                          text: 'Inside the plan', color: PRIMARY, size: 22)),
                  Row(children: [
                    customCheck.confirm(size: 18, iconSize: 12),
                    SizedBox(width: 10),
                    customTextWidget.mediumText(
                        text: 'Workout guides', color: WHITE, size: 18),
                  ]),
                  Row(children: [
                    customCheck.confirm(size: 18, iconSize: 12),
                    SizedBox(width: 10),
                    customTextWidget.mediumText(
                        text: 'Exercise videos', color: WHITE, size: 18),
                  ]),
                  Row(children: [
                    customCheck.confirm(size: 18, iconSize: 12),
                    SizedBox(width: 10),
                    customTextWidget.mediumText(
                        text: 'Interactive schedule', color: WHITE, size: 18),
                  ]),
                  Row(children: [
                    customCheck.confirm(size: 18, iconSize: 12),
                    SizedBox(width: 10),
                    customTextWidget.mediumText(
                        text: 'Weight tracking', color: WHITE, size: 18),
                  ]),
                ])
              ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Plan2()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PRIMARY,
                  ),
                  child: Center(
                    child: customTextWidget.boldText(
                        text: 'Continue', color: BLACK, size: ipad ? 35 : 25),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

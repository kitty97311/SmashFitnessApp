import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'package:exercise_app/LocalDatabase/ProgressClass.dart';
import 'package:exercise_app/LocalDatabase/HabitClass.dart';
import 'package:exercise_app/LocalDatabase/TrackerClass.dart';
import 'package:exercise_app/Screens/HabitList.dart';
import 'package:exercise_app/Screens/WaterSelect.dart';
import 'package:exercise_app/Screens/StepSelect.dart';
import '../CustomWidgets/CustomDialogues.dart';
import '../Themes.dart';
import '../main.dart';
import '../AllText.dart';
import '../globals.dart' as globals;

class Daily extends StatefulWidget {
  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  ValueNotifier<double> waterTrack = ValueNotifier(0);
  ValueNotifier<double> stepTrack = ValueNotifier(0);

  int totalWorkOuts = 0;
  int totalSeconds = 0;

  ProgressClass progressClass = ProgressClass();
  HabitClass habitClass = HabitClass();
  TrackerClass trackerClass = TrackerClass();

  List<Map<String, dynamic>> habitlist = [];
  List<Map<String, dynamic>> trackerlist = [];

  List<String> monthsList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  List<String> daysList = [
    "",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  @override
  void initState() {
    super.initState();
    readDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BLACK,
      body: body(),
    );
  }

  body() {
    double min = totalSeconds / 60;
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(children: [
              Row(children: [
                t.mediumText(text: 'Daily', color: PRIMARY, size: 20),
                // SizedBox(width: 10),
                // t.mediumText(text: 'Calendar', color: WHITE, size: 15),
                // SizedBox(width: 10),
                // t.mediumText(text: 'Data', color: WHITE, size: 15)
              ]),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(width: 50, height: 1, color: PRIMARY)),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            height: 180,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: GRAY,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    t.mediumText(
                                        text: 'Duration (min)',
                                        color: WHITE,
                                        size: 15),
                                    t.boldText(
                                        text: min.toStringAsFixed(2),
                                        color: PRIMARY,
                                        size: 40),
                                    t.mediumText(
                                        text: 'in Total',
                                        color: LIGHT_GREY_TEXT,
                                        size: 15),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          t.mediumText(
                                              text: 'This Week',
                                              color: WHITE,
                                              size: 15),
                                          t.mediumText(
                                              text: totalWorkOuts.toString(),
                                              color: LIGHT_GREY_TEXT,
                                              size: 15),
                                        ])
                                  ]),
                              Positioned(
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: LIGHT_GREY_TEXT),
                                  ))
                            ]))),
                    SizedBox(width: 16),
                    Expanded(
                        flex: 1,
                        child: Container(
                            height: 180,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: GRAY,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    t.mediumText(
                                        text: 'Weight (kg)',
                                        color: WHITE,
                                        size: 15),
                                    t.boldText(
                                        text: '75.0', color: PRIMARY, size: 40),
                                    t.mediumText(
                                        text: monthsList[
                                                DateTime.now().month - 1] +
                                            " ${DateTime.now().day}",
                                        color: LIGHT_GREY_TEXT,
                                        size: 15),
                                    SizedBox(height: 10),
                                    Container(
                                        width: double.infinity,
                                        height: 1,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        color: LIGHT_GREY_TEXT),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          t.mediumText(
                                              text: 'Last 30 Day',
                                              color: WHITE,
                                              size: 15),
                                          t.mediumText(
                                              text: '--',
                                              color: LIGHT_GREY_TEXT,
                                              size: 15),
                                        ])
                                  ]),
                              Positioned(
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: LIGHT_GREY_TEXT),
                                  ))
                            ])))
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: t.mediumText(
                          text: 'Habit Challenge', color: PRIMARY, size: 20)),
                  if (habitlist.isNotEmpty)
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HabitList()));
                        },
                        icon: Icon(Icons.add, color: PRIMARY))
                ],
              ),
              habitlist.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: GRAY,
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: PRIMARY,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Center(
                                                  child: t.boldText(
                                                      text: '1',
                                                      color: BLACK,
                                                      size: 15))),
                                          Container(
                                            width: 15,
                                            height: 5,
                                            color: PRIMARY,
                                          ),
                                          Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: PRIMARY,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Center(
                                                  child: t.boldText(
                                                      text: '2',
                                                      color: BLACK,
                                                      size: 15))),
                                          Container(
                                            width: 15,
                                            height: 5,
                                            color: PRIMARY,
                                          ),
                                          Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: LIGHT_GREY_TEXT,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Center(
                                                  child: t.boldText(
                                                      text: '3',
                                                      color: BLACK,
                                                      size: 15))),
                                          Container(
                                            width: 15,
                                            height: 5,
                                            color: LIGHT_GREY_TEXT,
                                          ),
                                          Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: LIGHT_GREY_TEXT,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Center(
                                                  child: t.boldText(
                                                      text: '4',
                                                      color: BLACK,
                                                      size: 15))),
                                          Container(
                                            width: 15,
                                            height: 5,
                                            color: LIGHT_GREY_TEXT,
                                          ),
                                          Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: LIGHT_GREY_TEXT,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Center(
                                                  child: t.boldText(
                                                      text: '5',
                                                      color: BLACK,
                                                      size: 15))),
                                        ]),
                                  ),
                                  Center(
                                    child: t.mediumText(
                                        text:
                                            'Take a small challenge\nand build good habits for health!',
                                        color: WHITE,
                                        size: 15,
                                        alignment: TextAlign.center),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 25),
                                      child: Center(
                                          child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HabitList()));
                                        },
                                        child: Container(
                                          width: 200,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: PRIMARY,
                                          ),
                                          child: Center(
                                            child: customTextWidget.boldText(
                                                text: 'Start',
                                                color: BLACK,
                                                size: 15),
                                          ),
                                        ),
                                      )))
                                ]),
                            Positioned(
                                right: 0,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: BLACK,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: SimpleCircularProgressBar(
                                      size: 50,
                                      progressColors: [PRIMARY],
                                      valueNotifier: ValueNotifier(30),
                                      backStrokeWidth: 0,
                                      progressStrokeWidth: 2,
                                      onGetText: (double value) {
                                        return Text('🌳',
                                            style: TextStyle(fontSize: 25));
                                      },
                                    ),
                                  ),
                                ))
                          ])))
                  : habitSection(),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            height: (trackerlist.isNotEmpty &&
                                    trackerlist[0]['date'] != '0')
                                ? 300
                                : 220,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: GRAY,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    t.mediumText(
                                        text: 'Step Tracker',
                                        color: WHITE,
                                        size: 15),
                                    SizedBox(height: 16),
                                    Center(
                                      child: SimpleCircularProgressBar(
                                        size: 100,
                                        backColor: BLACK,
                                        progressColors: [PRIMARY],
                                        valueNotifier: stepTrack,
                                        backStrokeWidth: 10,
                                        progressStrokeWidth: 4,
                                        onGetText: (double value) {
                                          String text = '';
                                          if (value.toInt() == 0)
                                            text = '🚶';
                                          else
                                            text = '🚶\n${value.toInt()}';
                                          return Text(text,
                                              style: TextStyle(
                                                  color: LIGHT_GREY_TEXT,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold));
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    t.mediumText(
                                        text:
                                            "🚶‍♂️ Track daily steps and keep you motivated!",
                                        color: WHITE,
                                        size: 12,
                                        alignment: TextAlign.center),
                                  ]),
                              Positioned(
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StepSelect()));
                                    },
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: LIGHT_GREY_TEXT),
                                  ))
                            ]))),
                    SizedBox(width: 16),
                    Expanded(
                        flex: 1,
                        child: Container(
                            height: (trackerlist.isNotEmpty &&
                                    trackerlist[0]['date'] != '0')
                                ? 300
                                : 220,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: GRAY,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    t.mediumText(
                                        text: 'Water Tracker',
                                        color: WHITE,
                                        size: 15),
                                    SizedBox(height: 16),
                                    Center(
                                      child: SimpleCircularProgressBar(
                                        size: 100,
                                        backColor: BLACK,
                                        progressColors: [BLUE],
                                        valueNotifier: waterTrack,
                                        backStrokeWidth: 10,
                                        progressStrokeWidth: 4,
                                        onGetText: (double value) {
                                          String text = '';
                                          if (value.toInt() == 0)
                                            text = '💧';
                                          else
                                            text = '💧\n${value.toInt()}';

                                          return Text(text,
                                              style: TextStyle(
                                                  color: LIGHT_GREY_TEXT,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold));
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    t.mediumText(
                                        text:
                                            "💧 Drink enough water to keep healthy!",
                                        color: WHITE,
                                        size: 12,
                                        alignment: TextAlign.center),
                                    if (trackerlist.isNotEmpty &&
                                        trackerlist[0]['date'] != '0' &&
                                        trackerlist[0]['cups'] != '0')
                                      Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  onTap: () {
                                                    int drink = int.parse(
                                                            trackerlist[0]
                                                                ['drink']) -
                                                        1;
                                                    if (drink < 0) return;
                                                    trackerClass.addWater(
                                                        dateTime:
                                                            DateTime.now(),
                                                        cups: trackerlist[0]
                                                            ['cups'],
                                                        drink:
                                                            drink.toString());
                                                    readDatabase();
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: PRIMARY),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: null,
                                                    ),
                                                    child: Center(
                                                      child: customTextWidget
                                                          .mediumText(
                                                              text: '-',
                                                              color: PRIMARY,
                                                              size: 25),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  onTap: () {
                                                    int drink = int.parse(
                                                            trackerlist[0]
                                                                ['drink']) +
                                                        1;
                                                    if (drink >
                                                        int.parse(trackerlist[0]
                                                            ['cups'])) return;
                                                    trackerClass.addWater(
                                                        dateTime:
                                                            DateTime.now(),
                                                        cups: trackerlist[0]
                                                            ['cups'],
                                                        drink:
                                                            drink.toString());
                                                    readDatabase();
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: PRIMARY,
                                                    ),
                                                    child: Center(
                                                      child: customTextWidget
                                                          .mediumText(
                                                              text: '+',
                                                              color: BLACK,
                                                              size: 25),
                                                    ),
                                                  ),
                                                )
                                              ]))
                                  ]),
                              Positioned(
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WaterSelect()));
                                    },
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: LIGHT_GREY_TEXT),
                                  ))
                            ]))),
                  ])),
            ])));
  }

  habitSection() {
    List<Widget> list = [];
    DateTime today = DateTime.now();
    for (var i = 0; i < habitlist.length; i++) {
      DateTime date = DateTime.parse(habitlist[i]['startDate']);
      int completed = int.parse(habitlist[i]['completed']);
      double percent = 100 * completed / int.parse(habitlist[i]['days']);
      List<Widget> circles = [];
      for (var ii = 0; ii < int.parse(habitlist[i]['days']); ii++) {
        DateTime nextDay = date.add(Duration(days: ii));
        circles.add(Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: completed - 1 >= ii ? PRIMARY : GRAY,
                border: Border.all(color: PRIMARY, width: 1),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
                child: t.mediumText(
                    text: nextDay.toString().substring(8, 10),
                    color: completed - 1 >= ii ? BLACK : PRIMARY,
                    size: 15))));
        circles.add(Container(
          width: 15,
          height: 5,
          color: PRIMARY,
        ));
      }
      circles.removeLast();
      list.add(Padding(
        padding: EdgeInsets.all(12),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                t.boldText(text: habitlist[i]['title'], size: 22, color: WHITE),
                t.mediumText(
                    text: '$completed/${habitlist[i]['days']} Day',
                    size: 20,
                    color: LIGHT_GREY_TEXT),
              ]),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: BLACK, borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: SimpleCircularProgressBar(
                    size: 50,
                    progressColors: [PRIMARY],
                    valueNotifier: ValueNotifier(percent),
                    backStrokeWidth: 0,
                    progressStrokeWidth: 2,
                    onGetText: (double value) {
                      return Text('🌳', style: TextStyle(fontSize: 25));
                    },
                  ),
                ),
              )
            ]),
      ));
      list.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: circles),
      ));
      if (percent < 100)
        list.add(Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
                child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                DateTime targetDay = date.add(Duration(days: completed));
                if (targetDay.toString().substring(0, 10) ==
                    today.toString().substring(0, 10)) {
                  habitClass.addData(index: i);
                  readDatabase();
                  showCustomDialog(
                      context: context,
                      title: 'Well Done!',
                      msg: "Your next challenge awaits tomorrow!",
                      btnYesText: OK,
                      onPressedBtnYes: () {
                        Navigator.pop(context);
                      });
                }
              },
              child: Container(
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: PRIMARY,
                ),
                child: Center(
                  child: customTextWidget.boldText(
                      text: 'Finish Day ${completed + 1}',
                      color: BLACK,
                      size: 15),
                ),
              ),
            ))));
    }
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
              color: GRAY, borderRadius: BorderRadius.circular(10)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: list),
        ));
  }

  readDatabase() async {
    List<ProgressClass> plist = [];
    totalWorkOuts = 0;
    totalSeconds = 0;

    DateTime startOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    for (int i = 0; i < 7; i++) {
      DateTime eachWeek = startOfWeek.add(Duration(days: i));
      List<ProgressClass> value =
          await progressClass.readData(dateTime: eachWeek);
      plist.clear();
      plist.addAll(value);
      for (int i = 0; i < plist.length; i++) {
        totalWorkOuts = totalWorkOuts + int.parse(plist[i].workOuts!);
        totalSeconds = totalSeconds + int.parse(plist[i].seconds!);
      }
    }

    habitlist = [];
    List<HabitClass> hlist = [];
    List<HabitClass> value = await habitClass.readData();
    hlist.clear();
    hlist.addAll(value);
    for (int i = 0; i < hlist.length; i++) {
      Map<String, dynamic> item = {};
      for (var element in globals.habitList) {
        if (element['id'].toString() == hlist[i].id)
          item['title'] = element['title'];
      }
      item['startDate'] = hlist[i].startDate;
      item['days'] = hlist[i].days;
      item['completed'] = hlist[i].completed;
      item['id'] = hlist[i].id;
      habitlist.add(item);
    }

    trackerlist = [];
    List<TrackerClass> tlist = [];
    List<TrackerClass> value1 =
        await trackerClass.readData(dateTime: DateTime.now());
    tlist.clear();
    tlist.addAll(value1);
    for (int i = 0; i < tlist.length; i++) {
      Map<String, dynamic> item = {};
      item['date'] = tlist[i].date;
      item['cups'] = tlist[i].cups;
      item['drink'] = tlist[i].drink;
      item['steps'] = tlist[i].steps;
      item['walk'] = tlist[i].walk;
      trackerlist.add(item);
    }
    if (trackerlist.isNotEmpty && trackerlist[0]['date'] != '0') {
      if (int.parse(trackerlist[0]['steps']) != 0)
        stepTrack.value = (100 *
            int.parse(trackerlist[0]['walk']) /
            int.parse(trackerlist[0]['steps']));
      if (int.parse(trackerlist[0]['cups']) != 0)
        waterTrack.value = (100 *
            int.parse(trackerlist[0]['drink']) /
            int.parse(trackerlist[0]['cups']));
    }
    print(trackerlist);
    if (mounted) {
      setState(() {});
    }
  }
}

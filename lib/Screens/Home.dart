import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise_app/LocalDatabase/ProgressClass.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/Modals/HomeClass.dart';
import 'package:exercise_app/Screens/AllWorkouts.dart';
import 'package:exercise_app/Screens/Stores.dart';
import 'package:exercise_app/Screens/Workout.dart';
import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/Screens/WorkoutCategoryScreen.dart';
import 'package:exercise_app/Themes.dart';
import 'package:exercise_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeClass? homeClass;
  List<HomeSection> list = [];
  List<Map<String, dynamic>> specialList = [];

  List<String> monthsList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  List<String> daysList = [
    "",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  int totalWorkOuts = 0;
  int totalCalories = 0;
  int maxValue = 0;
  int commitperweek = 0;
  int realcommitperweek = 0;

  ProgressClass progressClass = ProgressClass();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getHomeList();
    getHomeSpecialList();
    readDatabase();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: BLACK,
      body: body(),
    ));
  }

  body() {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: PRIMARY),
                  borderRadius: BorderRadius.circular(100)),
              child: t.mediumText(
                  text: daysList[DateTime.now().weekday] +
                      "," +
                      monthsList[DateTime.now().month - 1] +
                      " ${DateTime.now().day}",
                  color: PRIMARY,
                  size: 15)),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Smash',
                    style: TextStyle(
                      color: WHITE,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Stores()));
                },
                icon: SvgPicture.asset(
                  'assets/home/store.svg',
                  width: 30,
                  height: 30,
                  color: WHITE,
                ))
          ]),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              icon: Icon(
                Icons.search,
                color: LIGHT_GREY_TEXT,
              ),
              isCollapsed: true,
              hintText: 'Search',
              hintStyle: TextStyle(
                  color: TAB_GREY_DARK,
                  fontFamily: 'Bold',
                  fontSize: ipad ? 20 : 15),
            ),
            style: TextStyle(
                color: LIGHT_GREY_TEXT,
                fontFamily: 'Bold',
                fontSize: ipad ? 26 : 13),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: GRAY,
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                t.boldText(
                                    text: totalCalories.toString(),
                                    color: PRIMARY,
                                    size: 40),
                                t.mediumText(
                                    text: "Day Streal", color: WHITE, size: 15),
                                t.mediumText(
                                    text: "Personal Best: $maxValue",
                                    color: LIGHT_GREY_TEXT,
                                    size: 12),
                              ]),
                          Positioned(
                              right: 0,
                              child: t.mediumText(text: '🔥', size: 30))
                        ]))),
                SizedBox(width: 16),
                Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: GRAY,
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                t.boldText(
                                    text: '$realcommitperweek/$commitperweek',
                                    color: PRIMARY,
                                    size: 40),
                                t.mediumText(
                                    text: "This Week", color: WHITE, size: 15),
                                t.mediumText(
                                    text:
                                        "In Total: ${totalWorkOuts.toString()}",
                                    color: LIGHT_GREY_TEXT,
                                    size: 12),
                              ]),
                          Positioned(
                              right: 0,
                              child: t.mediumText(text: '🗓️', size: 30))
                        ]))),
              ])),
          Container(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                t.boldText(
                    text: 'Smash + Workout Programs', size: 18, color: PRIMARY)
              ],
            ),
            SizedBox(height: 10),
            specialList.isEmpty
                ? cardLoader(0)
                : Container(
                    height: 200,
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: specialList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> item = specialList[index];
                          return Container(
                            width: 280,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(children: [
                                    Container(
                                      width: double.infinity,
                                      height: 180,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: IMAGE_WORKOUT_SECTIONLive +
                                                item['img'] ??
                                            " ",
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Container(),
                                        errorWidget: (context, url, error) =>
                                            placeHolder(
                                                height: 180,
                                                width: 280,
                                                borderRadius: 10),
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 10,
                                      child: t.boldText(
                                        text: item['name']
                                            .toString()
                                            .replaceAll(' ', '\n'),
                                        color: WHITE,
                                        size: 25,
                                      ),
                                    ),
                                    Positioned(
                                        left: 10,
                                        bottom: 10,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WorkoutScreen(
                                                            item['id'] ?? 0,
                                                            item['name'],
                                                            'The lower abdomen and hips are the most difficult areas of the body to reduce when we are on a diet. Even so, in this area, especially the legs as a whole,',
                                                            100,
                                                            999,
                                                            item['img'],
                                                          )));
                                            },
                                            child: Container(
                                                width: 140,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: PRIMARY),
                                                child: Center(
                                                    child: t.boldText(
                                                  text: 'Start',
                                                  color: BLACK,
                                                  size: 14,
                                                )))))
                                  ]),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
          ])),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllWorkouts()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: PRIMARY),
                    borderRadius: BorderRadius.circular(10),
                    color: BLACK,
                  ),
                  child: Center(
                    child: customTextWidget.boldText(
                        text: 'Explore Smash + Workouts',
                        color: PRIMARY,
                        size: 20),
                  ),
                ),
              )),
          SizedBox(height: 10),
          homeClass == null
              ? ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return cardLoader(index);
                  },
                )
              : Container(
                  child: Column(
                  children: List.generate(
                      list.length,
                      (index) => card(list[index].id, list[index].category!,
                          list[index].list!, index)),
                )),
          SizedBox(height: 20),
        ],
      ),
    ));
  }

  cardLoader(int index) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: GRAY),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              loader(height: 20, width: 100, borderRadius: 3),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          loader(
                              height: 15, width: WIDTH * 0.6, borderRadius: 2),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          loader(
                              height: 15, width: WIDTH * 0.6, borderRadius: 2),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ],
      ),
    );
  }

  card(int? id, String category, List list, int index) => Container(
          child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            t.boldText(text: category, size: 18, color: PRIMARY),
            Spacer(),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WorkoutCategoryScreen(id ?? 0, category)));
                },
                child: Row(children: [
                  t.mediumText(text: 'All', size: 18, color: WHITE),
                  SizedBox(width: 2),
                  Icon(Icons.arrow_forward_ios, size: 15, color: WHITE)
                ])),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 280,
          child: ListView.builder(
              controller: scrollController,
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = list[index];
                int sec = item['time'] ?? 0;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkoutScreen(
                                  item['id'] ?? 0,
                                  item['title'],
                                  'The lower abdomen and hips are the most difficult areas of the body to reduce when we are on a diet. Even so, in this area, especially the legs as a whole,',
                                  100,
                                  999,
                                  item['img'],
                                )));
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 280,
                    margin: EdgeInsets.only(right: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(children: [
                            Container(
                              width: double.infinity,
                              height: 180,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    IMAGE_WORKOUT_SECTIONLive + item['img'] ??
                                        " ",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(),
                                errorWidget: (context, url, error) =>
                                    placeHolder(
                                        height: 180,
                                        width: 280,
                                        borderRadius: 10),
                              ),
                            ),
                            Positioned(
                                left: 10,
                                bottom: 10,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: LIGHT_GREY_TEXT),
                                    child: t.boldText(
                                      text: "$sec Secs",
                                      color: WHITE,
                                      size: 14,
                                    )))
                          ]),
                        ),
                        SizedBox(height: 10),
                        t.boldText(
                          text: item['title'],
                          color: WHITE,
                          size: 20,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(width: 2, height: 15, color: PRIMARY),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: t.regularText(
                                  text: item['level'] ?? '',
                                  color: WHITE,
                                  size: 15,
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                );
              }),
        ),
      ]));

  getHomeList() async {
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive + "/api/get_home"))
        .catchError((e) {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: e.toString(),
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    });

    final _jsonResponse = jsonDecode(_response.body);
    homeClass = HomeClass.fromJson(_jsonResponse);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      if (mounted) {
        setState(() {
          homeClass = HomeClass.fromJson(_jsonResponse);
        });
      }
      for (int j = 0; j < homeClass!.data!.length; j++) {
        if (homeClass!.data![j].list!.length > 0) {
          list.add(homeClass!.data![j]);
        }
      }
    } else {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: FAILED_TO_LOAD_DATA,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    }
  }

  getHomeSpecialList() async {
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive + "/api/get_home_special"))
        .catchError((e) {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: e.toString(),
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    });

    final _jsonResponse = jsonDecode(_response.body);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      for (int i = 0; i < _jsonResponse['data'].length; i++) {
        Map<String, dynamic> item = {};
        item['id'] = _jsonResponse['data'][i]['id'];
        item['name'] = _jsonResponse['data'][i]['name'];
        item['img'] = _jsonResponse['data'][i]['img'];
        specialList.add(item);
      }
      if (mounted) setState(() {});
    } else {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: FAILED_TO_LOAD_DATA,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    }
  }

  readDatabase() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    commitperweek = sp.getInt("commitperweek")!;

    List<ProgressClass> plist = [];
    List maxValueList = [];
    totalWorkOuts = 0;
    maxValue = 0;
    totalCalories = 0;

    DateTime startOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    for (int i = 0; i < 7; i++) {
      DateTime eachWeek = startOfWeek.add(Duration(days: i));
      List<ProgressClass> value =
          await progressClass.readData(dateTime: eachWeek);
      plist.clear();
      plist.addAll(value);
      int tempTotalWorkouts = 0;
      for (int i = 0; i < plist.length; i++) {
        maxValueList.add(int.parse(plist[i].calories!));
        totalWorkOuts = totalWorkOuts + int.parse(plist[i].workOuts!);
        tempTotalWorkouts = tempTotalWorkouts + int.parse(plist[i].workOuts!);
        totalCalories = totalCalories + int.parse(plist[i].calories!);
      }
      if (tempTotalWorkouts > 0) realcommitperweek++;
      maxValueList.sort();
      maxValue = maxValueList.last;
    }
    if (mounted) {
      setState(() {});
    }
  }
}

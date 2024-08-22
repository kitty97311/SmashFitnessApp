import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/CustomWidgets/CustomTextWidget.dart';
import 'package:exercise_app/Modals/HomeScreenClass.dart';
import 'package:exercise_app/Screens/Workout.dart';
import 'package:exercise_app/Themes.dart';
import 'package:exercise_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  HomeScreenClass? homeScreenClass;
  List<Exercise> list = [];

  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  bool showDialog = false;
  // AnimationController? controller;

  final predefinedColors = [
    Color(0xFF9935E0),
    Color(0xFF00B981),
    Color(0xFF35318D),
    Color(0xFFC7594B),
    Color(0xFFE16588),
    Color(0xFFEC5952),
    Colors.teal,
    Colors.brown,
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.pink[300],
    Colors.cyan[700],
    Colors.deepOrange[200],
    Colors.deepPurpleAccent,
    Colors.deepPurple,
  ];

  CustomTextWidget customTextWidget = CustomTextWidget();

  @override
  void initState() {
    // TODO: implement initState
    getExercisesList();
    // controller = AnimationController(vsync: this);
    FirebaseMessaging.onMessage.listen((event) {
      notificationHelper.showNotification(
          title: event.notification!.title!,
          body: event.notification!.body!,
          payload: "payload",
          id: "124",
          context2: context);
    });

    // firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     print("\n\n"+message.toString());
    //     notificationHelper.showNotification(title: message['notification']['title'],body: message['notification']['body'] ,payload: "payload", id: "124", context2: context);
    //   },
    //   //onBackgroundMessage: myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     print("\n\n"+message.toString());
    //     // if(message['data']['type'] == "user_id"){
    //     //   Navigator.push(context,
    //     //     MaterialPageRoute(builder: (context) => UserAppointmentDetails(message['data']['order_id'].toString())),
    //     //   );
    //     // }
    //     // else if(message['data']['type'] == "doctor_id"){
    //     //   Navigator.push(context,
    //     //     MaterialPageRoute(builder: (context) => DoctorAppointmentDetails(message['data']['order_id'].toString())),
    //     //   );
    //     // }
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     print("\n\n"+message['data'].toString());
    //     // if(message['data']['type'] == "user_id"){
    //     //   Navigator.push(context,
    //     //     MaterialPageRoute(builder: (context) => UserAppointmentDetails(message['data']['order_id'].toString())),
    //     //   );
    //     // }
    //     // else if(message['data']['type'] == "doctor_id"){
    //     //   Navigator.push(context,
    //     //     MaterialPageRoute(builder: (context) => DoctorAppointmentDetails(message['data']['order_id'].toString())),
    //     //   );
    //     // }
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: body(),
    ));
  }

  body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextWidget.regularText(
                  text: FIND_YOUR, size: ipad ? 40 : 20, color: DARK_BLUE),
              customTextWidget.boldText(
                  text: FAVOURITE_WORKOUT_PLAN,
                  size: ipad ? 50 : 25,
                  color: DARK_BLUE),
              homeScreenClass == null
                  ? ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return myFavouriteExerciseCardLoader(index);
                      },
                    )
                  : AnimatedList(
                      key: listKey,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      initialItemCount: list.length - 1,
                      itemBuilder: (context, index, animation) {
                        return myFavouriteExerciseCard(index, animation);
                      })
            ],
          ),
        ),
      ),
    );
  }

  myFavouriteExerciseCard(int index, Animation animation) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        print("=====> Total Exercise ${list[index].totalExercise}");
        print("=====> Total id ${list[index].id}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WorkoutScreen(
                      list[index].id!,
                      list[index].name!,
                      list[index].description!,
                      list[index].time!,
                      list[index].calories!,
                      list[index].image!,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: predefinedColors[index < 10 ? index : index % 10]),
        padding: EdgeInsets.fromLTRB(15, 20, 8, 10),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CachedNetworkImage(
                  fit: BoxFit.contain,
                  height: 140,
                  width: 125,
                  imageUrl: IMAGE_ADDRESS_HOMELive + list[index].image! ?? " ",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(),
                  errorWidget: (context, url, error) =>
                      placeHolder(height: 140, width: 130, borderRadius: 10),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextWidget.mediumText(
                    text: list[index].name ?? "7M Beginner",
                    size: ipad ? 40 : 20,
                    color: WHITE),
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
                            Image.asset(
                              "assets/home/excercise.png",
                              height: ipad ? 30 : 15,
                              width: ipad ? 30 : 15,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: ipad ? 6 : 3,
                            ),
                            customTextWidget.lightText(
                                text: list[index].totalExercise.toString() +
                                        " " +
                                        EXERCISES[LANGUAGE_TYPE] ??
                                    " ",
                                size: ipad ? 24 : 12,
                                color: WHITE)
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/home/calories.png",
                              height: ipad ? 30 : 15,
                              width: ipad ? 30 : 15,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: ipad ? 6 : 3,
                            ),
                            customTextWidget.lightText(
                                text: list[index].calories.toString() +
                                        " " +
                                        CALORIES_SMALL[LANGUAGE_TYPE] ??
                                    " ",
                                size: ipad ? 24 : 12,
                                color: WHITE)
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/home/clock.png",
                              height: ipad ? 30 : 15,
                              width: ipad ? 30 : 15,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: ipad ? 6 : 3,
                            ),
                            customTextWidget.lightText(
                                text: list[index].time.toString() +
                                        " " +
                                        MINUTES_SMALL[LANGUAGE_TYPE] ??
                                    " ",
                                size: ipad ? 24 : 12,
                                color: WHITE)
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/home/star.png",
                              height: ipad ? 30 : 15,
                              width: ipad ? 30 : 15,
                              color: WHITE,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: ipad ? 6 : 3,
                            ),
                            customTextWidget.lightText(
                                text: list[index].level ?? " ",
                                size: ipad ? 24 : 12,
                                color: WHITE)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      height: ipad ? 40 : 32,
                      width: ipad ? 40 : 32,
                      decoration: BoxDecoration(
                        color: WHITE.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: WHITE,
                          size: ipad ? 25 : 18,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  myFavouriteExerciseCardLoader(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: LIGHT_GREY_SCREEN_BACKGROUND),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              loader(height: 20, width: 80, borderRadius: 3),
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
                          Image.asset(
                            "assets/home/excercise.png",
                            height: ipad ? 30 : 15,
                            width: ipad ? 30 : 15,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          loader(height: 15, width: 65, borderRadius: 2),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/home/calories.png",
                            height: ipad ? 30 : 15,
                            width: ipad ? 30 : 15,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          loader(height: 15, width: 65, borderRadius: 2),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/home/clock.png",
                            height: ipad ? 30 : 15,
                            width: ipad ? 30 : 15,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          loader(height: 15, width: 65, borderRadius: 2),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/home/star.png",
                            height: ipad ? 30 : 15,
                            width: ipad ? 30 : 15,
                            color: WHITE,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          loader(height: 15, width: 65, borderRadius: 2),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  loader(height: 35, width: 35, borderRadius: 17),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  getExercisesList() async {
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive + "/api/get_set_by_category"))
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
    print("HomeScreen/" + SERVER_ADDRESSLive + "/api/get_set_by_category");
    print(
        'homescreen--------------- get_set_by_category -------${Uri.parse(SERVER_ADDRESSLive + "/api/get_set_by_category")}');
    final _jsonResponse = jsonDecode(_response.body);
    homeScreenClass = HomeScreenClass.fromJson(_jsonResponse);
    print("HomeScreen/" + _jsonResponse.toString());
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      if (mounted) {
        setState(() {
          homeScreenClass = HomeScreenClass.fromJson(_jsonResponse);
        });
      }

      for (int j = 0; j < homeScreenClass!.data!.length; j++) {
        list.insert(j, homeScreenClass!.data![j]);
        await Future.delayed(Duration(milliseconds: 200));
        if (mounted) {
          listKey.currentState!.insertItem(j);
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
      print("HomeScreen/error/");
    }
  }
}

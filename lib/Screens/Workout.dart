import 'dart:convert';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise_app/Modals/ExercisesClass.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseMp4.dart';
import 'package:exercise_app/Screens/IntroSlider.dart';
import 'package:exercise_app/Screens/ReadyScreen.dart';
import 'package:exercise_app/Screens/StartExerciseTabScreen.dart';
import 'package:exercise_app/testing/MyVideoPlayer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'StartExercise.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseYoutube.dart';
import 'package:flutter/material.dart';

import '../AllText.dart';
import '../Themes.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';

class WorkoutScreen extends StatefulWidget {
  int workout_id;
  String workout_name;
  String workout_description;
  int total_time;
  int total_calories;
  String image_url;

  WorkoutScreen(this.workout_id, this.workout_name, this.workout_description,
      this.total_time, this.total_calories, this.image_url);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  ExercisesClass? exercisesClass;
  List<Create> list = [];
  int totalCalories = 0;
  int totalTimes = 0;
  int x = 7;
  String myMsg = MY_MSG[LANGUAGE_TYPE];
  bool showDialog = false;
  Timer textAnimationTimer = Timer(Duration(seconds: 1), () {});
  String animatedMsg = "";
  // InterstitialAd _interstitialAd;

  BannerAd? banner;

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: getBannerAdUnitId()!,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            banner = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    getExercisesbyWorkoutList();
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
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
        title: t.boldText(text: widget.workout_name, color: WHITE, size: 20),
        centerTitle: true,
      ),
      body: body(),
      bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StartExercise(
                  createList: list,
                  intervalTime: 5,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PRIMARY,
            ),
            child: Center(
              child: customTextWidget.boldText(
                  text: 'Start', color: BLACK, size: 20),
            ),
          ),
        ),
      ),
    );
  }

  body() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: double.infinity,
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: IMAGE_WORKOUT_SECTIONLive + widget.image_url ?? " ",
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Container(),
          errorWidget: (context, url, error) =>
              placeHolder(height: 200, width: 280, borderRadius: 10),
        ),
        // child: MyVideoPlayer('url'),
      ),
      Center(
        child: Container(
            width: 300,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: GRAY, borderRadius: BorderRadius.circular(15)),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: PRIMARY, borderRadius: BorderRadius.circular(5)),
                  child: Image.asset('assets/excercises/ic_time.png')),
              SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                t.mediumText(text: 'Time', size: 12, color: WHITE),
                t.mediumText(text: '$totalTimes sec', size: 15, color: WHITE),
              ]),
              Spacer(),
              Container(
                width: 1,
                height: 40,
                color: LIGHT_GREY_TEXT,
              ),
              Spacer(),
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: PRIMARY, borderRadius: BorderRadius.circular(5)),
                  child: Image.asset('assets/excercises/ic_burn.png')),
              SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                t.mediumText(text: 'Burn', size: 12, color: WHITE),
                t.mediumText(
                    text: '$totalCalories kcal', size: 15, color: WHITE),
              ])
            ])),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: t.boldText(text: widget.workout_name, size: 25, color: WHITE),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: t.mediumText(
            text: widget.workout_description, size: 15, color: LIGHT_GREY_TEXT),
      ),
      // Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      //     child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      //       t.boldText(text: 'Rounds', size: 20, color: PRIMARY),
      //       Spacer(),
      //       t.boldText(text: '1', size: 18, color: WHITE),
      //       t.mediumText(text: '/', size: 15, color: WHITE),
      //       t.mediumText(text: '8', size: 15, color: WHITE),
      //     ])),
      Container(
        child: Column(
            children: List.generate(
                list.length,
                (index) => tile(list[index].id!, list[index].image!,
                    list[index].name!, list[index].time!, index))),
      )
    ]));
  }

  tile(int id, String img, String title, String time, int index) {
    int second = int.parse(time) % 60;
    int min = int.parse(time) ~/ 60;
    String mins = min < 10 ? '0$min' : min.toString();
    String secs = second < 10 ? '0$second' : second.toString();
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PLAY_YOUTUBE_VIDEOS
                      ? HowToExerciseYoutube(id.toString())
                      : HowToExerciseMp4(id.toString())));
        },
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: GRAY),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: IMAGE_URL_MENU_ITEMLive + img ?? " ",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Container(),
                    errorWidget: (context, url, error) =>
                        placeHolder(height: 60, width: 60, borderRadius: 10),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                t.mediumText(text: title, size: 15, color: WHITE),
                SizedBox(height: 5),
                t.mediumText(
                    text: '$mins:$secs', size: 14, color: LIGHT_GREY_TEXT),
              ]),
              Spacer(),
              Image.asset('assets/excercises/play.png')
            ])));
  }

  getExercisesbyWorkoutList() async {
    totalCalories = 0;
    totalTimes = 0;
    final _response = await http.post(Uri.parse(SERVER_ADDRESSLive +
        "/api/get_workout?workout_id=" +
        widget.workout_id.toString()));
    final _jsonResponse = jsonDecode(_response.body);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      setState(() {
        exercisesClass = ExercisesClass.fromJson(_jsonResponse);
      });
      for (int j = 0; j < exercisesClass!.data!.length; j++) {
        list.insert(j, exercisesClass!.data![j]);
        totalCalories =
            totalCalories + int.parse(exercisesClass!.data![j].calories!);
        totalTimes = totalTimes + int.parse(exercisesClass!.data![j].time!);
      }
      setState(() {});
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

  // Widget exercisesCard(
  //     List<Create> list, int index, Animation<double> animation) {
  //   print('list=====> ${list.length}');
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       SizeTransition(
  //         sizeFactor: animation,
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 8, bottom: 8),
  //           child: Container(
  //             color: WHITE,
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: InkWell(
  //                     onTap: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => PLAY_YOUTUBE_VIDEOS
  //                                   ? HowToExerciseYoutube(
  //                                       list[index].id.toString(),
  //                                     )
  //                                   : HowToExerciseMp4(
  //                                       list[index].id.toString(),
  //                                     )));
  //                     },
  //                     child: Row(
  //                       children: [
  //                         Container(
  //                           height: 70,
  //                           decoration: BoxDecoration(
  //                               color: BACK_GREY,
  //                               borderRadius: BorderRadius.circular(12)),
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(12),
  //                             child: CachedNetworkImage(
  //                               fit: BoxFit.cover,
  //                               height: HEIGHT * 0.20,
  //                               width: WIDTH * 0.20,
  //                               imageUrl: IMAGE_URL_MENU_ITEMLive +
  //                                       list[index].image! ??
  //                                   " ",
  //                               progressIndicatorBuilder:
  //                                   (context, url, downloadProgress) =>
  //                                       Container(),
  //                               errorWidget: (context, url, error) =>
  //                                   placeHolder(
  //                                 height: 65,
  //                                 width: 70,
  //                                 borderRadius: 10,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Expanded(
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 customTextWidget.mediumText(
  //                                     text: list[index].name,
  //                                     size: ipad ? 34 : 18,
  //                                     color: BLACK,
  //                                     textOverFlow: TextOverflow.ellipsis),
  //                                 SizedBox(height: 8),
  //                                 customTextWidget.mediumText(
  //                                     text: "X " +
  //                                             list[index]
  //                                                 .repeatCount
  //                                                 .toString() ??
  //                                         " ",
  //                                     color: LIGHT_GREY_TEXT,
  //                                     size: ipad ? 28 : 14),
  //                               ],
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => PLAY_YOUTUBE_VIDEOS
  //                                 ? HowToExerciseYoutube(
  //                                     list[index].id.toString())
  //                                 : HowToExerciseMp4(
  //                                     list[index].id.toString())));
  //                     // HowToExerciseYoutube(ex_id: exercisesClass.data.exercise.create[index].id) : HowToExerciseMp4(ex_id: exercisesClass.data.exercise.create[index].id)));
  //                   },
  //                   child: Container(
  //                     height: 70,
  //                     child: Padding(
  //                       padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
  //                       child: Image.asset("assets/detail.png"),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       DISPLAY_ADS && (index + 1) % 4 == 0 && banner != null
  //           ? AdWidget(
  //               ad: banner!,
  //             )
  //           : SizedBox(),
  //     ],
  //   );
  // }

  // Widget exercisesCardLoader() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8, bottom: 8),
  //     child: Container(
  //       height: 70,
  //       color: WHITE,
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Row(
  //               children: [
  //                 Container(
  //                   decoration: BoxDecoration(
  //                       color: BACK_GREY,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: loader(height: 60, width: 60, borderRadius: 3),
  //                 ),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       loader(height: 12, width: 150, borderRadius: 3),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       loader(height: 15, width: 100, borderRadius: 3),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           loader(height: 50, width: 50, borderRadius: 25)
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

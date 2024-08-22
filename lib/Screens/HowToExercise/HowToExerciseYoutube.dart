import 'dart:convert';

import 'package:exercise_app/Modals/HowToExerciseClass.dart';
import 'package:exercise_app/Modals/HowToExerciseClass.dart' as hte;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../AllText.dart';
import '../../Themes.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';

class HowToExerciseYoutube extends StatefulWidget {
  String ex_id;

  HowToExerciseYoutube(this.ex_id);

  @override
  _HowToExerciseYoutubeState createState() => _HowToExerciseYoutubeState();
}

class _HowToExerciseYoutubeState extends State<HowToExerciseYoutube> {
  HowToExerciseClass? howToexerciseClass;
  List<hte.Step> list = [];
  String url = "";
  YoutubePlayerController? _controller;
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  BannerAd? banner;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getExercisesSteps();

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
  }

  //String videoId=YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=BBAyRBTfsOU");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: BLACK,
      body: Column(
        children: [
          Expanded(
            child: list.isEmpty || howToexerciseClass == null
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SingleChildScrollView(
                    child: YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _controller!,
                        ),
                        builder: (context, player) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              AppBar(
                                toolbarHeight: 45,
                                backgroundColor: BLACK,
                                elevation: 0,
                                flexibleSpace: customDialogues.header(
                                  text: "",
                                  context: context,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  child: customTextWidget.boldText(
                                      text: HOW_TO_EXERCISE,
                                      size: ipad ? 60 : 33,
                                      color: WHITE),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(height: 200, child: player),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                color: BLACK,
                                child: list.isEmpty
                                    ? ListView.builder(
                                        itemCount: 10,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return exercisesStepsCardLoader();
                                        })
                                    : AnimatedList(
                                        key: listKey,
                                        initialItemCount: list.length - 1,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (BuildContext builder,
                                            int index, animation) {
                                          return exercisesStepsCard(
                                              list, index, animation);
                                        }),
                              ),
                            ],
                          );
                        }),
                  ),
          ),
          DISPLAY_ADS && banner != null
              ? AdWidget(
                  ad: banner!,
                )
              : SizedBox(),
        ],
      ),
    ));
  }

  getExercisesSteps() async {
    final _response = await http.get(Uri.parse(SERVER_ADDRESSLive +
        "/api/get_exercise_step_list?ex_id=" +
        widget.ex_id));
    final _jsonResponse = jsonDecode(_response.body);
    print("HowToExercise/" +
        SERVER_ADDRESSLive +
        "/api/get_exercise_step_list.php?ex_id=" +
        widget.ex_id);
    print(
        'get_exercise_step_list.php---------${Uri.parse(SERVER_ADDRESSLive + "/api/get_exercise_step_list?ex_id=" + widget.ex_id)}');
    print("HowToExercise/" + _jsonResponse.toString());

    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      setState(() {
        howToexerciseClass = HowToExerciseClass.fromJson(_jsonResponse);
        //list=howToexerciseClass.exercise.step;
        url = howToexerciseClass!.exercise!.url!;

        url = "https://www.youtube.com/watch?v=BBAyRBTfsOU";
      });

      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url) ?? '',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );

      for (int j = 0; j < howToexerciseClass!.exercise!.step!.length; j++) {
        list.insert(j, howToexerciseClass!.exercise!.step![j]);
        await Future.delayed(Duration(milliseconds: 200));
        listKey.currentState!.insertItem(j);
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
      print("HowToExercise/error/");
    }
  }

  Widget exercisesStepsCard(List list, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        color: GRAY,
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15,
                ),
                customTextWidget.boldText(
                    text: index < 9
                        ? "0" + (index + 1).toString()
                        : "${index + 1}",
                    size: 25,
                    color: WHITE),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                  color: WHITE,
                ))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12),
                  child: customTextWidget.mediumText(
                      text: list[index].step,
                      size: ipad ? 24 : 12,
                      color: WHITE),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget exercisesStepsCardLoader() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(16.0),
      height: 75,
      color: BACK_GREY,
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 15,
              ),
              loader(
                height: 50,
                width: 50,
                borderRadius: 5,
              ),
              SizedBox(
                width: 15,
              ),
              VerticalDivider(
                width: 1,
                color: LIGHT_GREY_TEXT,
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: loader(
                  height: 10,
                  width: 100,
                  borderRadius: 5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

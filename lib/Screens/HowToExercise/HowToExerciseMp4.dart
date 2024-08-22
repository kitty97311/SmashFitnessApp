import 'dart:convert';

import 'package:exercise_app/Modals/HowToExerciseClass.dart';
import 'package:exercise_app/Modals/HowToExerciseClass.dart' as hte;
import 'package:exercise_app/testing/MyVideoPlayer.dart';
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

class HowToExerciseMp4 extends StatefulWidget {
  String ex_id;

  HowToExerciseMp4(this.ex_id);

  @override
  _HowToExerciseMp4State createState() => _HowToExerciseMp4State();
}

class _HowToExerciseMp4State extends State<HowToExerciseMp4> {
  HowToExerciseClass? howToexerciseClass;
  List<hte.Step> list = [];
  String url = "";
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
      backgroundColor: WHITE,
      appBar: AppBar(
        toolbarHeight: 45,
        leading: Container(),
        backgroundColor: WHITE,
        elevation: 0,
        flexibleSpace: customDialogues.header(
          text: "",
          context: context,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      child: customTextWidget.boldText(
                          text: HOW_TO_EXERCISE, size: 33, color: BLACK),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 200,
                    color: BLACK,
                    child: list.isEmpty || howToexerciseClass == null
                        ? Container()
                        : MyVideoPlayer(howToexerciseClass!.exercise!.url!),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  list.isEmpty
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
                          itemBuilder:
                              (BuildContext builder, int index, animation) {
                            return exercisesStepsCard(list, index, animation);
                          }),
                ],
              ),
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
        "/api/get_exercise_step_list?ex_id=" +
        widget.ex_id);
    print(
        'get_exercise_step_list-------->${Uri.parse(SERVER_ADDRESSLive + "/api/get_exercise_step_list?ex_id=" + widget.ex_id)}');
    print("HowToExercise/" + _jsonResponse.toString());

    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      setState(() {
        howToexerciseClass = HowToExerciseClass.fromJson(_jsonResponse);
        //list=howToexerciseClass.exercise.step;
        url = howToexerciseClass!.exercise!.url!;

        // url="https://www.youtube.com/watch?v=BBAyRBTfsOU";
      });

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
        color: BACK_GREY,
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
                    color: BLACK),
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
                  color: LIGHT_GREY_TEXT,
                ))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12),
                  child: customTextWidget.mediumText(
                      text: list[index].step, size: 12, color: DARK_GREY_TEXT),
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

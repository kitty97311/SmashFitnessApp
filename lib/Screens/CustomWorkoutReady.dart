import 'package:exercise_app/Screens/ReadyScreen.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/Screens/StartExercise.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Themes.dart';
import '../main.dart';

class CustomWorkoutReady extends StatefulWidget {
  int? totalTime;
  int? totalCalories;
  String? name;
  List? createList;
  List? extraList;
  int? intervalTime;
  CustomWorkoutReady(
      {this.totalTime,
      this.totalCalories,
      this.name,
      this.createList,
      this.extraList,
      this.intervalTime});
  @override
  _CustomWorkoutReadyState createState() => _CustomWorkoutReadyState();
}

class _CustomWorkoutReadyState extends State<CustomWorkoutReady> {
  List list = [];

  @override
  void initState() {
    super.initState();
    list.addAll(widget.extraList!);
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
        title: t.boldText(text: widget.name, color: WHITE, size: 20),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(
        child: Container(
            width: 300,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 20),
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
                t.mediumText(
                    text: '${widget.totalTime} secs', size: 15, color: WHITE),
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
                    text: '${widget.totalCalories} kcal',
                    size: 15,
                    color: WHITE),
              ])
            ])),
      ),
      SingleChildScrollView(
        child: Column(
            children: List.generate(list.length, (index) => tile(index))),
      ),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StartExercise(
                    createList: widget.createList,
                    intervalTime: widget.intervalTime ?? 0,
                  ),
                ),
              );

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ReadyScreen()));
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
                    text: 'Start Workout', color: BLACK, size: ipad ? 35 : 25),
              ),
            ),
          )),
    ]));
  }

  tile(int index) {
    int sets = list[index]['set'].length;
    int rest = list[index]['interval'];
    bool superset = list[index]['superset'];
    double marginbottom = 0;
    if (index < list.length - 1)
      marginbottom = (list[index]['superset'] == true &&
              list[index + 1]['superset'] == true &&
              list[index]['sort'] == list[index + 1]['sort'])
          ? 0
          : 4;
    else
      marginbottom = 4;
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.fromLTRB(16, 0, 16, marginbottom),
        color: GRAY,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (index < list.length - 1 &&
              list[index]['superset'] == true &&
              list[index + 1]['superset'] == true &&
              list[index]['sort'] == list[index + 1]['sort'])
            t.boldText(text: 'Superset', size: 20, color: WHITE),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: 50,
              height: 50,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: IMAGE_URL_MENU_ITEMLive + list[index]['image'],
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(),
                      errorWidget: (context, url, error) =>
                          placeHolder(borderRadius: 10))),
            ),
            SizedBox(width: 15),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              t.mediumText(text: list[index]['name'], size: 15, color: WHITE),
              t.mediumText(text: 'Sets : $sets', size: 12, color: PRIMARY),
              t.mediumText(text: 'Rest : $rest', size: 12, color: PRIMARY),
              if (superset)
                t.mediumText(
                    text: 'superset', size: 12, color: LIGHT_GREY_TEXT),
            ]),
          ])
        ]));
  }
}

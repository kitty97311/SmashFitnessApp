import 'package:exercise_app/Modals/WorkoutClass.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/Screens/Workout.dart';
import 'package:exercise_app/AllText.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

import '../Themes.dart';
import '../main.dart';

class WorkoutListScreen extends StatefulWidget {
  int id;
  String title;
  String type;
  WorkoutListScreen(this.id, this.title, this.type);
  @override
  _WorkoutListScreenState createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  WorkoutClass? workoutClass;
  List<Workout> list = [];

  @override
  void initState() {
    super.initState();
    getWorkoutList();
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
        title: t.boldText(text: widget.title, color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(children: [
        workoutClass == null
            ? ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return tileLoader(index);
                },
              )
            : list.isEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                        child: t.mediumText(
                            text: 'No Data', color: WHITE, size: 20)))
                : Container(
                    child: Column(
                        children: List.generate(
                            list.length,
                            (index) => tile(
                                list[index].id,
                                list[index].img!,
                                list[index].name!,
                                list[index].time!,
                                list[index].level!,
                                index)))),
      ]),
    );
  }

  tileLoader(int index) {
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

  tile(int? id, String img, String title, int time, String level, int index) =>
      InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WorkoutScreen(
                          id ?? 0,
                          title,
                          'The lower abdomen and hips are the most difficult areas of the body to reduce when we are on a diet. Even so, in this area, especially the legs as a whole,',
                          time,
                          999,
                          img,
                        )));
          },
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: GRAY),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: IMAGE_WORKOUT_SECTIONLive + img ?? " ",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(),
                      errorWidget: (context, url, error) => placeHolder(
                          height: 180, width: 280, borderRadius: 10),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                t.boldText(text: title, size: 15, color: WHITE),
                Spacer(),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: 5),
                  Row(children: [
                    t.mediumText(text: 'Duration : ', size: 12, color: WHITE),
                    t.mediumText(
                        text: time.toString(), size: 12, color: PRIMARY),
                  ]),
                  SizedBox(height: 5),
                  Row(children: [
                    t.mediumText(text: 'Level : ', size: 12, color: WHITE),
                    t.mediumText(text: level, size: 12, color: PRIMARY),
                  ]),
                ])
              ])));

  getWorkoutList() async {
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive + "/api/get_workout_set"))
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
    workoutClass = WorkoutClass.fromJson(_jsonResponse);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      if (mounted) {
        setState(() {
          workoutClass = WorkoutClass.fromJson(_jsonResponse);
        });
      }
      for (int j = 0; j < workoutClass!.data!.length; j++) {
        if (widget.type == 'smash' &&
            workoutClass!.data![j].sub_smash_id == widget.id) {
          list.add(workoutClass!.data![j]);
        }
        if (widget.type == 'plus' &&
            workoutClass!.data![j].sub_smashplus_id == widget.id) {
          list.add(workoutClass!.data![j]);
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
}

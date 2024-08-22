import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/Screens/Workout.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Themes.dart';
import '../main.dart';

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List list = [];

  @override
  void initState() {
    super.initState();
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
        title: t.boldText(text: 'Favorite Workouts', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(children: [
        list.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Icon(Icons.view_list_rounded,
                              color: WHITE, size: 50)),
                      SizedBox(height: 20),
                      Center(
                          child: t.mediumText(
                              text: 'No Favorite Data', color: WHITE, size: 20))
                    ]))
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
}

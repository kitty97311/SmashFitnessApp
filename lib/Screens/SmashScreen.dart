import 'dart:convert';
import 'package:exercise_app/Screens/SmashCategoryScreen.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/Modals/SmashPlusClass.dart';
import 'package:exercise_app/Screens/Workout.dart';
import 'package:exercise_app/AllText.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import '../Themes.dart';
import '../main.dart';

class SmashScreen extends StatefulWidget {
  @override
  _SmashScreenState createState() => _SmashScreenState();
}

class _SmashScreenState extends State<SmashScreen> {
  SmashPlusClass? smashplusClass;
  List<SmashPlusSection> list = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getSmashList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BLACK,
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Smash ',
                        style: TextStyle(
                          color: WHITE,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      TextSpan(
                        text: '+',
                        style: TextStyle(
                          color: PRIMARY,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 50,
                    height: 2,
                    margin: EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: PRIMARY)),
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
                )
              ],
            ),
          ),
          smashplusClass == null
              ? ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
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
    );
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
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
                                SmashCategoryScreen(id ?? 0, category)));
                  },
                  child: Row(children: [
                    t.mediumText(text: 'All', size: 18, color: WHITE),
                    SizedBox(width: 2),
                    Icon(Icons.arrow_forward_ios, size: 15, color: WHITE)
                  ])),
            ],
          ),
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
                    margin: EdgeInsets.all(10),
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
                                  text: item['level'],
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

  getSmashList() async {
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive + "/api/get_smashplus"))
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
    smashplusClass = SmashPlusClass.fromJson(_jsonResponse);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      if (mounted) {
        setState(() {
          smashplusClass = SmashPlusClass.fromJson(_jsonResponse);
        });
      }
      for (int j = 0; j < smashplusClass!.data!.length; j++) {
        if (smashplusClass!.data![j].list!.length > 0) {
          list.add(smashplusClass!.data![j]);
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

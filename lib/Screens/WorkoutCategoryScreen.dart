import 'package:exercise_app/Screens/WorkoutListScreen.dart';
import 'package:exercise_app/Modals/SubSmashClass.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/AllText.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

import '../Themes.dart';
import '../main.dart';

class WorkoutCategoryScreen extends StatefulWidget {
  int id;
  String title;

  WorkoutCategoryScreen(this.id, this.title);

  @override
  _WorkoutCategoryScreenState createState() => _WorkoutCategoryScreenState();
}

class _WorkoutCategoryScreenState extends State<WorkoutCategoryScreen> {
  SubSmashClass? subsmashClass;
  List<SubSmash> list = [];

  @override
  void initState() {
    super.initState();
    getSubSmashList();
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
        subsmashClass == null
            ? ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return cardLoader(index);
                },
              )
            : list.isEmpty
                ? Container(
                    child:
                        t.mediumText(text: 'No Data', color: WHITE, size: 20))
                : Container(
                    child: Column(
                        children: List.generate(
                            list.length,
                            (index) => card(list[index].id, list[index].img!,
                                list[index].name!, 0, index)))),
      ]),
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

  card(int? id, String img, String title, int level, int index) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WorkoutListScreen(id ?? 0, title, 'smash')));
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Stack(children: [
            Container(
              width: double.infinity,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: IMAGE_HOME_SECTIONLive + img ?? " ",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(),
                  errorWidget: (context, url, error) =>
                      placeHolder(height: 180, width: 280, borderRadius: 10),
                ),
              ),
            ),
            if (level == 0)
              Positioned(
                  bottom: 0,
                  child: Container(
                      width: 150,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: PRIMARY,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: t.boldText(
                          text: title.toUpperCase(), size: 18, color: BLACK))),
            if (level != 0)
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          color: LIGHT_GREY_TEXT,
                          borderRadius: BorderRadius.circular(5)),
                      child: t.boldText(text: 'PRO', size: 12, color: WHITE)))
          ])));

  getSubSmashList() async {
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive + "/api/get_sub_smash"))
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
    subsmashClass = SubSmashClass.fromJson(_jsonResponse);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      if (mounted) {
        setState(() {
          subsmashClass = SubSmashClass.fromJson(_jsonResponse);
        });
      }
      for (int j = 0; j < subsmashClass!.data!.length; j++) {
        if (subsmashClass!.data![j].smash_id == widget.id) {
          list.add(subsmashClass!.data![j]);
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

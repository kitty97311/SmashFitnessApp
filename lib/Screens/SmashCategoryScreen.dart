import 'package:exercise_app/Screens/WorkoutListScreen.dart';
import 'package:exercise_app/Modals/SubSmashPlusClass.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/AllText.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

import '../Themes.dart';
import '../main.dart';

class SmashCategoryScreen extends StatefulWidget {
  int id;
  String title;

  SmashCategoryScreen(this.id, this.title);

  @override
  _SmashCategoryScreenState createState() => _SmashCategoryScreenState();
}

class _SmashCategoryScreenState extends State<SmashCategoryScreen> {
  SubSmashPlusClass? subsmashplusClass;
  List<SubSmashPlus> list = [];

  @override
  void initState() {
    super.initState();
    getSubSmashPlusList();
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
        title: t.mediumText(text: widget.title, color: WHITE, size: 20),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(children: [
        subsmashplusClass == null
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
                            (index) => card(
                                list[index].id,
                                list[index].img!,
                                list[index].name!,
                                list[index].caption!,
                                0,
                                index)))),
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

  card(int? id, String img, String title, String subTitle, int level,
          int index) =>
      InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WorkoutListScreen(id ?? 0, title, 'plus')));
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
                      imageUrl: IMAGE_SUBSMASHPLUS_SECTIONLive + img ?? " ",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(),
                      errorWidget: (context, url, error) => placeHolder(
                          height: 180, width: 280, borderRadius: 10),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              t.boldText(text: title, size: 18, color: PRIMARY),
                              Row(children: [
                                Container(width: 1, height: 15, color: PRIMARY),
                                SizedBox(width: 5),
                                t.mediumText(
                                    text: subTitle, size: 15, color: WHITE),
                              ])
                            ]))),
                if (level != 0)
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                              color: LIGHT_GREY_TEXT,
                              borderRadius: BorderRadius.circular(5)),
                          child:
                              t.boldText(text: 'PRO', size: 12, color: WHITE)))
              ])));

  getSubSmashPlusList() async {
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive + "/api/get_sub_smashplus"))
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
    subsmashplusClass = SubSmashPlusClass.fromJson(_jsonResponse);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      if (mounted) {
        setState(() {
          subsmashplusClass = SubSmashPlusClass.fromJson(_jsonResponse);
        });
      }
      for (int j = 0; j < subsmashplusClass!.data!.length; j++) {
        if (subsmashplusClass!.data![j].smash_id == widget.id) {
          list.add(subsmashplusClass!.data![j]);
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

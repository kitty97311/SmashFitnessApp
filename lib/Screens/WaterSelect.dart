import 'package:flutter/material.dart';

import '../Themes.dart';
import '../main.dart';
import '../globals.dart' as globals;
import 'package:exercise_app/LocalDatabase/TrackerClass.dart';

class WaterSelect extends StatefulWidget {
  @override
  _WaterSelectState createState() => _WaterSelectState();
}

class _WaterSelectState extends State<WaterSelect> {
  TrackerClass trackerClass = TrackerClass();
  List list = [];

  @override
  void initState() {
    super.initState();
    for (var element in globals.waterList) {
      Map<String, dynamic> item = {};
      item['title'] = element['title'];
      item['cups'] = element['cups'];
      item['focus'] = false;
      list.add(item);
    }
    setState(() {});
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
        title: t.boldText(text: 'Daily Drink Goal', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
      bottomNavigationBar: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              int selected = -1;
              for (var i = 0; i < list.length; i++) {
                if (list[i]['focus'] == true) selected = i;
              }
              if (selected >= 0) {
                trackerClass.addWater(
                    dateTime: DateTime.now(),
                    cups: list[selected]['cups'].toString(),
                    drink: "0");
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: PRIMARY),
                borderRadius: BorderRadius.circular(10),
                color: PRIMARY,
              ),
              child: Center(
                child: customTextWidget.boldText(
                    text: 'Done', color: BLACK, size: 20),
              ),
            ),
          )),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
            child: Column(
                children: List.generate(list.length, (index) => card(index)))),
      ]),
    );
  }

  card(int index) => InkWell(
        onTap: () {
          for (var i = 0; i < list.length; i++) {
            list[i]['focus'] = false;
          }
          list[index]['focus'] = true;
          setState(() {});
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
            height: 80,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: GRAY,
                border: list[index]['focus']
                    ? Border.all(width: 1, color: PRIMARY)
                    : Border.all(color: Colors.transparent)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customTextWidget.mediumText(
                      text: "${list[index]['cups']} cups/day",
                      color: list[index]['focus'] ? PRIMARY : WHITE,
                      size: ipad ? 40 : 20),
                ],
              ),
            )),
      );
}

import 'package:flutter/material.dart';

import '../Themes.dart';
import '../main.dart';
import '../globals.dart' as globals;
import 'package:exercise_app/LocalDatabase/HabitClass.dart';

class HabitList extends StatefulWidget {
  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  HabitClass habitClass = HabitClass();
  List list = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    readDatabase();
    for (var element in globals.habitList) {
      list.add(element);
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
        title: t.boldText(text: 'Join a new Challenge', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
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

  card(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration:
          BoxDecoration(color: GRAY, borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        t.boldText(text: list[index]['title'], size: 25, color: WHITE),
        SizedBox(height: 10),
        t.mediumText(text: list[index]['caption'], size: 15, color: WHITE),
        SizedBox(height: 20),
        Center(
            child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  showDialog<String>(
                      context: context,
                      builder: (context) => dialog()).then((value) {
                    if (value != null) {
                      habitClass.addData(
                          startDate: DateTime.now().toString().substring(0, 10),
                          days: value,
                          completed: "0",
                          id: list[index]['id'].toString(),
                          index: count);
                      Navigator.pop(context);
                    }
                  });
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: PRIMARY,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: t.boldText(
                            text: 'Join Now', size: 20, color: BLACK)))))
      ]),
    );
  }

  Widget dialog() {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        elevation: 0.0,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: BoxDecoration(
                  color: GRAY,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GRAY,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: PRIMARY, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            child: Column(children: [
                              customTextWidget.boldText(
                                  text: '3-Day Challenge',
                                  size: 20,
                                  color: WHITE)
                            ]),
                            onPressed: () {
                              Navigator.pop(context, '3');
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GRAY,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: PRIMARY, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            child: Column(children: [
                              customTextWidget.boldText(
                                  text: '5-Day Challenge',
                                  size: 20,
                                  color: WHITE)
                            ]),
                            onPressed: () {
                              Navigator.pop(context, '5');
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GRAY,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: PRIMARY, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            child: Column(children: [
                              customTextWidget.boldText(
                                  text: '7-Day Challenge',
                                  size: 20,
                                  color: WHITE)
                            ]),
                            onPressed: () {
                              Navigator.pop(context, '7');
                            }),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  readDatabase() async {
    List<HabitClass> hlist = [];

    List<HabitClass> value = await habitClass.readData();
    hlist.clear();
    hlist.addAll(value);
    print(hlist.length);
    if (mounted) {
      setState(() {
        count = hlist.length;
      });
    }
  }
}

import 'package:exercise_app/LocalDatabase/CustomWorkoutCreateClass.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutsClass.dart';
import 'package:exercise_app/Screens/Home.dart';
import 'package:exercise_app/Screens/SelectWorkouts.dart';
import 'package:exercise_app/Screens/TabsScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';
import '../Modals/AllWorkoutsClass.dart';
import '../Modals/ExtraClass.dart';
import '../Themes.dart';
import '../main.dart';
import '../globals.dart' as globals;

class SelectExercise extends StatefulWidget {
  List<Create> list;
  String totaltime;
  String totalcalories;
  String totalworkout;
  int supersetPrimaryId;
  int index; // workoutBox index

  @override
  _SelectExerciseState createState() => _SelectExerciseState();

  SelectExercise(this.list, this.totaltime, this.totalcalories,
      this.totalworkout, this.supersetPrimaryId, this.index);
}

class _SelectExerciseState extends State<SelectExercise> {
  List<Map<String, dynamic>> customWorkouts = [];
  int repeat_index = 0;
  int interval_index = 0;
  final RegExp formatter = new RegExp("[a-zA-Z]");
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    int max = 0;
    int supersetPrimarySort = 0;
    if (globals.customWorkouts.isNotEmpty)
      for (int i = 0; i < globals.customWorkouts.length; i++) {
        if (max <= globals.customWorkouts[i]['sort'])
          max = globals.customWorkouts[i]['sort'] + 1;
      }

    for (int i = 0; i < widget.list.length; i++) {
      int exist = 0;
      if (globals.customWorkouts.isNotEmpty) {
        for (int j = 0; j < globals.customWorkouts.length; j++) {
          if (widget.supersetPrimaryId == globals.customWorkouts[j]['id']) {
            globals.customWorkouts[j]['superset'] = true;
            supersetPrimarySort = globals.customWorkouts[j]['sort'];
          }
          if (widget.list[i].id == globals.customWorkouts[j]['id']) {
            exist = 1;
            break;
          }
        }
      }
      if (exist == 0) {
        Map<String, dynamic> item = {};
        item['id'] = widget.list[i].id;
        item['name'] = widget.list[i].name;
        item['image'] = widget.list[i].image;
        item['sort'] =
            widget.supersetPrimaryId > 0 ? supersetPrimarySort : max++;
        item['interval'] = 0;
        item['superset'] = widget.supersetPrimaryId > 0 ? true : false;
        item['set'] = [
          {'id': 1, 'rep': 5}
        ];
        globals.customWorkouts.add(item);
      }
    }
    for (int i = 0; i < globals.customWorkouts.length; i++) {
      Map<String, dynamic> item = {};
      item['id'] = globals.customWorkouts[i]['id'];
      item['name'] = globals.customWorkouts[i]['name'];
      item['image'] = globals.customWorkouts[i]['image'];
      item['sort'] = globals.customWorkouts[i]['sort'];
      item['interval'] = globals.customWorkouts[i]['interval'];
      item['superset'] = globals.customWorkouts[i]['superset'];
      item['set'] = [];
      for (int j = 0; j < globals.customWorkouts[i]['set'].length; j++) {
        item['set'].add({
          'id': globals.customWorkouts[i]['set'][j]['id'],
          'rep': TextField(
            controller: TextEditingController(
                text: globals.customWorkouts[i]['set'][j]['rep'].toString()),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              counterText: '',
            ),
          )
        });
      }
      customWorkouts.add(item);
    }
    globals.customWorkouts.sort((a, b) => a['sort'].compareTo(b['sort']));
    customWorkouts.sort((a, b) => a['sort'].compareTo(b['sort']));
    setState(() {});
    print("${globals.customWorkouts}");
    print("${widget.supersetPrimaryId}");
  }

  void updateGlobals() {
    for (int i = 0; i < customWorkouts.length; i++) {
      globals.customWorkouts[i]['sort'] = customWorkouts[i]['sort'];
      globals.customWorkouts[i]['superset'] = customWorkouts[i]['superset'];
      globals.customWorkouts[i]['set'] = [];
      for (int ii = 0; ii < customWorkouts[i]['set'].length; ii++) {
        globals.customWorkouts[i]['set'].add({
          'id': customWorkouts[i]['set'][ii]['id'],
          'rep': (customWorkouts[i]['set'][ii]['rep'] as TextField)
              .controller!
              .text
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
        title: t.boldText(text: SELECT_EXERCISE, color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
      bottomNavigationBar: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(children: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                updateGlobals();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectWorkouts(
                            0, 'ALL', widget.list, 0, widget.index)));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: PRIMARY),
                  borderRadius: BorderRadius.circular(10),
                  color: null,
                ),
                child: Center(
                  child: customTextWidget.boldText(
                      text: 'Add Exercises', color: PRIMARY, size: 20),
                ),
              ),
            ),
            Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                if (sp.getString('newWorkoutName')!.length == 0) {
                  print("name empty");
                  showCustomDialog(
                      context: context,
                      title: ERROR,
                      msg: ENTER_WORKOUT_NAME,
                      btnYesText: OK,
                      onPressedBtnYes: () {
                        Navigator.pop(context);
                      });
                } else if (repeat_index < 0) {
                  print("repeat count empty");
                  showCustomDialog(
                      context: context,
                      title: ERROR,
                      msg: SELECT_REPEAT_COUNT,
                      btnYesText: OK,
                      onPressedBtnYes: () {
                        Navigator.pop(context);
                      });
                } else if (interval_index < 0) {
                  print("interval time empty");
                  showCustomDialog(
                      context: context,
                      title: ERROR,
                      msg: SELECT_INTERVAL_NAME,
                      btnYesText: OK,
                      onPressedBtnYes: () {
                        Navigator.pop(context);
                      });
                } else {
                  updateGlobals();
                  if (widget.index < 0) {
                    workoutBox.add(
                      WorkOut(
                        name: sp.getString('newWorkoutName')!,
                        intervelTime: interval_index == 0
                            ? "5"
                            : interval_index == 1
                                ? "10"
                                : "15",
                        list: widget.list,
                        extraList: globals.customWorkouts,
                        retpeatWorkOut: repeat_index == 0
                            ? "1"
                            : repeat_index == 1
                                ? "2"
                                : "3",
                        totalCal: widget.totalcalories,
                        totalTime: widget.totaltime,
                      ),
                    );
                  } else {
                    workoutBox.delete(widget.index);
                    if (workoutBox.isEmpty) {
                      workoutBox.add(
                        WorkOut(
                          name: sp.getString('newWorkoutName')!,
                          intervelTime: interval_index == 0
                              ? "5"
                              : interval_index == 1
                                  ? "10"
                                  : "15",
                          list: widget.list,
                          extraList: globals.customWorkouts,
                          retpeatWorkOut: repeat_index == 0
                              ? "1"
                              : repeat_index == 1
                                  ? "2"
                                  : "3",
                          totalCal: widget.totalcalories,
                          totalTime: widget.totaltime,
                        ),
                      );
                    } else {
                      workoutBox.putAt(
                        widget.index,
                        WorkOut(
                          name: sp.getString('newWorkoutName')!,
                          intervelTime: interval_index == 0
                              ? "5"
                              : interval_index == 1
                                  ? "10"
                                  : "15",
                          list: widget.list,
                          extraList: globals.customWorkouts,
                          retpeatWorkOut: repeat_index == 0
                              ? "1"
                              : repeat_index == 1
                                  ? "2"
                                  : "3",
                          totalCal: widget.totalcalories,
                          totalTime: widget.totaltime,
                        ),
                      );
                    }
                  }
                  sp.setString('newWorkoutName', '');
                  globals.customWorkouts = [];
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TabsScreen()));
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: PRIMARY,
                ),
                child: Center(
                  child: customTextWidget.boldText(
                      text: 'Save Workout', color: BLACK, size: 20),
                ),
              ),
            ),
          ])),
    ));
  }

  body() {
    return ReorderableListView(
      children: List.generate(customWorkouts.length, (index) => card(index)),
      onReorder: (oldIndex, newIndex) {
        bool possible = true;
        if (newIndex > 0 &&
            newIndex < customWorkouts.length - 1 &&
            customWorkouts[newIndex - 1]['superset'] == true &&
            customWorkouts[newIndex]['superset'] == true &&
            customWorkouts[newIndex - 1]['sort'] ==
                customWorkouts[newIndex]['sort']) possible = false;
        if (oldIndex > 0 &&
            customWorkouts[oldIndex - 1]['superset'] == true &&
            customWorkouts[oldIndex]['superset'] == true &&
            customWorkouts[oldIndex - 1]['sort'] ==
                customWorkouts[oldIndex]['sort'] &&
            oldIndex - newIndex != 1) possible = false;
        if (!possible) {
          showCustomDialog(
              context: context,
              title: ERROR,
              msg: 'That exercise cannot be moved to that position.',
              btnYesText: OK,
              onPressedBtnYes: () {
                Navigator.pop(context);
              });
          return;
        }

        if (oldIndex < customWorkouts.length - 1 &&
            customWorkouts[oldIndex]['superset'] == true &&
            customWorkouts[oldIndex + 1]['superset'] == true &&
            customWorkouts[oldIndex]['sort'] ==
                customWorkouts[oldIndex + 1]['sort']) {
          if (newIndex > oldIndex) {
            newIndex -= 2;
          }
          final item1 = customWorkouts[oldIndex];
          final item2 = customWorkouts[oldIndex + 1];
          customWorkouts.removeAt(oldIndex);
          customWorkouts.removeAt(oldIndex);
          customWorkouts.insert(newIndex, item2);
          customWorkouts.insert(newIndex, item1);
          final globalItem1 = globals.customWorkouts[oldIndex];
          final globalItem2 = globals.customWorkouts[oldIndex + 1];
          globals.customWorkouts.removeAt(oldIndex);
          globals.customWorkouts.removeAt(oldIndex);
          globals.customWorkouts.insert(newIndex, globalItem2);
          globals.customWorkouts.insert(newIndex, globalItem1);
        } else {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = customWorkouts.removeAt(oldIndex);
          customWorkouts.insert(newIndex, item);
          final globalItem = globals.customWorkouts.removeAt(oldIndex);
          globals.customWorkouts.insert(newIndex, globalItem);
        }

        Map<int, int> sortIndexMap = {};
        for (int i = 0; i < customWorkouts.length; i++) {
          int oldSort = customWorkouts[i]['sort'];
          if (!sortIndexMap.containsKey(oldSort)) {
            sortIndexMap[oldSort] = sortIndexMap.length;
          }
          customWorkouts[i]['sort'] = sortIndexMap[oldSort]!;
        }
        setState(() {});
      },
    );
  }

  card(int index) {
    double marginbottom = 0;
    if (index < customWorkouts.length - 1)
      marginbottom = (customWorkouts[index]['superset'] == true &&
              customWorkouts[index + 1]['superset'] == true &&
              customWorkouts[index]['sort'] ==
                  customWorkouts[index + 1]['sort'])
          ? 0
          : 20;
    else
      marginbottom = 20;
    return Container(
        key: ValueKey(customWorkouts[index]),
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(16, 0, 16, marginbottom),
        color: GRAY,
        child: Column(children: [
          if ((index < customWorkouts.length - 1 &&
                  customWorkouts[index]['superset'] == true &&
                  customWorkouts[index + 1]['superset'] == true &&
                  customWorkouts[index]['sort'] ==
                      customWorkouts[index + 1]['sort']) ||
              customWorkouts[index]['superset'] == false)
            Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                  color: LIGHT_GREY_TEXT.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0))),
              child: Center(
                child: Icon(Icons.menu, color: LIGHT_GREY_TEXT),
              ),
            ),
          SizedBox(height: 20),
          Stack(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: IMAGE_URL_MENU_ITEMLive +
                            customWorkouts[index]['image'],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(),
                        errorWidget: (context, url, error) =>
                            placeHolder(borderRadius: 10))),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                t.mediumText(
                    text: customWorkouts[index]['name'].toString().length < 20
                        ? customWorkouts[index]['name'].toString()
                        : customWorkouts[index]['name']
                                .toString()
                                .substring(0, 18) +
                            '..',
                    size: 20,
                    color: WHITE),
                SizedBox(height: 5),
                Row(children: [
                  t.mediumText(text: 'Set', size: 20, color: WHITE),
                  SizedBox(width: 50),
                  t.mediumText(text: 'Reps', size: 20, color: WHITE),
                ]),
                Column(
                    children: List.generate(customWorkouts[index]['set'].length,
                        (i) => set(index, i)))
              ])
            ]),
            if ((index < customWorkouts.length - 1 &&
                    customWorkouts[index]['superset'] == true &&
                    customWorkouts[index + 1]['superset'] == true &&
                    customWorkouts[index]['sort'] ==
                        customWorkouts[index + 1]['sort']) ||
                customWorkouts[index]['superset'] == false)
              Positioned(
                  right: 0,
                  top: -10,
                  child: InkWell(
                      onTap: () {
                        if (customWorkouts[index]['superset'] == true) {
                          widget.list.removeWhere((element) =>
                              element.id == customWorkouts[index]['id']);
                          customWorkouts.removeAt(index);
                          globals.customWorkouts.removeAt(index);
                          widget.list.removeWhere((element) =>
                              element.id == customWorkouts[index]['id']);
                          customWorkouts.removeAt(index);
                          globals.customWorkouts.removeAt(index);
                        } else {
                          widget.list.removeWhere((element) =>
                              element.id == customWorkouts[index]['id']);
                          customWorkouts.removeAt(index);
                          globals.customWorkouts.removeAt(index);
                        }
                        setState(() {});
                        for (int x = 0; x < widget.list.length; x++)
                          print(widget.list[x].name);
                      },
                      child: Container(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.close, color: WHITE, size: 20))))
          ]),
          Padding(
              padding: EdgeInsets.all(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  customWorkouts[index]['set'].add({
                    'id': customWorkouts[index]['set'].length + 1,
                    'rep': TextField(
                      controller: TextEditingController(text: '5'),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        counterText: '',
                      ),
                    )
                  });
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: PRIMARY),
                    borderRadius: BorderRadius.circular(10),
                    color: null,
                  ),
                  child: Center(
                    child: customTextWidget.boldText(
                        text: 'Add Set', color: PRIMARY, size: 20),
                  ),
                ),
              )),
          if (customWorkouts[index]['superset'] == false)
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    updateGlobals();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectWorkouts(
                                0,
                                'ALL',
                                widget.list,
                                customWorkouts[index]['id'],
                                widget.index)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PRIMARY,
                    ),
                    child: Center(
                      child: customTextWidget.boldText(
                          text: 'Add Super Set', color: BLACK, size: 20),
                    ),
                  ),
                ))
        ]));
  }

  set(int index, int i) => Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: BLACK, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: customTextWidget.boldText(
                  text: customWorkouts[index]['set'][i]['id'].toString(),
                  color: WHITE,
                  size: 25),
            )),
        SizedBox(width: 40),
        NumInput(customWorkouts[index]['set'][i]['rep']),
        SizedBox(width: 40),
        if (i == 0)
          Container(
            width: 50,
            height: 50,
          ),
        if (i > 0)
          InkWell(
              onTap: () {
                customWorkouts[index]['set'].removeAt(i);
                setState(() {});
              },
              child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/custom/bin.png')))
      ]));
}

// Create an input widget that takes only one digit
class NumInput extends StatelessWidget {
  final Widget widget;

  const NumInput(this.widget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        decoration:
            BoxDecoration(color: BLACK, borderRadius: BorderRadius.circular(5)),
        child: widget);
  }
}

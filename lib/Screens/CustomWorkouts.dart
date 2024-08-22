import 'package:exercise_app/LocalDatabase/CustomWorkoutCreateClass.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutsClass.dart';
import 'package:exercise_app/Modals/AllWorkoutsClass.dart';
import 'package:exercise_app/Screens/CustomWorkoutCategory.dart';
import 'package:exercise_app/Screens/CustomWorkoutReady.dart';
import 'package:exercise_app/Screens/SelectExerciseForUpdate.dart';
import 'package:exercise_app/Screens/StartExercise.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CustomWidgets/CustomDialogues.dart';
import '../AllText.dart';
import '../Themes.dart';
import '../main.dart';

class CustomWorkouts extends StatefulWidget {
  @override
  _CustomWorkoutsState createState() => _CustomWorkoutsState();
}

class _CustomWorkoutsState extends State<CustomWorkouts> {
  TextEditingController namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: BLACK,
      body: ValueListenableBuilder(
        valueListenable: workoutBox.listenable(),
        builder: (context, value, child) {
          if (workoutBox.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(children: [
                        t.boldText(
                            text: 'Create My Workouts', color: WHITE, size: 25),
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            margin: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                border: Border.all(color: PRIMARY),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              controller: namecontroller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Untitled Workout',
                                hintStyle: TextStyle(
                                    color: LIGHT_GREY_TEXT, fontSize: 20),
                              ),
                              style: TextStyle(
                                  color: WHITE,
                                  fontFamily: 'Bold',
                                  fontSize: 20),
                            ))
                      ])),
                  Image.asset('assets/custom/add_circle_outline.png'),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () async {
                          if (namecontroller.text.isEmpty) {
                            showCustomDialog(
                                context: context,
                                title: ERROR,
                                msg: 'Please enter custom workout name.',
                                btnYesText: OK,
                                onPressedBtnYes: () {
                                  Navigator.pop(context);
                                });
                            return;
                          }
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          sp.setString('newWorkoutName', namecontroller.text);

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomWorkoutCategory(),
                            ),
                          );
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
                                text: 'Create New Workout',
                                color: BLACK,
                                size: 20),
                          ),
                        ),
                      )),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [
                      t.boldText(
                          text: 'Create My Workouts', color: WHITE, size: 25),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: PRIMARY),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextFormField(
                            controller: namecontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Untitled Workout',
                              hintStyle: TextStyle(
                                  color: LIGHT_GREY_TEXT, fontSize: 20),
                            ),
                            style: TextStyle(
                                color: WHITE, fontFamily: 'Bold', fontSize: 20),
                          ))
                    ])),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: workoutBox.length,
                      itemBuilder: (BuildContext builder, int index) {
                        var e = workoutBox.getAt(index);
                        print(e?.extraList);
                        print(e?.list);
                        return Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomWorkoutReady(
                                      totalTime: int.parse(e?.totalTime ?? "0"),
                                      totalCalories:
                                          int.parse(e?.totalCal ?? "0"),
                                      name: e?.name,
                                      createList: e?.list,
                                      extraList: e?.extraList,
                                      intervalTime: int.parse(
                                        e?.intervelTime ?? "0",
                                      ),
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 75,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: GRAY,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: CUSTOM_BG,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: customTextWidget.regularText(
                                              text: e?.name.substring(0, 1),
                                              size: ipad ? 50 : 40,
                                              color: WHITE),
                                        )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customTextWidget.boldText(
                                              text: e?.name,
                                              size: 25,
                                              color: WHITE),
                                          Row(children: [
                                            customTextWidget.mediumText(
                                                text: 'Duration :',
                                                size: 15,
                                                color: WHITE),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            customTextWidget.mediumText(
                                                text: (e?.totalTime ?? "0") +
                                                    " " +
                                                    SECONDS[LANGUAGE_TYPE],
                                                size: 15,
                                                color: PRIMARY),
                                          ])
                                        ]),
                                    Spacer(),
                                    InkWell(
                                        onTap: () {
                                          int ttlcalories = 0;
                                          int ttltime = 0;

                                          for (int i = 0;
                                              i < e!.list.length;
                                              i++) {
                                            ttlcalories = (int.parse(
                                                    e.list[i].calories ??
                                                        "0")) +
                                                ttlcalories;
                                            ttltime = (int.parse(
                                                    e.list[i].time ?? "0")) +
                                                ttltime;
                                          }

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectExerciseForUpdate(
                                                      e.name,
                                                      e.list,
                                                      ttltime.toString(),
                                                      ttlcalories.toString(),
                                                      e.list.length.toString(),
                                                      e.extraList,
                                                      index),
                                            ),
                                          );
                                        },
                                        child: Icon(Icons.edit,
                                            color: WHITE, size: 20)),
                                    SizedBox(width: 15),
                                    InkWell(
                                        onTap: () {
                                          workoutBox.deleteAt(index);
                                        },
                                        child: Icon(Icons.close,
                                            color: Colors.red, size: 20)),
                                  ],
                                ),
                              ),
                            ));
                      }),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () async {
                        if (namecontroller.text.isEmpty) {
                          showCustomDialog(
                              context: context,
                              title: ERROR,
                              msg: ENTER_WORKOUT_NAME,
                              btnYesText: OK,
                              onPressedBtnYes: () {
                                Navigator.pop(context);
                              });
                          return;
                        }
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        sp.setString('newWorkoutName', namecontroller.text);

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomWorkoutCategory(),
                          ),
                        );
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
                              text: 'Create New Workout',
                              color: BLACK,
                              size: 20),
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    ));
  }
}

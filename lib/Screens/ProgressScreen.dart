import 'package:exercise_app/LocalDatabase/ProgressClass.dart';
import 'package:flutter/material.dart';

import '../AllText.dart';
import '../Themes.dart';
import '../main.dart';
import 'MyCustomChart.dart';


class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {

  List<String> monthsList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  List<String> daysList = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
  ];

  ProgressClass progressClass=ProgressClass();
  ScrollController scrollController = ScrollController();
  int totalWorkOuts = 0;
  int totalSeconds = 0;
  int totalCalories = 0;
  int today = DateTime.now().weekday;
  DateTime? selectedDateTime;
  int? selectedDay ;
  List<ProgressClass> list = [];
  List<DateTime> dateTimeList = [];
  int maxValue = 0;
  Widget? myCustomChart;

  @override
  void initState() {
    // TODO: implement initState
    selectedDay = today;
    scrollController.addListener(() {
      print(scrollController.position);
    });
    print(today);
    for(int i=0; i<7; i++){
      if(today == 7){
        dateTimeList.add(DateTime.now().add(Duration(days: i)));
      }else if(i < today){
        dateTimeList.add(DateTime.now().subtract(Duration(days: today - i)));
      }else if(i == today){
        dateTimeList.add(DateTime.now());
      }else if(i > today){
        dateTimeList.add(DateTime.now().add(Duration(days: i - today)));
      }
      print(dateTimeList[i]);
    }
    // Future.delayed(Duration(seconds: 1),() {
    //   if (today > 3) {
    //     scrollController.animateTo(85.0 * today,
    //         duration: Duration(microseconds: 500), curve: Curves.elasticIn);
    //   }
    //   });
    readDatabase(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: WHITE,
        elevation: 0,
        flexibleSpace: customDialogues.header(text: "",context: context, goToHomeScreen: true),
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                t.boldText(
                  text: PROGRESS,
                  size: ipad ? 40 : 33
                ),
                SizedBox(height: 5,),
                t.regularText(
                  text: CHECK_YOUR_WORKOUT_PROGRESS,
                  color: LIGHT_GREY_TEXT,
                  size: ipad ? 30 :15
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    t.boldText(
                        text: THIS_WEEK,
                        size: ipad ? 44 :22
                    ),

                    t.mediumText(
                        text: monthsList[DateTime.now().month - 1] + "," +" ${DateTime.now().year}",
                        size: ipad ? 30 :15,
                      color: LIGHT_GREY_TEXT
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 90,
                  child: ListView.builder(
                    controller: scrollController,
                      itemCount: daysList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            setState(() {
                              selectedDay = index;
                              selectedDateTime = dateTimeList[index];
                              print(selectedDateTime);
                              readDatabase(selectedDateTime!);
                              //print(index == today ? DateTime.now().day.toString() : (index < today ? DateTime.now().day - index - 1 : DateTime.now().day + index - 1 ).toString());

                            });
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 70,
                            width: 72,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == selectedDay ? ORANGE : index == 0 ? BLUE : SILVER,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                t.regularText(
                                  text: daysList[index],
                                  color: index == selectedDay ? WHITE : index == 0 ? WHITE : SILVER,
                                  size: ipad ? 30 : 15,
                                ),
                                t.mediumText(
                                  text: dateTimeList[index].day.toString(),
                                  color: index == selectedDay ? WHITE : index == 0 ? WHITE : BLACK,
                                  size: ipad ? 30 : 26,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),

                Divider(
                  height: 20,
                  thickness: 1,
                  color: LIGHT_GREY_TEXT,
                )


              ],
            ),
          ),
          list.isEmpty ? Container(height: 250,) : MyCustomChart(list, maxValue, false),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
            decoration: BoxDecoration(
              color: PEACH,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    t.mediumText(
                      text: totalWorkOuts.toString(),
                      size: ipad ? 60 : 30,
                    ),
                    t.mediumText(
                      text: "WORKOUTS",
                      size: ipad ? 24 : 12,
                      color: ORANGE
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    t.mediumText(
                      text: totalCalories.toString(),
                      size: ipad ? 60 : 30,
                    ),
                    t.mediumText(
                      text: "CALORIES",
                      size: ipad ? 24 : 12,
                      color: ORANGE
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    t.mediumText(
                      text: (totalSeconds/60).toStringAsFixed(1),
                      size: ipad ? 60 : 30,
                    ),
                    t.mediumText(
                      text: "MINUTES",
                      size: ipad ? 24 : 12,
                      color: ORANGE
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  readDatabase(DateTime dateTime) async{
    List maxValueList = [];
    setState(() {
      list.clear();
      totalWorkOuts = 0;
      maxValue = 0;
      totalSeconds = 0;
      totalCalories = 0;
    });
    await progressClass.readData(
     dateTime: dateTime
    ).then((value) async{
      setState(() {
        list.addAll(value);
        for(int i=0; i<list.length; i++){
          maxValueList.add(int.parse(list[i].calories!));
          totalWorkOuts = totalWorkOuts + int.parse(list[i].workOuts!);
          totalSeconds = totalSeconds + int.parse(list[i].seconds!);
          totalCalories = totalCalories + int.parse(list[i].calories!);
          print(list[i].calories.toString());
        }
      });
      maxValueList.sort();
      // print(maxValueList.last);
      setState(() {
        maxValueList.sort();
        maxValue = maxValueList.last;
        print("Widget recreated");
      });
    });
  }

}



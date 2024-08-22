import 'dart:async';
import 'dart:math';

import 'package:exercise_app/LocalDatabase/ProgressClass.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Themes.dart';
import '../main.dart';

class MyCustomChart extends StatefulWidget {

  List<ProgressClass> list = [];
  int maxValue;
  bool isCalled;

  MyCustomChart(this.list, this.maxValue, this.isCalled);

  @override
  _MyCustomChartState createState() => _MyCustomChartState();
}

class _MyCustomChartState extends State<MyCustomChart> {


  List<int> heightList = [];

  bool showAvg = false;

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    if (value % 1 != 0) {
      return Container();
    }
    final style = TextStyle(
      color: Colors.black,
      // fontFamily: "Bold",
      fontSize: min(18, 50 * chartWidth / 300),
    );


    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(meta.formattedValue, style: style),
    );
  }
  Widget leftTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      color: Colors.black,
      // fontFamily: "bold",
      fontSize: min(18, 50 * chartWidth / 300),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(meta.formattedValue, style: style),
    );
  }

  int x = 5;
  int selectedIndex = 0;
  int scrollPoint = 0;
  ScrollController scrollController = ScrollController(initialScrollOffset: 0, keepScrollOffset: true);

  @override
  void initState() {
    for(int i=0; i<24; i++){
      heightList.add(0);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("dispose called");
    super.dispose();
  }

  generateGraph() async{
    print("Mys custom chart : init called");
    print("widget : " + widget.toString());


    // Timer(Duration(seconds: 1),(){
    for(int i=0; i<24; i++){
      //int x = Random().nextInt(180);
      if(mounted) {
        setState(() {
          if (widget.maxValue == 0) {
            heightList[i] = 0;
          } else {

            heightList[i] =
                int.parse(widget.list[i].calories!) ~/ (widget.maxValue / 180);
            print("Height ${heightList[i]}");

            if(heightList[i] > 0){
              setState(() {
                scrollPoint = i;
                selectedIndex = i;
                print(selectedIndex);
              });
            }

          }
        });
      }
    }

    animateScroll();
    // });
  }

 animateScroll() async{
    await Future.delayed(Duration(seconds: 1));
    scrollController.animateTo(scrollPoint * 52.0, duration: Duration(seconds: 1), curve: Curves.easeIn);
 }

  @override
  Widget build(BuildContext context) {
    if(!widget.isCalled){
      generateGraph();
      setState(() {
        widget.isCalled = true;
      });
    }
      return Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          child: heightList.isEmpty ? Container(height: 250,) : Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 30,),
                            Container(
                              width: 1500,
                              height: 200,
                              child: LineChart(
                                LineChartData(
                                  minX: 0,
                                  maxX: 23,
                                  minY: 0,
                                  maxY: 200,
                                  lineTouchData: LineTouchData(
                                    enabled: false,
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: List.generate(24, (index){
                                        return FlSpot(index + 0.0, heightList[index] + 0.0);
                                      }),
                                      isCurved: true,
                                      dotData: FlDotData(show: false),
                                      barWidth: 3,
                                      belowBarData: BarAreaData(
                                          show: true,
                                          // colors: [
                                          //   BLUE.withOpacity(0.3),
                                          //   BLUE.withOpacity(0.001),
                                          // ],
                                          // gradientFrom: Offset(0, 0),
                                          // gradientTo: Offset(0, 1),
                                          // gradientColorStops: [
                                          //   0.6,
                                          //   1
                                          // ]
                                      ),
                                      color: BLUE,
                                    )
                                  ],
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  backgroundColor: WHITE,
                                  // gridData: FlGridData(
                                  //   show: false,
                                  // ),
                                  /*titlesData: FlTitlesData(
                                    show: true,

                                    // leftTitles: SideTitles(
                                    //   showTitles: false,
                                    // ),
                                    // bottomTitles: SideTitles(
                                    //     showTitles: true,
                                    //     margin: 20,
                                    //     getTitles: (value){
                                    //       for(int i=0;i<24;i++){
                                    //         return value < 13 ? "${value.toInt()} AM" : "${value.toInt()-12} PM";
                                    //       }
                                    //       return '';
                                    //     },
                                    //     getTextStyles: (val){
                                    //       return TextStyle(
                                    //           color: BLACK,
                                    //           fontSize: 12,
                                    //           fontFamily: "Medium"
                                    //       );
                                    //     }
                                    // ),
                                  ),*/
                                  titlesData: FlTitlesData(
                                    show: true,
                                    topTitles: AxisTitles(
                                    ),
                                    rightTitles: AxisTitles(),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) =>
                                            bottomTitleWidgets(value, meta, 250),
                                        reservedSize: 36,
                                        interval: 1,
                                      ),
                                      // drawBehindEverything: true,
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) =>
                                            leftTitleWidgets(value, meta, 250),
                                        reservedSize: 56,
                                      ),
                                      // drawBehindEverything: true,
                                    ),


                                  ),
                                ),
                                // swapAnimationDuration: Duration(seconds: 1),
                              ),
                            ),
                            SizedBox(width: 30,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(24, (index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: selectedIndex == index ? (heightList[index]/1.25) + 103 : 200,
                                  width: (1500/23) - 10,
                                  margin: EdgeInsets.fromLTRB(7, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //color: selectedIndex == index ? LIGHT_GREY.withOpacity(0.5) : Colors.transparent,
                                  ),
                                  child: selectedIndex == index ? Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Image.asset(
                                      "assets/progress/chart_select.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ) : Container(),
                                ),

                                Container(
                                  height: selectedIndex == index ? (heightList[index]/1.25) + 102 : 200,
                                  width: (1500/23) - 10,
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 55,
                                        child: selectedIndex == index ? Stack(
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                "assets/progress/chart_msg.png",
                                                height: 40,

                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(bottom: 10),
                                                child: Center(
                                                  child: t.mediumText(
                                                      text: "${widget.list[index].calories} cal",
                                                      size: 12
                                                  ),
                                                )
                                            ),

                                          ],
                                        ) : Container(),
                                      ),
                                      selectedIndex == index ? Image.asset(
                                        "assets/progress/chart_pin.png",
                                        height: 15,
                                        width: 15,
                                        fit: BoxFit.fill,
                                      ) : Container(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

  }

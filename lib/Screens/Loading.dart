import 'package:exercise_app/Screens/PlanReady.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../main.dart';
import 'package:exercise_app/AllText.dart';
import '../Themes.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 7), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PlanReady()));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BLACK,
      body: Stack(
        children: [
          Center(
            child: Container(
                color: GRAY,
                child: Opacity(
                    opacity: 0.5,
                    child: Image.asset("assets/setup/progressBg.png"))),
          ),
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SimpleCircularProgressBar(
                size: 140,
                backColor: GRAY,
                progressColors: [PRIMARY],
                mergeMode: true,
                backStrokeWidth: 10,
                progressStrokeWidth: 10,
                onGetText: (double value) {
                  return Text('${value.toInt()}%',
                      style: TextStyle(
                          color: WHITE,
                          fontSize: 40,
                          fontWeight: FontWeight.bold));
                },
              ),
              SizedBox(height: 24),
              customTextWidget.mediumText(
                  text: ANALYZING_ANSWER[LANGUAGE_TYPE],
                  color: WHITE,
                  size: ipad ? 35 : 20,
                  alignment: TextAlign.center),
            ]),
          ),
        ],
      ),
    );
  }
}

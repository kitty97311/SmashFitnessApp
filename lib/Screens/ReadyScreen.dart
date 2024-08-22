import 'package:flutter/material.dart';

import '../Themes.dart';
import '../main.dart';

class ReadyScreen extends StatefulWidget {
  @override
  _ReadyScreenState createState() => _ReadyScreenState();
}

class _ReadyScreenState extends State<ReadyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: body(),
    );
  }

  body() {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Column(
        children: [
          Container(
              width: size.width,
              height: size.width,
              color: BLUE,
              child: Stack(children: [
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      'assets/startExcercise/start.png',
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              t.boldText(
                                  text: 'Dumbbell Pullover'.toUpperCase(),
                                  color: BLACK,
                                  size: 18),
                              t.regularText(
                                  text: 'Next',
                                  color: LIGHT_GREY_TEXT,
                                  size: 15),
                            ]),
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: LIGHT_GREY_TEXT,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Icon(
                              Icons.settings,
                              color: BLACK,
                              size: 18,
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                ),
              ])),
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                  width: size.width,
                  height: size.height - size.width,
                  padding: EdgeInsets.all(16),
                  color: BLACK,
                  child: Column(children: [
                    SizedBox(height: 30),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      t.boldText(
                          text: 'BENT OVER ROW'.toUpperCase(),
                          color: WHITE,
                          size: 18),
                      Icon(Icons.question_mark)
                    ]),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child:
                            t.boldText(text: 'x 15', color: WHITE, size: 60)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.all(5),
                        color: BLACK,
                        child: Icon(Icons.ac_unit, color: BLACK),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: PRIMARY,
                          ),
                          child: Center(
                            child: Icon(Icons.check, size: 50, color: BLACK),
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: WHITE.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Icon(Icons.play_arrow_sharp,
                                size: 40, color: WHITE),
                          ),
                        ),
                      ),
                    ]),
                  ])))
        ],
      ),
      Positioned(
          left: 16,
          top: 50,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LIGHT_GREY_TEXT,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Icon(
                Icons.close,
                color: BLACK,
                size: 18,
              ),
            ),
          ))
    ]);
  }
}

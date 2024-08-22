import 'package:exercise_app/Screens/Plan2.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../main.dart';
import '../Themes.dart';

class Coach extends StatefulWidget {
  @override
  _CoachState createState() => _CoachState();
}

class _CoachState extends State<Coach> {
  int selectedCoach = 0;
  List<CardModel> cardList = [
    CardModel(
        'DEAN',
        'Professional coach of LEAP FITNESS, skilled at strength and endurance training',
        'assets/setup/coach_man.png'),
    CardModel(
        'DEAN',
        'Professional coach of LEAP FITNESS, skilled at strength and endurance training',
        'assets/setup/coach_woman.png'),
  ];

  @override
  void initState() {
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
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.all(16),
              child: Row(children: [
                IconButton(
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
                              color: LIGHT_GREY_TEXT,
                              spreadRadius: 0.5,
                              blurRadius: 6)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: WHITE,
                      size: 18,
                    ),
                  ),
                ),
              ])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Stack(children: [
                Container(
                  width: 36,
                  height: 72,
                  decoration: BoxDecoration(
                    color: PRIMARY,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.zero,
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.zero),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Image.asset(
                    "assets/splash/model1.png",
                    width: 60,
                  ),
                )
              ]),
              SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: customTextWidget.boldText(
                    text: 'Choose your Smash Coach', color: WHITE, size: 25),
              )
            ]),
          ),
          Expanded(
            child: ListView(
              children: [
                CarouselSlider.builder(
                  itemCount: cardList.length,
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    height: 400.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedCoach = index;
                      });
                    },
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: GRAY),
                          child: Opacity(
                              opacity: pageViewIndex == selectedCoach ? 1 : 0.3,
                              child: Stack(children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          child: Container(
                                              width: double.infinity,
                                              height: 250,
                                              child: Image.asset(
                                                cardList[itemIndex].image,
                                                fit: BoxFit.cover,
                                              ))),
                                      SizedBox(height: 16),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: customTextWidget.boldText(
                                            text: cardList[itemIndex].title,
                                            color: WHITE,
                                            size: 35),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: customTextWidget.mediumText(
                                            text: cardList[itemIndex].desc,
                                            color: WHITE,
                                            size: 18),
                                      ),
                                    ]),
                                Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Image.asset(
                                        'assets/setup/verified.png'))
                              ]))),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Plan2()));
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
                        text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class CardModel {
  String title;
  String desc;
  String image;

  CardModel(this.title, this.desc, this.image);
}

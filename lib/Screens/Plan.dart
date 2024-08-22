import 'package:exercise_app/Screens/Coach.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../main.dart';
import 'package:exercise_app/CustomWidgets/CustomCheck.dart';
import '../Themes.dart';

CustomCheck customCheck = CustomCheck();

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  int selectedPlan = 0;
  List<CardModel> cardList = [
    CardModel([
      'assets/setup/avatar1.png',
      'assets/setup/avatar2.png',
      'assets/setup/avatar3.png'
    ],
        '544+ users joined',
        'MASSIVE UPPER BODY',
        'Lose belly fat, get ripped abs in just 4 weeks with this efficient plan. It also helps pump up your arms, strengthen your back & shoulders. No equipment needed!',
        'assets/setup/recommended.png'),
    CardModel([
      'assets/setup/avatar1.png',
      'assets/setup/avatar2.png',
      'assets/setup/avatar3.png'
    ],
        '544+ users joined',
        'MASSIVE UPPER BODY',
        'Lose belly fat, get ripped abs in just 4 weeks with this efficient plan. It also helps pump up your arms, strengthen your back & shoulders. No equipment needed!',
        'assets/setup/recommended.png'),
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
                    text: 'Almost there, choose your desired fitness plan',
                    color: WHITE,
                    size: 25),
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
                        selectedPlan = index;
                      });
                    },
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Opacity(
                              opacity: pageViewIndex == selectedPlan ? 1 : 0.3,
                              child: Stack(children: [
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(top: 15),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(
                                            cardList[itemIndex].image,
                                            fit: BoxFit.cover))),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          margin: EdgeInsets.only(left: 20),
                                          decoration: BoxDecoration(
                                              color: BLACK,
                                              border:
                                                  Border.all(color: PRIMARY),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: customTextWidget.boldText(
                                              text: '👍 RECOMMENDED FOR YOU',
                                              color: WHITE,
                                              size: 15)),
                                      Spacer(),
                                      Container(
                                          width: double.infinity,
                                          height: 30,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Stack(
                                            children: List.generate(
                                                cardList[itemIndex]
                                                    .avatars
                                                    .length,
                                                (index) => Positioned(
                                                    left: 15.0 * index,
                                                    child: Image.asset(
                                                        cardList[itemIndex]
                                                            .avatars[index]))),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: customTextWidget.boldText(
                                              text: cardList[itemIndex].caption,
                                              color: WHITE,
                                              size: 15)),
                                      Divider(
                                          height: 2,
                                          indent: 10,
                                          endIndent: 200,
                                          thickness: 1,
                                          color: WHITE),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: customTextWidget.boldText(
                                            text: cardList[itemIndex].title,
                                            color: WHITE,
                                            size: 35),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: customTextWidget.mediumText(
                                            text: cardList[itemIndex].desc,
                                            color: WHITE,
                                            size: 15),
                                      ),
                                      SizedBox(height: 30)
                                    ])
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
                      MaterialPageRoute(builder: (context) => Coach()));
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
  List<String> avatars;
  String caption;
  String title;
  String desc;
  String image;

  CardModel(this.avatars, this.caption, this.title, this.desc, this.image);
}

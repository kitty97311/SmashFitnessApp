import 'package:flutter/material.dart';
import '../main.dart';
import 'package:exercise_app/CustomWidgets/CustomCheck.dart';
import '../Themes.dart';

CustomCheck customCheck = CustomCheck();

class Subscribe extends StatefulWidget {
  @override
  _SubscribeState createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
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
    double WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: BLACK,
        body: Stack(children: [
          ListView(
            children: [
              Stack(children: [
                Container(
                    width: WIDTH,
                    padding: EdgeInsets.only(bottom: 100),
                    child: Image.asset('assets/setup/subscribe.png',
                        fit: BoxFit.cover)),
                Positioned(
                    bottom: 0,
                    width: WIDTH,
                    child: Column(children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [BLACK.withOpacity(0.1), BLACK])),
                          child: Column(children: [
                            customTextWidget.boldText(
                                text: 'Smarter workouts.\nBetter results!',
                                color: PRIMARY,
                                size: 30,
                                alignment: TextAlign.center),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: customTextWidget.mediumText(
                                    text:
                                        'Join the Smash Revolution and get full access to carefully selected professional workout plans personalized for you',
                                    color: WHITE,
                                    size: 14,
                                    alignment: TextAlign.center))
                          ])),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                  color: BLACK,
                                  border: Border.all(color: PRIMARY),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(children: [
                                InkWell(
                                    onTap: () {},
                                    child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: PRIMARY),
                                            borderRadius:
                                                BorderRadius.circular(100)))),
                                SizedBox(width: 16),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customTextWidget.mediumText(
                                          text: 'Goal', color: WHITE, size: 15),
                                      customTextWidget.boldText(
                                          text: '\$10.99',
                                          color: PRIMARY,
                                          size: 15),
                                    ])
                              ]))),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                  color: BLACK,
                                  border: Border.all(color: PRIMARY),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(children: [
                                InkWell(
                                    onTap: () {},
                                    child: customCheck.confirm(
                                        size: 25, iconSize: 20)),
                                SizedBox(width: 16),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customTextWidget.mediumText(
                                          text: 'Goal', color: WHITE, size: 15),
                                      customTextWidget.boldText(
                                          text: '\$10.99',
                                          color: PRIMARY,
                                          size: 15),
                                    ]),
                                Spacer(),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      customTextWidget.mediumText(
                                          text: '\$6.41/month',
                                          color: WHITE,
                                          size: 12),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: PRIMARY,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: customTextWidget.mediumText(
                                            text: 'Save 41%',
                                            color: BLACK,
                                            size: 14),
                                      )
                                    ])
                              ])))
                    ]))
              ]),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: PRIMARY,
                      ),
                      child: Center(
                        child: customTextWidget.boldText(
                            text: 'Try Free & Subscribe',
                            color: BLACK,
                            size: ipad ? 30 : 20),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: customTextWidget.mediumText(
                    text:
                        'Smash your goals! Instant access to hundreds of individual workouts and dozens of monthly programs, 100% Risk free.',
                    color: WHITE,
                    size: 12,
                    alignment: TextAlign.center),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                    child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '7-day free trial.',
                        style: TextStyle(
                          color: PRIMARY,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: ' Then \$76.99 per 12 months',
                        style: TextStyle(
                          color: WHITE,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                      child: Text(
                    'Restore Purchases',
                    style: TextStyle(
                        color: LIGHT_GREY_TEXT,
                        decorationColor: PRIMARY,
                        decoration: TextDecoration.underline),
                  ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: customTextWidget.boldText(
                    text: 'Used by millions, Personalized for you',
                    color: PRIMARY,
                    size: 18,
                    alignment: TextAlign.center),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                customTextWidget.mediumText(
                    text: '4.7', color: WHITE, size: 20),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 25,
                    )),
                customTextWidget.mediumText(
                    text: '150,000+ reviews', color: WHITE, size: 20),
              ]),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: GRAY,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ]),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: customTextWidget.mediumText(
                                        text:
                                            'Staying active is crucial. This app ha been a lifesaver. I\'ve improved....',
                                        color: WHITE,
                                        size: 12),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: customTextWidget.mediumText(
                                        text: '@Maria M., 24 years old',
                                        color: LIGHT_GREY_TEXT,
                                        size: 12),
                                  ),
                                ]))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: GRAY,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ]),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: customTextWidget.mediumText(
                                        text:
                                            'Staying active is crucial. This app ha been a lifesaver. I\'ve improved....',
                                        color: WHITE,
                                        size: 12),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: customTextWidget.mediumText(
                                        text: '@Maria M., 24 years old',
                                        color: LIGHT_GREY_TEXT,
                                        size: 12),
                                  ),
                                ]))),
                  ]))
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
              ))
        ]));
  }
}

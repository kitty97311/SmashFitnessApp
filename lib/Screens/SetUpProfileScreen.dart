import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/Modals/UserModal.dart';
import 'package:exercise_app/CustomWidgets/CustomTextWidget.dart';
import 'package:exercise_app/Screens/Loading.dart';
import 'package:exercise_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../CustomWidgets/CustomDialogues.dart';
import '../Themes.dart';

class SetUpProfileScreen extends StatefulWidget {
  @override
  _SetUpProfileScreenState createState() => _SetUpProfileScreenState();
}

class _SetUpProfileScreenState extends State<SetUpProfileScreen> {
  CustomTextWidget customWidgetClass = CustomTextWidget();
  CarouselController bodyCarouselController = CarouselController();
  bool guest = true;
  List<String> header = ['01', 'GOALS & FOCUS'];
  int currentStep = 0;
  int selectedIntenseLevel = 0;
  int selectedSmashGoal = 0;
  int selectedTimesInWeek = 0;
  int selectedGender = 0;
  int selectedBody = 1;
  int selectedMotivation = 0;
  int selectedLevel = 0;
  int selectedPlace = 0;
  int selectedGym = 0;
  int selectedFeedback = 0;
  int selectedHeightUnit = 1;
  int selectedWeightUnit = 1;
  int selectedCommitPerWeek = 2;
  int selectedActivityPattern = 1;
  int selectedDuration = 0;
  int selectedFeelResult = 0;
  int selectedLastTime = 0;
  List<Widget>? screens;
  UserModal? userModal;
  List<IntenseCardModel> intenselyList = [
    IntenseCardModel(LOW[LANGUAGE_TYPE], LOW_EXPLANATION[LANGUAGE_TYPE]),
    IntenseCardModel(
        MODERATE[LANGUAGE_TYPE], MODERATE_EXPLANATION[LANGUAGE_TYPE]),
    IntenseCardModel(HIGH[LANGUAGE_TYPE], HIGH_EXPLANATION[LANGUAGE_TYPE]),
  ];
  List<ImageCardModel> goalList = [
    ImageCardModel('Lose Weight', '', 'assets/setup/loseWeight.png'),
    ImageCardModel('Build Muscle', '', 'assets/setup/buildMuscle.png'),
    ImageCardModel('Overall Fitness', '', 'assets/setup/overallFitness.png'),
  ];
  List<ImageCardModel> gymList = [
    ImageCardModel(
        'Nope,\nBodyweight\nexercises only', '', 'assets/setup/nogym.png'),
    ImageCardModel(
        'Yes,\nGym exercises\nare also needed', '', 'assets/setup/gym.png'),
  ];
  List<ImageCardModel> bodyList = [
    ImageCardModel('Too Thin', '', 'assets/setup/thin.png'),
    ImageCardModel('Average', '', 'assets/setup/average.png'),
    ImageCardModel('Too Heavy', '', 'assets/setup/heavy.png'),
  ];
  List<ImageCardModel> feedbackList = [
    ImageCardModel(
        'Join the Smash Revolution and create your own success story',
        '@Maria M., 24 years old',
        'assets/setup/feedback.png'),
    ImageCardModel(
        'Staying active is crucial. This app ha been a lifesaver. I\'ve improved....',
        '@Maria M., 24 years old',
        'assets/setup/feedback2.png'),
  ];
  List<ImageCardModel> feelList = [
    ImageCardModel('Feel Happier Overall', '', 'assets/setup/upper-body.png'),
    ImageCardModel('Feel more confident', '', 'assets/setup/confidence.png'),
    ImageCardModel('Feel proud of myself', '', 'assets/setup/proud.png'),
    ImageCardModel('Be more energetic', '', 'assets/setup/energy.png'),
    ImageCardModel(
        'Less concerned with my health', '', 'assets/setup/healthcare.png'),
    ImageCardModel('other', '', 'assets/setup/more-information.png'),
  ];
  List<Map<String, dynamic>> focusAreas = [
    {'text': 'Toned Full Body', 'focus': false},
    {'text': 'Powerful Arms', 'focus': false},
    {'text': 'Bigger Chest', 'focus': false},
    {'text': 'Sculpted Abs', 'focus': false},
    {'text': 'Strong Legs', 'focus': false},
  ];

  List<String> motivationList = [
    'Physical Appearance',
    'Better Overall health',
    'Strength & Conditioning',
    'Boost Confidence',
    'Decrease Pain'
  ];
  List<String> lastTimeList = [
    'Right now',
    '<1 year ago',
    '1-3 years ago',
    '>3 years ago',
    'Never'
  ];
  List<String> levelList = ['Beginner', 'Intermediate', 'Advanced'];
  List<String> placeList = ['At home', 'At the gym', 'Outdoors'];
  List<String> durationList = [
    'Short, 10-20 mins',
    'Medium, 30 mins',
    'Long, 60 mins',
    'Max, 90 mins'
  ];
  List<Map<String, dynamic>> heightList = [
    {'unit': 'cm', 'min': 90, 'max': 250, 'gap': 1},
    {'unit': 'ft', 'min': 3, 'max': 8, 'gap': 12},
  ];
  List<Map<String, dynamic>> weightList = [
    {'unit': 'kg', 'min': 30, 'max': 250, 'gap': 10},
    {'unit': 'lb', 'min': 66, 'max': 551, 'gap': 10},
  ];
  List<IntenseCardModel> timesInWeekList = [
    IntenseCardModel(TWO_THREE_TIMES_IN_WEEK[LANGUAGE_TYPE],
        TWO_THREE_TIMES_IN_WEEK_EXPLANATION[LANGUAGE_TYPE]),
    IntenseCardModel(FIVE_DAYS_IN_WEEK[LANGUAGE_TYPE],
        FIVE_DAYS_IN_WEEK_EXPLANATION[LANGUAGE_TYPE]),
    IntenseCardModel(ALL_SEVEN_DAYS[LANGUAGE_TYPE],
        ALL_SEVEN_DAYS_EXPLANATION[LANGUAGE_TYPE]),
  ];
  double? WIDTH;
  double? HEIGHT;
  ScrollController scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  int currentAge = 14;
  double currentAgeScroller = 14;
  int currentBirth = 15;
  List<int> currentHeight = [10, 10];
  List<int> currentWeight = [10, 10];
  List<int> targetWeight = [10, 10];
  CarouselController carouselControllerAge = CarouselController();
  CarouselController carouselControllerHeight = CarouselController();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeHeader(bool next) {
    if (next)
      currentStep++;
    else
      currentStep--;
    if (currentStep < 7) {
      header[0] = '01';
      header[1] = 'GOALS & FOCUS';
    }
    if (currentStep >= 7 && currentStep < 12) {
      header[0] = '02';
      header[1] = 'KNOW YOUR BODY';
    }
    if (currentStep >= 12) {
      header[0] = '03';
      header[1] = 'FITNESS ASSESSMENT';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    WIDTH = MediaQuery.of(context).size.width;
    HEIGHT = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: BLACK,
        appBar: AppBar(
          toolbarHeight: 55,
          elevation: 0,
          backgroundColor: BLACK,
          leading: Padding(
            padding: EdgeInsets.only(top: 10),
            child: IconButton(
              onPressed: () {
                if (currentStep > 0) {
                  changeHeader(false);
                }
              },
              icon: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: TAB_GREY.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: WHITE,
                  size: 18,
                ),
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 10, left: (WIDTH! - 50 - 280) * 0.5),
            child: Row(children: [
              Container(
                width: 28,
                height: 28,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: PRIMARY),
                child: Center(
                  child: customWidgetClass.boldText(
                      text: header[0], color: BLACK, size: 18),
                ),
              ),
              customWidgetClass.boldText(
                  text: header[1], color: WHITE, size: 18),
            ]),
          ),
        ),
        body: body(),
      ),
    );
  }

  body() {
    List<Map<String, dynamic>> gap = [];
    gap.add(
        {"LPadding": 10.0, "RPadding": 0.0, "LRadius": 100.0, "RRadius": 0.0});
    gap.add(
        {"LPadding": 0.0, "RPadding": 10.0, "LRadius": 0.0, "RRadius": 100.0});
    gap.add(
        {"LPadding": 10.0, "RPadding": 0.0, "LRadius": 100.0, "RRadius": 0.0});
    gap.add(
        {"LPadding": 0.0, "RPadding": 10.0, "LRadius": 0.0, "RRadius": 100.0});
    gap.add(
        {"LPadding": 10.0, "RPadding": 0.0, "LRadius": 100.0, "RRadius": 0.0});
    gap.add(
        {"LPadding": 0.0, "RPadding": 10.0, "LRadius": 0.0, "RRadius": 100.0});
    List<int> progress = [];
    if (currentStep < 7) progress = [1, 0, 0, 0, 0, 0];
    if (currentStep >= 7 && currentStep < 12) progress = [1, 1, 1, 0, 0, 0];
    if (currentStep >= 12) progress = [1, 1, 1, 1, 1, 0];
    return WillPopScope(
      onWillPop: () async {
        if (currentStep > 0) {
          setState(() {
            currentStep--;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: List.generate(
                    6,
                    (index) => Expanded(
                        child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                                color: progress[index] > 0
                                    ? PRIMARY
                                    : LIGHT_GREY_SCREEN_BACKGROUND,
                                borderRadius: BorderRadius.horizontal(
                                    left:
                                        Radius.circular(gap[index]["LRadius"]),
                                    right: Radius.circular(
                                        gap[index]["RRadius"]))),
                            margin: EdgeInsets.only(
                                left: gap[index]["LPadding"],
                                right: gap[index]["RPadding"])))),
              ),
            ),
            decoration: BoxDecoration(color: BLACK),
          ),
          Expanded(child: widgetToDisplay()),
          // bottomButtons(),
        ],
      ),
    );
  }

  widgetToDisplay() {
    if (currentStep == 0) {
      return stepOne();
    } else if (currentStep == 1) {
      return stepTwo();
    } else if (currentStep == 2) {
      return stepThree();
    } else if (currentStep == 3) {
      return stepFour();
    } else if (currentStep == 4) {
      return stepFive();
    } else if (currentStep == 5) {
      return stepSix();
    } else if (currentStep == 6) {
      return stepSeven();
    } else if (currentStep == 7) {
      return stepEight();
    } else if (currentStep == 8) {
      return stepNine();
    } else if (currentStep == 9) {
      return stepTen();
    } else if (currentStep == 10) {
      return stepEleven();
    } else if (currentStep == 11) {
      return stepTwelve();
    } else if (currentStep == 12) {
      return stepThirteen();
    } else if (currentStep == 13) {
      return stepFourteen();
    } else if (currentStep == 14) {
      return stepFifteen();
    } else if (currentStep == 15) {
      return stepSixteen();
    } else if (currentStep == 16) {
      return stepSeventeen();
    } else if (currentStep == 17) {
      return stepEighteen();
    } else if (currentStep == 18) {
      return stepNineteen();
    } else if (currentStep == 19) {
      return stepTwenty();
    } else if (currentStep == 20) {
      return stepTwentyOne();
    } else if (currentStep == 21) {
      return stepTwentyTwo();
    }
  }

  Widget stepOne() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MAINPADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                customTextWidget.boldText(
                    text: 'Hey, \nElla  👋', color: PRIMARY, size: 35),
                // Stack(children: [
                //   Container(
                //     width: 54,
                //     height: 108,
                //     decoration: BoxDecoration(
                //       color: PRIMARY,
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(100),
                //           topRight: Radius.zero,
                //           bottomLeft: Radius.circular(100),
                //           bottomRight: Radius.zero),
                //     ),
                //   ),
                //   Image.asset(
                //     "assets/splash/model1.png",
                //     width: 100,
                //   ),
                // ]),
              ]),
          SizedBox(
            height: 16,
          ),
          customTextWidget.regularText(
              text:
                  'Welcome to Smash fitness, I\'m your virtual A.I trainer. Together we are going to conquer your fitness goals, but first I need to ask you a few questions to create your personalized workout plan to fit your specific needs.',
              color: WHITE,
              size: ipad ? 30 : 19),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (currentStep < 21) {
                if (validateFields()) {
                  changeHeader(true);
                }
              } else {
                registerUser();
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: PRIMARY,
              ),
              child: Center(
                child: customWidgetClass.boldText(
                    text: 'I\'m Ready', color: BLACK, size: ipad ? 35 : 25),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  // Name Request Step
  // Widget stepOne() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 30,),
  //         customTextWidget.boldText(
  //             text: WHATS_YOUR_NAME,
  //             color: BLACK,
  //             size: ipad ? 50 :25
  //         ),
  //         SizedBox(height: 16,),
  //         customTextWidget.mediumText(
  //             text: ALTERNATIVELY_REFERED_TO_AS_AN_ACCOUNT_NAME_LOGIN_ID_NICK_NAME_AND_USER_ID_USERNAME_OR_USER_NAME_THE_NAME_GIVEN_TO_A_USER_ON,
  //             color: LIGHT_GREY_TEXT,
  //             size: ipad ? 20 : 12
  //         ),

  //         SizedBox(height: 30,),
  //         customTextWidget.boldText(
  //             text: USER_NAME,
  //             color: BLACK,
  //             size: ipad ? 40 :25
  //         ),

  //         Form(
  //           key: _formKey,
  //           child: TextFormField(
  //             controller: nameController,

  //             validator: (value){

  //               if (value!.isEmpty) {
  //                 return THIS_FIELD_IS_REQUIRED[LANGUAGE_TYPE];
  //               }
  //               return null;
  //             },
  //             // onSaved: (value) {
  //             //   namecontroller.text = value;
  //             // },
  //             decoration: InputDecoration(
  //               contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
  //               isCollapsed: true,
  //               hintText: YOUR_NAME_HERE[LANGUAGE_TYPE],
  //               hintStyle: TextStyle(
  //                   color: TAB_GREY_DARK,
  //                   fontFamily: 'Bold',
  //                   fontSize: ipad ? 20 : 15
  //               ),
  //               border: UnderlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: LIGHT_GREY_TEXT,
  //                     width: 0.5,
  //                   )
  //               ),
  //               disabledBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: LIGHT_GREY_TEXT,
  //                     width: 0.5,
  //                   )
  //               ),
  //               enabledBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: LIGHT_GREY_TEXT,
  //                     width: 0.5,
  //                   )
  //               ),
  //               focusedBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: LIGHT_GREY_TEXT,
  //                     width: 0.5,
  //                   )
  //               ),
  //             ),

  //             style: TextStyle(
  //                 color: LIGHT_GREY_TEXT,
  //                 fontFamily: 'Bold',
  //                 fontSize: ipad ? 26 : 13
  //             ),

  //           ),
  //         ),

  //       ],
  //     ),
  //   );
  // }

  Widget stepTwo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: customTextWidget.mediumText(
                text: 'Select your Gender', color: WHITE, size: ipad ? 50 : 30),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: GRAY, borderRadius: BorderRadius.circular(10)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: customTextWidget.mediumText(
                          text: '💡', color: WHITE, size: 30)),
                  SizedBox(width: 16),
                  Expanded(
                    child: customTextWidget.mediumText(
                        text:
                            'Knowing your gender can help us tailor the intensity for you based on different metabolic rates.',
                        color: WHITE,
                        size: 16),
                  )
                ]),
          ),
          SizedBox(
            height: 90,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 10,
                child: genderCard(
                    MALE[LANGUAGE_TYPE], "assets/splash/male.png", 0),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 10,
                child: genderCard(
                    FEMALE[LANGUAGE_TYPE], "assets/splash/female.png", 1),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              if (currentStep < 21) {
                if (validateFields()) {
                  changeHeader(true);
                }
              } else {
                registerUser();
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: PRIMARY, width: 2)),
              child: Center(
                child: customTextWidget.mediumText(
                    text: 'Prefer not to say',
                    color: WHITE,
                    size: ipad ? 35 : 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Mobile Number Request Step
  // Widget stepTwo() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           height: 30,
  //         ),
  //         customTextWidget.boldText(
  //             text: WHATS_YOUR_CONTACT_NUMBER,
  //             color: BLACK,
  //             size: ipad ? 50 : 25),
  //         SizedBox(
  //           height: 16,
  //         ),
  //         customTextWidget.mediumText(
  //             text: ALTERNATIVELY_REFERED_TO_AS_AN_MOBILE_NUMBER_,
  //             color: LIGHT_GREY_TEXT,
  //             size: ipad ? 25 : 12),
  //         SizedBox(
  //           height: 30,
  //         ),
  //         customTextWidget.boldText(
  //             text: MOBILE_NUMBER, color: BLACK, size: ipad ? 50 : 25),
  //         Form(
  //           key: _formKey,
  //           child: TextFormField(
  //             controller: phoneController,
  //             keyboardType: TextInputType.number,
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return THIS_FIELD_IS_REQUIRED[LANGUAGE_TYPE];
  //               }
  //               return null;
  //             },
  //             decoration: InputDecoration(
  //               contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
  //               isCollapsed: true,
  //               hintText: YOUR_MOBILE_NUMBER_HERE[LANGUAGE_TYPE],
  //               hintStyle: TextStyle(
  //                   color: TAB_GREY_DARK,
  //                   fontFamily: 'Bold',
  //                   fontSize: ipad ? 30 : 15),
  //               border: UnderlineInputBorder(
  //                   borderSide: BorderSide(
  //                 color: LIGHT_GREY_TEXT,
  //                 width: 0.5,
  //               )),
  //               disabledBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(
  //                 color: LIGHT_GREY_TEXT,
  //                 width: 0.5,
  //               )),
  //               enabledBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(
  //                 color: LIGHT_GREY_TEXT,
  //                 width: 0.5,
  //               )),
  //               focusedBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(
  //                 color: LIGHT_GREY_TEXT,
  //                 width: 0.5,
  //               )),
  //             ),
  //             style: TextStyle(
  //                 color: LIGHT_GREY_TEXT,
  //                 fontFamily: 'Bold',
  //                 fontSize: ipad ? 26 : 13),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget stepThree() {
    return Column(children: [
      Container(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: customTextWidget.mediumText(
                    text: 'Choose your focus areas',
                    color: WHITE,
                    size: ipad ? 50 : 30),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
            width: double.infinity,
            height: HEIGHT! * 0.5,
            child: Row(children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        focusAreas.length,
                        (index) =>
                            noTypeCard(focusAreas[index]['text'], '', index)),
                  )),
              Expanded(
                  flex: 1,
                  child: Image.asset(
                      selectedGender == 0
                          ? 'assets/setup/focusMale.png'
                          : 'assets/setup/focusFemale.png',
                      fit: BoxFit.fitHeight))
            ])),
      ])),
      Spacer(),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (currentStep < 21) {
                if (validateFields()) {
                  changeHeader(true);
                }
              } else {
                registerUser();
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: PRIMARY,
              ),
              child: Center(
                child: customWidgetClass.mediumText(
                    text: 'Next', color: BLACK, size: ipad ? 35 : 25),
              ),
            ),
          ))
    ]);
  }

  intenseLevelCard(String title, String subTitle, int index) => InkWell(
        onTap: () {
          setState(() {
            selectedIntenseLevel = index;
          });
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selectedIntenseLevel == index ? ORANGE : null,
              border: selectedIntenseLevel != index
                  ? Border.all(width: 2, color: BLUE)
                  : Border.all(color: Colors.transparent)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              customTextWidget.boldText(
                  text: title,
                  color: selectedIntenseLevel == index ? WHITE : BLUE,
                  size: ipad ? 40 : 20),
              SizedBox(
                height: 10,
              ),
              customTextWidget.mediumText(
                  text: subTitle,
                  color:
                      selectedIntenseLevel == index ? WHITE : LIGHT_GREY_TEXT,
                  size: ipad ? 24 : 12),
            ],
          ),
        ),
      );

  imageTypeCard(
          String title, String subTitle, String image, int index, int step) =>
      InkWell(
        onTap: () {
          setState(() {
            if (step == 3) selectedSmashGoal = index;
            if (step == 18) selectedGym = index;
          });
          if (currentStep < 21) {
            if (validateFields()) {
              changeHeader(true);
            }
          } else {
            registerUser();
          }
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
            padding: EdgeInsets.only(left: 18),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: GRAY,
                border: selectedSmashGoal == index
                    ? Border.all(width: 1, color: PRIMARY)
                    : Border.all(color: Colors.transparent)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customTextWidget.mediumText(
                          text: title,
                          color: selectedSmashGoal == index ? PRIMARY : WHITE,
                          size: ipad ? 40 : 25),
                      if (subTitle.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: customTextWidget.mediumText(
                              text: subTitle,
                              color: selectedSmashGoal == index
                                  ? PRIMARY
                                  : LIGHT_GREY_TEXT,
                              size: ipad ? 24 : 12),
                        )
                    ],
                  ),
                  Image.asset(
                    image,
                    height: 120,
                  )
                ])),
      );

  noTypeCard(String text, String caption, int index) => InkWell(
        onTap: () {
          if (index == 0) {
            focusAreas[0]['focus'] = !focusAreas[0]['focus'];
            focusAreas[1]['focus'] = focusAreas[0]['focus'];
            focusAreas[2]['focus'] = focusAreas[0]['focus'];
            focusAreas[3]['focus'] = focusAreas[0]['focus'];
            focusAreas[4]['focus'] = focusAreas[0]['focus'];
            setState(() {});
          } else {
            setState(() {
              focusAreas[index]['focus'] = !focusAreas[index]['focus'];
            });
          }
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: GRAY,
                border: focusAreas[index]['focus']
                    ? Border.all(width: 1, color: PRIMARY)
                    : Border.all(color: Colors.transparent)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  customTextWidget.mediumText(
                      text: text,
                      color: focusAreas[index]['focus'] ? PRIMARY : WHITE,
                      size: ipad ? 40 : 20),
                  if (caption.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: customTextWidget.mediumText(
                          text: caption,
                          color: focusAreas[index]['focus']
                              ? PRIMARY
                              : LIGHT_GREY_TEXT,
                          size: ipad ? 24 : 12),
                    )
                ],
              ),
            )),
      );

  optionTypeCard(String title, String subTitle, int index, int step) => InkWell(
        onTap: () {
          setState(() {
            if (step == 4) selectedMotivation = index;
            if (step == 10) selectedLastTime = index;
            if (step == 16) selectedLevel = index;
            if (step == 17) selectedPlace = index;
            if (step == 19) selectedDuration = index;
          });
          if (currentStep < 21) {
            if (validateFields()) {
              changeHeader(true);
            }
          } else {
            registerUser();
          }
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 22, horizontal: 18),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: GRAY,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (step == 4)
                        customTextWidget.mediumText(
                            text: title,
                            color:
                                selectedMotivation == index ? PRIMARY : WHITE,
                            size: ipad ? 40 : 25),
                      if (step == 10)
                        customTextWidget.mediumText(
                            text: title,
                            color: selectedLastTime == index ? PRIMARY : WHITE,
                            size: ipad ? 40 : 25),
                      if (step == 16)
                        customTextWidget.mediumText(
                            text: title,
                            color: selectedLevel == index ? PRIMARY : WHITE,
                            size: ipad ? 40 : 25),
                      if (step == 17)
                        customTextWidget.mediumText(
                            text: title,
                            color: selectedPlace == index ? PRIMARY : WHITE,
                            size: ipad ? 40 : 25),
                      if (step == 19)
                        customTextWidget.mediumText(
                            text: title,
                            color: selectedDuration == index ? PRIMARY : WHITE,
                            size: ipad ? 40 : 25),
                      if (subTitle.isNotEmpty && step == 4)
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: customTextWidget.mediumText(
                              text: subTitle,
                              color: selectedMotivation == index
                                  ? PRIMARY
                                  : LIGHT_GREY_TEXT,
                              size: ipad ? 24 : 12),
                        ),
                      if (subTitle.isNotEmpty && step == 10)
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: customTextWidget.mediumText(
                              text: subTitle,
                              color: selectedLastTime == index
                                  ? PRIMARY
                                  : LIGHT_GREY_TEXT,
                              size: ipad ? 24 : 12),
                        ),
                      if (subTitle.isNotEmpty && step == 16)
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: customTextWidget.mediumText(
                              text: subTitle,
                              color: selectedLevel == index
                                  ? PRIMARY
                                  : LIGHT_GREY_TEXT,
                              size: ipad ? 24 : 12),
                        ),
                      if (subTitle.isNotEmpty && step == 17)
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: customTextWidget.mediumText(
                              text: subTitle,
                              color: selectedPlace == index
                                  ? PRIMARY
                                  : LIGHT_GREY_TEXT,
                              size: ipad ? 24 : 12),
                        ),
                      if (subTitle.isNotEmpty && step == 19)
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: customTextWidget.mediumText(
                              text: subTitle,
                              color: selectedDuration == index
                                  ? PRIMARY
                                  : LIGHT_GREY_TEXT,
                              size: ipad ? 24 : 12),
                        ),
                    ],
                  ),
                  if (step == 4)
                    Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: selectedMotivation == index
                                ? PRIMARY
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(100))),
                  if (step == 10)
                    Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: selectedLastTime == index
                                ? PRIMARY
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(100))),
                  if (step == 16)
                    Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: selectedLevel == index
                                ? PRIMARY
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(100))),
                  if (step == 17)
                    Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: selectedPlace == index
                                ? PRIMARY
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(100))),
                  if (step == 19)
                    Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: selectedDuration == index
                                ? PRIMARY
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(100))),
                ])),
      );

  Widget stepFour() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'Define your Smash goals',
                  color: WHITE,
                  size: ipad ? 50 : 30),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: GRAY, borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: customTextWidget.mediumText(
                            text: 'S', color: WHITE, size: 30)),
                    SizedBox(width: 16),
                    Expanded(
                      child: customTextWidget.mediumText(
                          text:
                              'We’ll tailor the best blend of strength and cardio training to align with your goal.',
                          color: WHITE,
                          size: 16),
                    )
                  ]),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  goalList.length,
                  (index) => imageTypeCard(
                      goalList[index].title,
                      goalList[index].subTitle,
                      goalList[index].image,
                      index,
                      currentStep)),
            )
          ],
        ),
      ),
    );
  }

  genderCard(String name, String imagePath, int index) {
    return InkWell(
        onTap: () {
          setState(() {
            selectedGender = index;
          });
          if (currentStep < 21) {
            if (validateFields()) {
              changeHeader(true);
            }
          } else {
            registerUser();
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
                color: selectedGender == index ? PRIMARY : GRAY, width: 1),
            borderRadius: BorderRadius.circular(12),
            color: GRAY,
          ),
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 15, bottom: 100),
                  child: OverflowBox(
                    minWidth: 0,
                    maxWidth: double.infinity,
                    minHeight: 0,
                    maxHeight: double.infinity,
                    child: Image.asset(imagePath),
                  ),
                ),
                Container(
                  height: 75,
                  margin: EdgeInsets.only(top: 140),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF111111).withOpacity(0.1), GRAY])),
                )
              ]),
              SizedBox(
                height: 10,
              ),
              customTextWidget.mediumText(
                  text: name, color: WHITE, size: ipad ? 40 : 20)
            ],
          ),
        ));
  }

  Widget stepFive() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'Select your main\nmotivations',
                  color: WHITE,
                  size: ipad ? 50 : 30,
                  alignment: TextAlign.center),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  motivationList.length,
                  (index) => optionTypeCard(
                      motivationList[index], '', index, currentStep)),
            )
          ],
        ),
      ),
    );
  }

  // Widget stepFive() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           height: 30,
  //         ),
  //         customTextWidget.boldText(
  //             text: HOW_OLD_ARE_YOU, color: BLACK, size: ipad ? 50 : 25),
  //         SizedBox(
  //           height: 16,
  //         ),
  //         customTextWidget.mediumText(
  //             text: AGE_EXPLANATION,
  //             color: LIGHT_GREY_TEXT,
  //             size: ipad ? 25 : 12),
  //         SizedBox(
  //           height: 30,
  //         ),
  //         Expanded(
  //           child: Stack(
  //             children: [
  //               CarouselSlider.builder(
  //                 itemCount: 1,
  //                 options: CarouselOptions(
  //                   autoPlay: false,
  //                   scrollDirection: Axis.vertical,
  //                   enlargeCenterPage: true,
  //                   height: double.maxFinite,
  //                   viewportFraction: 0.14,
  //                   aspectRatio: 2,
  //                   enableInfiniteScroll: false,
  //                   scrollPhysics: BouncingScrollPhysics(),
  //                   initialPage: 1,
  //                   pageSnapping: true,
  //                 ),
  //                 itemBuilder: (BuildContext context, int itemIndex,
  //                         int pageViewIndex) =>
  //                     Center(
  //                   child: Container(
  //                       width: 90,
  //                       height: double.maxFinite,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         border: Border.all(color: BLUE),
  //                         color: (currentAgeScroller %
  //                                     currentAgeScroller.toInt()) ==
  //                                 0
  //                             ? BLUE
  //                             : Colors.transparent, // BLUE,
  //                       ),
  //                       child: Center(
  //                         child: customTextWidget.boldText(
  //                             text: itemIndex.toString(),
  //                             color: Colors.transparent,
  //                             size: ipad ? 55 : 30),
  //                       )),
  //                 ),
  //               ),

  //               ///-----------------------

  //               CarouselSlider.builder(
  //                 itemCount: 100,
  //                 key: Key("ageSlider"),
  //                 options: CarouselOptions(
  //                     autoPlay: false,
  //                     scrollDirection: Axis.vertical,
  //                     enlargeCenterPage: false,
  //                     height: double.maxFinite,
  //                     viewportFraction: 0.13,
  //                     aspectRatio: 1,
  //                     enableInfiniteScroll: false,
  //                     scrollPhysics: BouncingScrollPhysics(),
  //                     initialPage: currentAge,
  //                     pageSnapping: true,
  //                     onScrolled: (val) {
  //                       setState(() {
  //                         currentAge = val!.toInt().floor();
  //                         currentAgeScroller = val;
  //                         print("CURRENT AGE : $currentBirth");
  //                       });
  //                     }),
  //                 itemBuilder: (BuildContext context, int itemIndex,
  //                         int pageViewIndex) =>
  //                     Center(
  //                   child: Container(
  //                       width: 80,
  //                       height: double.maxFinite,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         //color: Colors.blue,
  //                       ),
  //                       child: Opacity(
  //                         opacity: indexToOpacity(itemIndex),
  //                         child: currentAgeScroller == itemIndex
  //                             ? Align(
  //                                 alignment: Alignment.center,
  //                                 child: customTextWidget.mediumText(
  //                                   text: (itemIndex + 1).toString(),
  //                                   color: WHITE,
  //                                   size: indexToSize(itemIndex),
  //                                 ),
  //                               )
  //                             : Align(
  //                                 alignment: Alignment.center,
  //                                 child: customTextWidget.boldText(
  //                                   text: (itemIndex + 1).toString(),
  //                                   color: LIGHT_GREY_TEXT,
  //                                   size: indexToSize(itemIndex),
  //                                 ),
  //                               ),
  //                       )),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 30,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  double indexToSize(int index) {
    if (index == currentAge) {
      return 35;
    } else if (index < currentAge) {
      return currentAge - index < 5 ? 30 - (currentAge - index) * 4.0 : 0.0;
    } else if (index > currentAge) {
      return index - currentAge < 5 ? 30 - (index - currentAge) * 4.0 : 0.0;
    } else {
      return 10;
    }
  }

  double indexToOpacity(int index) {
    if (index == currentAge) {
      return 1.0;
    } else if (index < currentAge) {
      return currentAge - index < 5 ? 1.0 - ((currentAge - index) / 5) : 0.0;
    } else if (index > currentAge) {
      return index - currentAge < 5 ? 1.0 - ((index - currentAge) / 5) : 0.0;
    } else {
      return 10;
    }
  }

  Widget stepSix() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
              child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Select your\n',
                  style: TextStyle(
                    color: WHITE,
                    fontSize: 30,
                  ),
                ),
                TextSpan(
                  text: 'current',
                  style: TextStyle(
                    color: PRIMARY,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                TextSpan(
                  text: ' body shape?',
                  style: TextStyle(
                    color: WHITE,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            child: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                        child: selectedGender == 0
                            ? Image.asset('assets/setup/currentbodyshape_m.png')
                            : Image.asset(
                                'assets/setup/currentbodyshape_f.png'))
                    // CarouselSlider.builder(
                    //   itemCount: bodyList.length,
                    //   carouselController: bodyCarouselController,
                    //   options: CarouselOptions(
                    //     viewportFraction: 0.4,
                    //     enableInfiniteScroll: false,
                    //     initialPage: 1,
                    //     onPageChanged: (index, reason) {
                    //       setState(() {
                    //         selectedBody = index;
                    //       });
                    //     },
                    //   ),
                    //   itemBuilder: (BuildContext context, int itemIndex,
                    //           int pageViewIndex) =>
                    //       Center(
                    //     child: Container(
                    //         height: 300,
                    //         child: Opacity(
                    //             opacity: pageViewIndex == selectedBody ? 1 : 0.3,
                    //             child: Image.asset(bodyList[itemIndex].image))),
                    //   ),
                    // ),
                    ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(1),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: GRAY,
                      border: Border.all(color: PRIMARY, width: 1),
                      borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: bodyList.asMap().entries.map((entry) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              selectedBody = entry.key;
                            });
                            // bodyCarouselController.jumpToPage(entry.key);
                          },
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 22),
                              margin: const EdgeInsets.symmetric(vertical: 1),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  color: (selectedBody == entry.key
                                      ? PRIMARY
                                      : null)),
                              child: customTextWidget.mediumText(
                                  text: entry.value.title,
                                  color:
                                      selectedBody == entry.key ? BLACK : WHITE,
                                  size: 18)));
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: GRAY, borderRadius: BorderRadius.circular(15)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTextWidget.mediumText(
                              text: 'Your Target Body Fat',
                              color: WHITE,
                              size: 20),
                          customTextWidget.mediumText(
                              text: '16%-23% (Reasonable Goal!)',
                              color: PRIMARY,
                              size: 25),
                          customTextWidget.mediumText(
                              text:
                                  'You are at a normal body fat level!\nTey the personalized plan for you\nfor to get filtter and healthier.',
                              color: WHITE,
                              size: 18),
                        ]))
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (currentStep < 21) {
                    if (validateFields()) {
                      changeHeader(true);
                    }
                  } else {
                    registerUser();
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PRIMARY,
                  ),
                  child: Center(
                    child: customWidgetClass.mediumText(
                        text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget stepSeven() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: customTextWidget.mediumText(
                text: 'What\'s your birth date?',
                color: WHITE,
                size: ipad ? 50 : 30),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: 1,
                  options: CarouselOptions(
                    autoPlay: false,
                    scrollDirection: Axis.vertical,
                    enlargeCenterPage: true,
                    height: double.maxFinite,
                    viewportFraction: 0.14,
                    aspectRatio: 2,
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    initialPage: 1,
                    pageSnapping: false,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Center(
                    child: Container(
                        width: 140,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: PRIMARY, width: 2),
                              bottom: BorderSide(color: PRIMARY, width: 2)),
                          color: Colors.transparent,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: customTextWidget.boldText(
                                  text: itemIndex.toString(),
                                  color: Colors.transparent,
                                  size: ipad ? 55 : 30),
                            ),
                          ],
                        )),
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: 31,
                  options: CarouselOptions(
                      autoPlay: false,
                      scrollDirection: Axis.vertical,
                      enlargeCenterPage: false,
                      height: double.maxFinite,
                      viewportFraction: 0.13,
                      aspectRatio: 1,
                      enableInfiniteScroll: false,
                      scrollPhysics: BouncingScrollPhysics(),
                      initialPage: currentBirth,
                      pageSnapping: false,
                      onScrolled: (val) {
                        setState(() {
                          currentBirth = val!.toInt().floor();
                          print("CURRENT HEIGHT : $currentBirth");
                        });
                      }),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Center(
                    child: Container(
                        width: 80,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Opacity(
                          opacity: indexToOpacity7(itemIndex),
                          child: currentBirth == itemIndex
                              ? Align(
                                  alignment: Alignment.center,
                                  child: customTextWidget.boldText(
                                    text: (itemIndex + 1).toString(),
                                    color: WHITE,
                                    size: indexToSize7(itemIndex),
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.center,
                                  child: customTextWidget.mediumText(
                                    text: (itemIndex + 1).toString(),
                                    color: LIGHT_GREY_TEXT,
                                    size: indexToSize7(itemIndex),
                                  ),
                                ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (currentStep < 21) {
                    if (validateFields()) {
                      changeHeader(true);
                    }
                  } else {
                    registerUser();
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PRIMARY,
                  ),
                  child: Center(
                    child: customWidgetClass.mediumText(
                        text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  double indexToSize7(int index) {
    if (index == currentBirth) {
      return 55;
    } else if (index < currentBirth) {
      return currentBirth - index < 5 ? 40 - (currentBirth - index) * 5.0 : 0.0;
    } else if (index > currentBirth) {
      return index - currentBirth < 5 ? 40 - (index - currentBirth) * 5.0 : 0.0;
    } else {
      return 10;
    }
  }

  double indexToOpacity7(int index) {
    if (index == currentBirth) {
      return 1.0;
    } else if (index < currentBirth) {
      return currentBirth - index < 5
          ? 1.0 - ((currentBirth - index) / 5)
          : 0.0;
    } else if (index > currentBirth) {
      return index - currentBirth < 5
          ? 1.0 - ((index - currentBirth) / 5)
          : 0.0;
    } else {
      return 10;
    }
  }

  double indexToOpacity8(int index) {
    if (index == currentHeight[selectedHeightUnit]) {
      return 1.0;
    } else if (index < currentHeight[selectedHeightUnit]) {
      return currentHeight[selectedHeightUnit] - index < 10
          ? 1.0 - ((currentHeight[selectedHeightUnit] - index) / 10)
          : 0.0;
    } else if (index > currentHeight[selectedHeightUnit]) {
      return index - currentHeight[selectedHeightUnit] < 10
          ? 1.0 - ((index - currentHeight[selectedHeightUnit]) / 10)
          : 0.0;
    } else {
      return 1;
    }
  }

  double indexToOpacity9(int index) {
    if (index == currentWeight[selectedWeightUnit]) {
      return 1.0;
    } else if (index < currentWeight[selectedWeightUnit]) {
      return currentWeight[selectedWeightUnit] - index < 10
          ? 1.0 - ((currentWeight[selectedWeightUnit] - index) / 10)
          : 0.0;
    } else if (index > currentWeight[selectedWeightUnit]) {
      return index - currentWeight[selectedWeightUnit] < 10
          ? 1.0 - ((index - currentWeight[selectedWeightUnit]) / 10)
          : 0.0;
    } else {
      return 1;
    }
  }

  double indexToOpacity10(int index) {
    if (index == targetWeight[0]) {
      return 1.0;
    } else if (index < targetWeight[0]) {
      return targetWeight[0] - index < 10
          ? 1.0 - ((targetWeight[0] - index) / 10)
          : 0.0;
    } else if (index > targetWeight[0]) {
      return index - targetWeight[0] < 10
          ? 1.0 - ((index - targetWeight[0]) / 10)
          : 0.0;
    } else {
      return 1;
    }
  }

  timesInWeekCard(String title, String subTitle, int index) => InkWell(
        onTap: () {
          setState(() {
            selectedTimesInWeek = index;
            print('selection index--------${selectedTimesInWeek}');
          });
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selectedTimesInWeek == index ? ORANGE : null,
              border: selectedTimesInWeek != index
                  ? Border.all(width: 2, color: BLUE)
                  : Border.all(color: Colors.transparent)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              customTextWidget.boldText(
                  text: title,
                  color: selectedTimesInWeek == index ? WHITE : BLUE,
                  size: ipad ? 40 : 20),
              SizedBox(
                height: 10,
              ),
              customTextWidget.mediumText(
                  text: subTitle,
                  color: selectedTimesInWeek == index ? WHITE : LIGHT_GREY_TEXT,
                  size: ipad ? 22 : 11),
            ],
          ),
        ),
      );

  Widget stepEight() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: customTextWidget.mediumText(
                text: 'What\'s your height?',
                color: WHITE,
                size: ipad ? 50 : 30),
          ),
          Center(
            child: Container(
              width: 180,
              margin: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  color: GRAY, borderRadius: BorderRadius.circular(100)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: heightList.asMap().entries.map((entry) {
                  return InkWell(
                      onTap: () {
                        setState(() {
                          selectedHeightUnit = entry.key;
                          selectedWeightUnit = entry.key;
                        });
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          width: 90,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              color: (selectedHeightUnit == entry.key
                                  ? PRIMARY
                                  : null)),
                          child: Center(
                              child: customTextWidget.boldText(
                                  text: entry.value['unit'],
                                  color: selectedHeightUnit == entry.key
                                      ? BLACK
                                      : LIGHT_GREY_TEXT,
                                  size: 20))));
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: 1,
                  options: CarouselOptions(
                    autoPlay: false,
                    scrollDirection: Axis.vertical,
                    enlargeCenterPage: true,
                    height: double.maxFinite,
                    viewportFraction: 0.14,
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    initialPage: 1,
                    pageSnapping: false,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Center(
                    child: Container(
                        width: double.infinity,
                        height: double.maxFinite,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 150,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: WHITE,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            (selectedHeightUnit == 0)
                                ? Positioned(
                                    right: 0,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: (currentHeight[
                                                        selectedHeightUnit] +
                                                    heightList[
                                                            selectedHeightUnit]
                                                        ['min'])
                                                .toString(),
                                            style: TextStyle(
                                              color: WHITE,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'cm',
                                            style: TextStyle(
                                              color: WHITE,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                : Positioned(
                                    right: 0,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: (currentHeight[
                                                            selectedHeightUnit] ~/
                                                        heightList[
                                                                selectedHeightUnit]
                                                            ['gap'] +
                                                    heightList[
                                                            selectedHeightUnit]
                                                        ['min'])
                                                .toString(),
                                            style: TextStyle(
                                              color: WHITE,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'ft ',
                                            style: TextStyle(
                                              color: WHITE,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                          TextSpan(
                                            text: (currentHeight[
                                                        selectedHeightUnit] %
                                                    heightList[
                                                            selectedHeightUnit]
                                                        ['gap'])
                                                .toString(),
                                            style: TextStyle(
                                              color: WHITE,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'in',
                                            style: TextStyle(
                                              color: WHITE,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                          ],
                        )),
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: (heightList[selectedHeightUnit]['max'] -
                          heightList[selectedHeightUnit]['min']) *
                      heightList[selectedHeightUnit]['gap'],
                  options: CarouselOptions(
                      autoPlay: false,
                      scrollDirection: Axis.vertical,
                      enlargeCenterPage: false,
                      height: double.maxFinite,
                      viewportFraction: 0.05,
                      enableInfiniteScroll: false,
                      scrollPhysics: BouncingScrollPhysics(),
                      initialPage: currentHeight[selectedHeightUnit],
                      pageSnapping: false,
                      onScrolled: (val) {
                        setState(() {
                          currentHeight[selectedHeightUnit] =
                              val!.toInt().floor();
                        });
                      }),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Center(
                    child: Container(
                      width: WIDTH! * 0.4,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Stack(children: [
                        Center(
                          child: Opacity(
                              opacity: indexToOpacity8(itemIndex),
                              child: Container(
                                width: itemIndex %
                                            heightList[selectedHeightUnit]
                                                ['gap'] ==
                                        0
                                    ? 90
                                    : 60,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: itemIndex ==
                                          currentHeight[selectedHeightUnit]
                                      ? WHITE
                                      : PRIMARY,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              )),
                        ),
                        if (itemIndex % heightList[selectedHeightUnit]['gap'] ==
                            0)
                          Positioned(
                              right: 0,
                              child: customTextWidget.mediumText(
                                text: (selectedHeightUnit == 0)
                                    ? (itemIndex +
                                            heightList[selectedHeightUnit]
                                                ['min'])
                                        .toString()
                                    : (itemIndex ~/
                                                heightList[selectedHeightUnit]
                                                    ['gap'] +
                                            heightList[selectedHeightUnit]
                                                ['min'])
                                        .toString(),
                                color: WHITE,
                                size: itemIndex ==
                                        currentHeight[selectedHeightUnit]
                                    ? 0
                                    : 18,
                              ))
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (currentStep < 21) {
                    if (validateFields()) {
                      changeHeader(true);
                    }
                  } else {
                    registerUser();
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PRIMARY,
                  ),
                  child: Center(
                    child: customWidgetClass.mediumText(
                        text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget stepNine() {
    double BMI = 0.0;
    if (selectedHeightUnit == 0 || selectedWeightUnit == 0) {
      double kilogram = currentWeight[selectedWeightUnit] ~/
              weightList[selectedWeightUnit]['gap'] +
          weightList[selectedWeightUnit]['min'] +
          (currentWeight[selectedWeightUnit] %
                  weightList[selectedWeightUnit]['gap']) /
              weightList[selectedWeightUnit]['gap'];
      dynamic centimetre = currentHeight[selectedHeightUnit] +
          heightList[selectedHeightUnit]['min'];
      BMI = 10000 * kilogram / (centimetre * centimetre);
    }
    if (selectedHeightUnit == 1 || selectedWeightUnit == 1) {
      double pound = currentWeight[selectedWeightUnit] ~/
              weightList[selectedWeightUnit]['gap'] +
          weightList[selectedWeightUnit]['min'] +
          (currentWeight[selectedWeightUnit] %
                  weightList[selectedWeightUnit]['gap']) /
              weightList[selectedWeightUnit]['gap'];
      dynamic inch = (currentHeight[selectedHeightUnit] ~/
                      heightList[selectedHeightUnit]['gap'] +
                  heightList[selectedHeightUnit]['min']) *
              heightList[selectedHeightUnit]['gap'] +
          currentHeight[selectedHeightUnit] %
              heightList[selectedHeightUnit]['gap'];
      BMI = 703 * pound / (inch * inch);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Center(
          child: customTextWidget.mediumText(
              text: 'What\'s your current\nWeight?',
              color: WHITE,
              size: ipad ? 50 : 30,
              alignment: TextAlign.center),
        ),
        Center(
          child: Container(
            width: 180,
            margin: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: GRAY, borderRadius: BorderRadius.circular(100)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: weightList.asMap().entries.map((entry) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        selectedWeightUnit = entry.key;
                        selectedHeightUnit = entry.key;
                      });
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        width: 90,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            color: (selectedWeightUnit == entry.key
                                ? PRIMARY
                                : null)),
                        child: Center(
                            child: customTextWidget.boldText(
                                text: entry.value['unit'],
                                color: selectedWeightUnit == entry.key
                                    ? BLACK
                                    : LIGHT_GREY_TEXT,
                                size: 20))));
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              CarouselSlider.builder(
                itemCount: 1,
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  height: double.maxFinite,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  scrollPhysics: BouncingScrollPhysics(),
                  initialPage: 1,
                  pageSnapping: false,
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Center(
                  child: Container(
                      child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 4,
                          height: 150,
                          decoration: BoxDecoration(
                            color: WHITE,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: WIDTH! * 0.35,
                          child: Center(
                              child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: (currentWeight[selectedWeightUnit] ~/
                                              weightList[selectedWeightUnit]
                                                  ['gap'] +
                                          weightList[selectedWeightUnit]['min'])
                                      .toString(),
                                  style: TextStyle(
                                    color: WHITE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(
                                    color: WHITE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                TextSpan(
                                  text: (currentWeight[selectedWeightUnit] %
                                          weightList[selectedWeightUnit]['gap'])
                                      .toString(),
                                  style: TextStyle(
                                    color: WHITE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                                TextSpan(
                                  text: weightList[selectedWeightUnit]['unit'],
                                  style: TextStyle(
                                    color: WHITE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                )
                              ],
                            ),
                          )))
                    ],
                  )),
                ),
              ),
              CarouselSlider.builder(
                itemCount: (weightList[selectedWeightUnit]['max'] -
                        weightList[selectedWeightUnit]['min']) *
                    weightList[selectedWeightUnit]['gap'],
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: false,
                    height: double.maxFinite,
                    viewportFraction: 0.05,
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    initialPage: currentWeight[selectedWeightUnit],
                    pageSnapping: false,
                    onScrolled: (val) {
                      setState(() {
                        currentWeight[selectedWeightUnit] =
                            val!.toInt().floor();
                      });
                    }),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Center(
                  child: Container(
                    width: double.maxFinite,
                    height: WIDTH! * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Stack(children: [
                      Center(
                        child: Opacity(
                            opacity: indexToOpacity9(itemIndex),
                            child: Container(
                              width: 4,
                              height: itemIndex %
                                          weightList[selectedWeightUnit]
                                              ['gap'] ==
                                      0
                                  ? 90
                                  : 60,
                              decoration: BoxDecoration(
                                color: itemIndex ==
                                        currentWeight[selectedWeightUnit]
                                    ? WHITE
                                    : PRIMARY,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            )),
                      ),
                      if (itemIndex % weightList[selectedWeightUnit]['gap'] ==
                          0)
                        Positioned(
                            top: 0,
                            child: customTextWidget.mediumText(
                              text: (itemIndex ~/
                                          weightList[selectedWeightUnit]
                                              ['gap'] +
                                      weightList[selectedWeightUnit]['min'])
                                  .toString(),
                              color: WHITE,
                              size:
                                  itemIndex == currentWeight[selectedWeightUnit]
                                      ? 0
                                      : 18,
                            ))
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: GRAY, borderRadius: BorderRadius.circular(10)),
            child: Stack(children: [
              Center(
                child: Column(children: [
                  customTextWidget.boldText(
                      text: 'Current BMI Estimate', color: WHITE, size: 26),
                  customTextWidget.mediumText(
                      text: BMI.toStringAsFixed(1), color: PRIMARY, size: 40),
                ]),
              ),
              Positioned(
                  top: 0, right: 0, child: Image.asset('assets/setup/info.png'))
            ])),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                if (currentStep < 21) {
                  if (validateFields()) {
                    changeHeader(true);
                  }
                } else {
                  registerUser();
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: PRIMARY,
                ),
                child: Center(
                  child: customWidgetClass.mediumText(
                      text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                ),
              ),
            ))
      ],
    );
  }

  Widget stepTen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Center(
          child: customTextWidget.mediumText(
              text: 'What\'s your Smash\nTarget Weight?',
              color: WHITE,
              size: ipad ? 50 : 30,
              alignment: TextAlign.center),
        ),
        Expanded(
          child: Stack(
            children: [
              CarouselSlider.builder(
                itemCount: 1,
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  height: double.maxFinite,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  scrollPhysics: BouncingScrollPhysics(),
                  initialPage: 1,
                  pageSnapping: false,
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Center(
                  child: Container(
                      child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 4,
                          height: 150,
                          decoration: BoxDecoration(
                            color: WHITE,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: WIDTH! * 0.35,
                          child: Center(
                              child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      (targetWeight[0] ~/ weightList[0]['gap'] +
                                              weightList[0]['min'])
                                          .toString(),
                                  style: TextStyle(
                                    color: WHITE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(
                                    color: WHITE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                TextSpan(
                                  text: (targetWeight[0] % weightList[0]['gap'])
                                      .toString(),
                                  style: TextStyle(
                                    color: WHITE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                                TextSpan(
                                  text: weightList[0]['unit'],
                                  style: TextStyle(
                                    color: WHITE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                )
                              ],
                            ),
                          )))
                    ],
                  )),
                ),
              ),
              CarouselSlider.builder(
                itemCount: (weightList[0]['max'] - weightList[0]['min']) *
                    weightList[0]['gap'],
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: false,
                    height: double.maxFinite,
                    viewportFraction: 0.05,
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    initialPage: targetWeight[0],
                    pageSnapping: false,
                    onScrolled: (val) {
                      setState(() {
                        targetWeight[0] = val!.toInt().floor();
                      });
                    }),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Center(
                  child: Container(
                    width: double.maxFinite,
                    height: WIDTH! * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Stack(children: [
                      Center(
                        child: Opacity(
                            opacity: indexToOpacity10(itemIndex),
                            child: Container(
                              width: 4,
                              height: itemIndex % weightList[0]['gap'] == 0
                                  ? 90
                                  : 60,
                              decoration: BoxDecoration(
                                color: itemIndex == targetWeight[0]
                                    ? WHITE
                                    : PRIMARY,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            )),
                      ),
                      if (itemIndex % weightList[0]['gap'] == 0)
                        Positioned(
                            top: 0,
                            child: customTextWidget.mediumText(
                              text: (itemIndex ~/ weightList[0]['gap'] +
                                      weightList[0]['min'])
                                  .toString(),
                              color: WHITE,
                              size: itemIndex == targetWeight[0] ? 0 : 18,
                            ))
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: GRAY, borderRadius: BorderRadius.circular(10)),
            child: Stack(children: [
              Column(children: [
                customTextWidget.mediumText(
                    text: '👌Reasonable Target', color: WHITE, size: 20),
                SizedBox(height: 5),
                customTextWidget.mediumText(
                    text:
                        'You will lose 6.5% of body weight\nModerate weight loss can also make big difference:\n-Lower blood pressure\n-Reduce the risk of type 2 diabetes',
                    color: WHITE,
                    size: 16),
              ]),
            ])),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                if (currentStep < 21) {
                  if (validateFields()) {
                    changeHeader(true);
                  }
                } else {
                  registerUser();
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: PRIMARY,
                ),
                child: Center(
                  child: customWidgetClass.mediumText(
                      text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                ),
              ),
            ))
      ],
    );
  }

  Widget stepEleven() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'When was the last time\nyou had your ideal body?',
                  color: WHITE,
                  size: ipad ? 50 : 30,
                  alignment: TextAlign.center),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  lastTimeList.length,
                  (index) => optionTypeCard(
                      lastTimeList[index], '', index, currentStep)),
            )
          ],
        ),
      ),
    );
  }

  Widget stepTwelve() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'How workouts per week\ncan you commit to?',
                  color: WHITE,
                  size: ipad ? 50 : 30,
                  alignment: TextAlign.center),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: Image.asset('assets/setup/note.png'))),
            Center(
              child: customTextWidget.boldText(
                  text: '${selectedCommitPerWeek + 1} times/week',
                  color: PRIMARY,
                  size: ipad ? 35 : 25),
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'I enjoy workout as a part of\nmy lifestyle',
                  color: WHITE,
                  size: ipad ? 35 : 20,
                  alignment: TextAlign.center),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                width: double.infinity,
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Stack(children: [
                  Row(
                    children: List.generate(
                        3,
                        (index) => Expanded(
                            child: Container(
                                width: (WIDTH! - 36 * 2) / 3,
                                height: 1,
                                margin: EdgeInsets.only(top: 15),
                                color: selectedCommitPerWeek <= index
                                    ? null
                                    : PRIMARY,
                                child: selectedCommitPerWeek <= index
                                    ? DottedLine(color: PRIMARY)
                                    : null))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        4,
                        (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedCommitPerWeek = index;
                              });
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: (selectedCommitPerWeek == index)
                                ? Container(
                                    width: 30,
                                    height: 30,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: BLACK,
                                        border: Border.all(
                                            width: 1, color: PRIMARY),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: PRIMARY,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  )
                                : selectedCommitPerWeek < index
                                    ? Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                            color: BLACK,
                                            border: Border.all(
                                                width: 1, color: PRIMARY),
                                            borderRadius:
                                                BorderRadius.circular(100)))
                                    : Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                            color: PRIMARY,
                                            borderRadius:
                                                BorderRadius.circular(100))))),
                  )
                ])),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              customTextWidget.boldText(
                  text: 'Less',
                  color: WHITE,
                  size: ipad ? 35 : 20,
                  alignment: TextAlign.center),
              customTextWidget.boldText(
                  text: 'More',
                  color: WHITE,
                  size: ipad ? 35 : 20,
                  alignment: TextAlign.center),
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (currentStep < 21) {
                      if (validateFields()) {
                        changeHeader(true);
                      }
                    } else {
                      registerUser();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PRIMARY,
                    ),
                    child: Center(
                      child: customWidgetClass.mediumText(
                          text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget stepThirteen() {
    const List<String> list = <String>['PUSH-UPS'];
    String dropdownValue = list.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          Image.asset('assets/setup/capability.jpg'),
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: customTextWidget.mediumText(
                    text: 'Define your current\nfitness capabilities',
                    color: WHITE,
                    size: ipad ? 50 : 30,
                    alignment: TextAlign.center),
              ))
        ]),
        SizedBox(
          height: 16,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: customTextWidget.boldText(
                text: 'Benchmark', color: WHITE, size: 20)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: PRIMARY, width: 1),
              color: GRAY,
              borderRadius: BorderRadius.circular(5)),
          child: DropdownButton<String>(
            isExpanded: true,
            dropdownColor: BLACK,
            value: dropdownValue,
            icon: Image.asset('assets/setup/dropdownIcon.png'),
            underline: Container(
              height: 0,
              color: null,
            ),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: customTextWidget.mediumText(text: value, color: WHITE),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 25),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: customTextWidget.boldText(
                text: 'In 1 minute, I can do', color: WHITE, size: 20)),
        Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 16),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: PRIMARY, width: 1),
                color: GRAY,
                borderRadius: BorderRadius.circular(15)),
            child: TextFormField(
              controller: repsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 16),
                border: InputBorder.none,
                suffixIcon: Image.asset(
                  'assets/setup/edit.png',
                  height: 10,
                ),
              ),
              style:
                  TextStyle(color: PRIMARY, fontFamily: 'Bold', fontSize: 20),
            )),
        Spacer(),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                if (currentStep < 21) {
                  if (validateFields()) {
                    changeHeader(true);
                  }
                } else {
                  registerUser();
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: PRIMARY,
                ),
                child: Center(
                  child: customWidgetClass.mediumText(
                      text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                ),
              ),
            )),
        Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
                child: InkWell(
                    onTap: () {
                      if (currentStep < 21) {
                        if (validateFields()) {
                          changeHeader(true);
                        }
                      } else {
                        registerUser();
                      }
                    },
                    child: customWidgetClass.mediumText(
                        text: 'I don\'t know', color: WHITE, size: 18))))
      ],
    );
  }

  Widget stepFourteen() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child:
                  Center(child: Image.asset('assets/setup/fitnessLevel.png'))),
          SizedBox(height: 30),
          Center(
            child: customTextWidget.mediumText(
                text: 'Smash will help you achieve your fitness potential',
                color: WHITE,
                size: ipad ? 50 : 30,
                alignment: TextAlign.center),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '92%',
                  style: TextStyle(
                    color: PRIMARY,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                TextSpan(
                  text:
                      ' of users reported that their\nfitness level has improved\nsignificantly after using our fitness\nplan.',
                  style: TextStyle(color: WHITE, fontSize: 20, height: 1.3),
                ),
              ],
            ),
          )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (currentStep < 21) {
                    if (validateFields()) {
                      changeHeader(true);
                    }
                  } else {
                    registerUser();
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PRIMARY,
                  ),
                  child: Center(
                    child: customWidgetClass.mediumText(
                        text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget stepFifteen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'What are your current activity patterns?',
                  color: WHITE,
                  size: ipad ? 50 : 30,
                  alignment: TextAlign.center),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                    child: Image.asset('assets/setup/activityPattern.png'))),
            SizedBox(height: 30),
            Center(
              child: customTextWidget.mediumText(
                  text: 'I occasionally exercise or walk for\n30 minutes',
                  color: WHITE,
                  size: ipad ? 35 : 20,
                  alignment: TextAlign.center),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                width: double.infinity,
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Stack(children: [
                  Row(
                    children: List.generate(
                        3,
                        (index) => Expanded(
                            child: Container(
                                width: (WIDTH! - 36 * 2) / 3,
                                height: 1,
                                margin: EdgeInsets.only(top: 15),
                                color: selectedActivityPattern <= index
                                    ? null
                                    : PRIMARY,
                                child: selectedActivityPattern <= index
                                    ? DottedLine(color: PRIMARY)
                                    : null))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        4,
                        (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedActivityPattern = index;
                              });
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: (selectedActivityPattern == index)
                                ? Container(
                                    width: 30,
                                    height: 30,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: BLACK,
                                        border: Border.all(
                                            width: 1, color: PRIMARY),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: PRIMARY,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  )
                                : selectedActivityPattern < index
                                    ? Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                            color: BLACK,
                                            border: Border.all(
                                                width: 1, color: PRIMARY),
                                            borderRadius:
                                                BorderRadius.circular(100)))
                                    : Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                            color: PRIMARY,
                                            borderRadius:
                                                BorderRadius.circular(100))))),
                  )
                ])),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              customTextWidget.boldText(
                  text: 'Sedentary',
                  color: WHITE,
                  size: ipad ? 35 : 20,
                  alignment: TextAlign.center),
              customTextWidget.boldText(
                  text: 'Very active',
                  color: WHITE,
                  size: ipad ? 35 : 20,
                  alignment: TextAlign.center),
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (currentStep < 21) {
                      if (validateFields()) {
                        changeHeader(true);
                      }
                    } else {
                      registerUser();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PRIMARY,
                    ),
                    child: Center(
                      child: customWidgetClass.mediumText(
                          text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget stepSixteen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: customTextWidget.mediumText(
                  text: 'If you put in the work, we project You’ll reach',
                  color: WHITE,
                  size: ipad ? 35 : 22,
                  alignment: TextAlign.center),
            ),
          ),
          Center(
              child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '155.0 lb by ',
                  style: TextStyle(
                    color: WHITE,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                TextSpan(
                  text: 'Apr 5!',
                  style: TextStyle(
                    color: PRIMARY,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                )
              ],
            ),
          )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Stack(children: [
                SizedBox(
                    width: double.infinity,
                    child: Image.asset('assets/setup/earlier.png')),
                Positioned(
                    bottom: 60,
                    right: 120,
                    child: Stack(children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: WHITE,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: customTextWidget.mediumText(
                              text: 'MAR 22',
                              color: BLACK,
                              size: 15,
                              alignment: TextAlign.center))
                    ])),
                Positioned(
                    bottom: 60,
                    right: 50,
                    child: customTextWidget.mediumText(
                        text: 'MAR 22',
                        color: WHITE,
                        size: 15,
                        alignment: TextAlign.center))
              ])),
          SizedBox(height: 30),
          Center(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Get there ',
                      style: TextStyle(
                        color: WHITE,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(
                      text: '14',
                      style: TextStyle(
                        color: PRIMARY,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(
                      text: ' days earlier',
                      style: TextStyle(
                        color: WHITE,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    )
                  ]),
                )),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: customTextWidget.mediumText(
                  text:
                      'With the personalized plan, you have great potential to achieve your goals ahead of schedule!',
                  color: WHITE,
                  size: ipad ? 30 : 18,
                  alignment: TextAlign.center),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (currentStep < 21) {
                    if (validateFields()) {
                      changeHeader(true);
                    }
                  } else {
                    registerUser();
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PRIMARY,
                  ),
                  child: Center(
                    child: customWidgetClass.mediumText(
                        text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget stepSeventeen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'Choose your preferred workout level',
                  color: WHITE,
                  size: ipad ? 50 : 30,
                  alignment: TextAlign.center),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  levelList.length,
                  (index) =>
                      optionTypeCard(levelList[index], '', index, currentStep)),
            )
          ],
        ),
      ),
    );
  }

  Widget stepEighteen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'Where will your primarily be working out?',
                  color: WHITE,
                  size: ipad ? 50 : 30,
                  alignment: TextAlign.center),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  placeList.length,
                  (index) =>
                      optionTypeCard(placeList[index], '', index, currentStep)),
            )
          ],
        ),
      ),
    );
  }

  Widget stepNineteen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'Do you have gym equipment?',
                  color: WHITE,
                  size: ipad ? 50 : 30,
                  alignment: TextAlign.center),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  gymList.length,
                  (index) => imageTypeCard(
                      gymList[index].title,
                      gymList[index].subTitle,
                      gymList[index].image,
                      index,
                      currentStep)),
            )
          ],
        ),
      ),
    );
  }

  Widget stepTwenty() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'What duration of workouts do you prefer?',
                  color: WHITE,
                  size: ipad ? 50 : 30,
                  alignment: TextAlign.center),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  durationList.length,
                  (index) => optionTypeCard(
                      durationList[index], '', index, currentStep)),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (currentStep < 21) {
                      if (validateFields()) {
                        changeHeader(true);
                      }
                    } else {
                      registerUser();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PRIMARY,
                    ),
                    child: Center(
                      child: customWidgetClass.mediumText(
                          text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget stepTwentyOne() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: customTextWidget.mediumText(
                  text: 'How will you feel after reaching the goals?',
                  color: WHITE,
                  size: ipad ? 50 : 30,
                  alignment: TextAlign.center),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  feelList.length,
                  (index) => tileCard(
                      feelList[index].title, '', feelList[index].image, index)),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (currentStep < 21) {
                      if (validateFields()) {
                        changeHeader(true);
                      }
                    } else {
                      registerUser();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PRIMARY,
                    ),
                    child: Center(
                      child: customWidgetClass.mediumText(
                          text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget stepTwentyTwo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: customTextWidget.mediumText(
                      text:
                          'Join the Smash Revolution and create your own success story',
                      color: WHITE,
                      size: ipad ? 50 : 25,
                      alignment: TextAlign.center))),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView(
              children: [
                CarouselSlider.builder(
                  itemCount: feedbackList.length,
                  options: CarouselOptions(
                    viewportFraction: 0.7,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    height: 340.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedFeedback = index;
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
                              opacity:
                                  pageViewIndex == selectedFeedback ? 1 : 0.3,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        child: Container(
                                            width: double.infinity,
                                            height: 170,
                                            child: Image.asset(
                                              feedbackList[itemIndex].image,
                                              fit: BoxFit.cover,
                                            ))),
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
                                          text: feedbackList[itemIndex].title,
                                          color: WHITE,
                                          size: 18),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: customTextWidget.mediumText(
                                          text:
                                              feedbackList[itemIndex].subTitle,
                                          color: LIGHT_GREY_TEXT,
                                          size: 18),
                                    ),
                                  ]))),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: feedbackList.asMap().entries.map((entry) {
                      return Container(
                          width: 15,
                          height: 15,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              color: (selectedFeedback == entry.key
                                  ? PRIMARY
                                  : GRAY)));
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (currentStep < 21) {
                    if (validateFields()) {
                      changeHeader(true);
                    }
                  } else {
                    showDialog<String>(
                            context: context,
                            builder: (context) => loginOrGuestDialog())
                        .then((value) {
                      if (value != null) registerUser();
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PRIMARY,
                  ),
                  child: Center(
                    child: customWidgetClass.mediumText(
                        text: 'Next', color: BLACK, size: ipad ? 35 : 25),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }
    return null;
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email";
    }
    if (!(value.isNotEmpty && value.contains("@") && value.contains("."))) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

  String? _validateUsername(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  Widget loginDialog() {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        elevation: 0.0,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              decoration: BoxDecoration(
                  color: GRAY,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0))),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  customWidgetClass.boldText(
                      text: 'Log In', color: WHITE, size: 25),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: PRIMARY),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email address',
                          hintStyle:
                              TextStyle(color: LIGHT_GREY_TEXT, fontSize: 20),
                        ),
                        style: TextStyle(
                            color: WHITE, fontFamily: 'Bold', fontSize: 20),
                      )),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: PRIMARY),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: _passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Passwords',
                          hintStyle:
                              TextStyle(color: LIGHT_GREY_TEXT, fontSize: 20),
                        ),
                        style: TextStyle(
                            color: WHITE, fontFamily: 'Bold', fontSize: 20),
                      )),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PRIMARY,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: PRIMARY, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            child: Column(children: [
                              customTextWidget.boldText(
                                  text: 'Log In', size: 20, color: BLACK)
                            ]),
                            onPressed: () {
                              if (_validateEmail(_emailController.text) !=
                                  null) {
                                showCustomDialog(
                                    context: context,
                                    title: ERROR,
                                    msg: _validateEmail(_emailController.text),
                                    btnYesText: OK,
                                    onPressedBtnYes: () {
                                      Navigator.pop(context);
                                    });
                                return;
                              }
                              if (_validatePassword(_passController.text) !=
                                  null) {
                                showCustomDialog(
                                    context: context,
                                    title: ERROR,
                                    msg:
                                        _validatePassword(_passController.text),
                                    btnYesText: OK,
                                    onPressedBtnYes: () {
                                      Navigator.pop(context);
                                    });
                                return;
                              }
                              Navigator.pop(context, 'login');
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account yet? ",
                            style: TextStyle(color: WHITE, fontSize: 15)),
                        const TextSpan(text: ' '),
                        TextSpan(
                            text: "Register",
                            style: TextStyle(color: PRIMARY, fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                                showDialog<String>(
                                        context: context,
                                        builder: (context) => signupDialog())
                                    .then((value) {
                                  if (value != null) {
                                    guest = false;
                                    registerUser();
                                  }
                                });
                              }),
                      ]),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ));
  }

  Widget signupDialog() {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        elevation: 0.0,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              decoration: BoxDecoration(
                  color: GRAY,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0))),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  customWidgetClass.boldText(
                      text: 'Sign Up', color: WHITE, size: 25),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: PRIMARY),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'User Name',
                          hintStyle:
                              TextStyle(color: LIGHT_GREY_TEXT, fontSize: 20),
                        ),
                        style: TextStyle(
                            color: WHITE, fontFamily: 'Bold', fontSize: 20),
                      )),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: PRIMARY),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email address',
                          hintStyle:
                              TextStyle(color: LIGHT_GREY_TEXT, fontSize: 20),
                        ),
                        style: TextStyle(
                            color: WHITE, fontFamily: 'Bold', fontSize: 20),
                      )),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: PRIMARY),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: _passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Passwords',
                          hintStyle:
                              TextStyle(color: LIGHT_GREY_TEXT, fontSize: 20),
                        ),
                        style: TextStyle(
                            color: WHITE, fontFamily: 'Bold', fontSize: 20),
                      )),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PRIMARY,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: PRIMARY, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            child: Column(children: [
                              customTextWidget.boldText(
                                  text: 'Sign Up', size: 20, color: BLACK)
                            ]),
                            onPressed: () {
                              if (_validateUsername(_usernameController.text) !=
                                  null) {
                                showCustomDialog(
                                    context: context,
                                    title: ERROR,
                                    msg: _validateUsername(
                                        _usernameController.text),
                                    btnYesText: OK,
                                    onPressedBtnYes: () {
                                      Navigator.pop(context);
                                    });
                                return;
                              }
                              if (_validateEmail(_emailController.text) !=
                                  null) {
                                showCustomDialog(
                                    context: context,
                                    title: ERROR,
                                    msg: _validateEmail(_emailController.text),
                                    btnYesText: OK,
                                    onPressedBtnYes: () {
                                      Navigator.pop(context);
                                    });
                                return;
                              }
                              if (_validatePassword(_passController.text) !=
                                  null) {
                                showCustomDialog(
                                    context: context,
                                    title: ERROR,
                                    msg:
                                        _validatePassword(_passController.text),
                                    btnYesText: OK,
                                    onPressedBtnYes: () {
                                      Navigator.pop(context);
                                    });
                                return;
                              }
                              Navigator.pop(context, 'signup');
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: WHITE, fontSize: 15)),
                        const TextSpan(text: ' '),
                        TextSpan(
                            text: "Login",
                            style: TextStyle(color: PRIMARY, fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                                showDialog<String>(
                                        context: context,
                                        builder: (context) => loginDialog())
                                    .then((value) {
                                  if (value != null) loginUser();
                                });
                              }),
                      ]),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ));
  }

  Widget loginOrGuestDialog() {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        elevation: 0.0,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              decoration: BoxDecoration(
                  color: GRAY,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0))),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
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
                                  text: 'Log In', size: 20, color: WHITE)
                            ]),
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog<String>(
                                      context: context,
                                      builder: (context) => loginDialog())
                                  .then((value) {
                                if (value != null) loginUser();
                              });
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
                              backgroundColor: PRIMARY,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: PRIMARY, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            child: Column(children: [
                              customTextWidget.boldText(
                                  text: 'Login as a Guest',
                                  size: 20,
                                  color: BLACK)
                            ]),
                            onPressed: () {
                              Navigator.pop(context, 'guest');
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ));
  }

  tileCard(String title, String subTitle, String image, int index) => InkWell(
        onTap: () {
          setState(() {
            selectedFeelResult = index;
          });
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 22, horizontal: 18),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: GRAY,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: selectedFeelResult == index ? PRIMARY : WHITE,
                      borderRadius: BorderRadius.circular(100)),
                  child: Image.asset(image)),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customTextWidget.mediumText(
                        text: title,
                        color: selectedFeelResult == index ? PRIMARY : WHITE,
                        size: 22),
                    if (subTitle.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: customTextWidget.mediumText(
                            text: subTitle,
                            color: selectedFeelResult == index
                                ? PRIMARY
                                : LIGHT_GREY_TEXT,
                            size: 12),
                      )
                  ],
                ),
              ),
              Spacer(),
              Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: selectedFeelResult == index
                          ? PRIMARY
                          : Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(100)))
            ])),
      );

  bottomButtons() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (currentStep < 21) {
                if (validateFields()) {
                  changeHeader(true);
                }
              } else {
                registerUser();
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ORANGE,
              ),
              child: Center(
                child: customTextWidget.mediumText(
                    text: NEXT_STEP, color: WHITE, size: ipad ? 35 : 18),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (currentStep > 0) {
                setState(() {
                  currentStep--;
                });
              } else {}
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: BLUE, width: 2)),
              child: Center(
                child: customTextWidget.boldText(
                    text: PREVIOUS_STEP, color: BLUE, size: ipad ? 35 : 18),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      );

  bool validateFields() {
    if (currentStep == 0) {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      return true;
    } else if (currentStep == 1) {
      return true;
      // return _formKey.currentState!.validate();
    } else if (selectedGender != null) {
      return true;
    } else if (selectedIntenseLevel != null) {
      return true;
    } else {
      return true;
    }
  }

  loginUser() async {
    customDialogues.progressDialog(context: context, title: "Processing...");
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive +
            "/api/user_login?email=${_emailController.text}&password=${_passController.text}"))
        .catchError((e) {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: e.toString(),
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    });
    Navigator.pop(context);
    final _jsonResponse = jsonDecode(_response.body);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      customDialogues.progressDialog(
          context: context, title: ANALYZING_ANSWER[LANGUAGE_TYPE]);
      Map<String, dynamic> info = _jsonResponse['data'];
      userModal = UserModal.fromJson(_jsonResponse);
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setBool("isUserRegistered", true);
      sp.setBool("isMember", true);
      sp.setInt("memberID", info['id']);
      sp.setString("goal", goalList[selectedSmashGoal].title);
      sp.setString("duration", durationList[selectedDuration]);
      sp.setString("level", levelList[selectedLevel]);
      sp.setInt("commitperweek", selectedCommitPerWeek + 1);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Loading()));
      });
    } else if (_response.statusCode == 200 && _jsonResponse['success'] == "0") {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: _jsonResponse['message'],
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    } else {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: FAILED_TO_LOAD_DATA,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    }
  }

  registerUser() async {
    customDialogues.progressDialog(
        context: context, title: SAVING_INFO[LANGUAGE_TYPE]);
    if (guest) {
      Navigator.pop(context);
      customDialogues.progressDialog(
          context: context, title: ANALYZING_ANSWER[LANGUAGE_TYPE]);
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setBool("isUserRegistered", true);
      sp.setBool("isMember", false);
      sp.setInt("memberID", 0);
      sp.setString("goal", goalList[selectedSmashGoal].title);
      sp.setString("duration", durationList[selectedDuration]);
      sp.setString("level", levelList[selectedLevel]);
      sp.setInt("commitperweek", selectedCommitPerWeek + 1);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Loading()));
      });
    } else {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$SERVER_ADDRESSLive/api/user_register'));
      // print('name------------${nameController.text}');
      // print('phone------------${phoneController.text}');
      // print('gender------------${typeToGender(selectedGender)}');
      // print(
      //     'workout_intensity------------${typeToIntensity(selectedIntenseLevel)}');
      // print('age------------${currentAge.toString()}');
      // print(
      //     'height------------${currentBirth.toString() + " " + CENTIMETERS[LANGUAGE_TYPE]}');
      // print('exercise days------------${typeToDays(selectedTimesInWeek)}');

      final random = Random();
      final randomNumber = random.nextInt(9000000) + 1000000;

      request.fields.addAll({
        'name': _usernameController.text,
        'phone': randomNumber.toString(),
        'email': _emailController.text,
        'password': _passController.text,
        'gender': selectedGender == 0 ? "Male" : "Female",
        'workout_intensity': typeToIntensity(selectedIntenseLevel),
        'age': '16',
        'height':
            currentHeight[0].toString() + " " + CENTIMETERS[LANGUAGE_TYPE],
        'exercise_days': ALL_SEVEN_DAYS[LANGUAGE_TYPE],
        'token': "abc",
        'type': 'android',
      });

      http.StreamedResponse response = await request.send();
      Navigator.pop(context);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(await response.stream.bytesToString());
        if (jsonResponse['success'] == '0') {
          showCustomDialog(
              context: context,
              title: ERROR,
              msg: jsonResponse['message'],
              btnYesText: OK,
              onPressedBtnYes: () {
                Navigator.pop(context);
              });
        } else {
          customDialogues.progressDialog(
              context: context, title: ANALYZING_ANSWER[LANGUAGE_TYPE]);
          print('response ---------$jsonResponse');
          Map<String, dynamic> info = jsonResponse['data'];
          userModal = UserModal.fromJson(jsonResponse);
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setBool("isUserRegistered", true);
          sp.setBool("isMember", true);
          sp.setInt("memberID", info['id']);
          sp.setString("goal", goalList[selectedSmashGoal].title);
          sp.setString("duration", durationList[selectedDuration]);
          sp.setString("level", levelList[selectedLevel]);
          sp.setInt("commitperweek", selectedCommitPerWeek + 1);
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Loading()));
          });
        }
      } else {
        showCustomDialog(
            context: context,
            title: ERROR,
            msg: "Something is wrong. Please try it again later.",
            btnYesText: OK,
            onPressedBtnYes: () {
              Navigator.pop(context);
            });
        print('msg error------${response.reasonPhrase}');
      }
    }
  }

  // String typeToGender(int selectedGender){
  //   if(selectedGender == 0){
  //     return "Male";
  //   }else if(selectedGender == 1){
  //     return "Female";
  //   }
  // }

  String typeToIntensity(int x) {
    if (x == 0) {
      return LOW[LANGUAGE_TYPE];
    } else if (x == 1) {
      return MODERATE[LANGUAGE_TYPE];
    } else {
      return HIGH[LANGUAGE_TYPE];
    }
  }

  String typeToDays(int x) {
    if (x == 0) {
      return TWO_THREE_TIMES_IN_WEEK[LANGUAGE_TYPE];
    } else if (x == 1) {
      return FIVE_DAYS_IN_WEEK[LANGUAGE_TYPE];
    } else {
      return ALL_SEVEN_DAYS[LANGUAGE_TYPE];
    }
  }
}

class IntenseCardModel {
  String title;
  String subTitle;

  IntenseCardModel(this.title, this.subTitle);
}

class GenderCardModel {
  String image;
  String text;

  GenderCardModel(this.image, this.text);
}

class ImageCardModel {
  String title;
  String subTitle;
  String image;

  ImageCardModel(this.title, this.subTitle, this.image);
}

class DottedLine extends StatelessWidget {
  const DottedLine({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 2.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

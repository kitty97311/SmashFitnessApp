import 'dart:io';
import 'dart:ui';

import 'package:exercise_app/Screens/FavoriteList.dart';
import 'package:exercise_app/Screens/GeneralSetting.dart';
import 'package:exercise_app/Screens/Language.dart';
import 'package:exercise_app/Screens/Login.dart';
import 'package:exercise_app/Screens/Profile.dart';
import 'package:exercise_app/Screens/Signup.dart';
import 'package:exercise_app/Screens/Subscribe.dart';
import 'package:exercise_app/Screens/WorkoutSetting.dart';
import 'package:exercise_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../AllText.dart';
import '../Themes.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _value = 1;
  bool isReminderOn = false;
  bool isHalfwayOn = false;
  bool isVoiceGuidanceOn = false;
  SharedPreferences? sharedPreferences;
  TextEditingController timeController = TextEditingController();
  DateTime now = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  var abc;
  final player = AudioPlayer();
  //AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadSettings();
    //timeController.text=TimeOfDay.now().period.toString();
  }

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 2,
    googlePlayIdentifier: 'com.template.workoutchallenge',
    appStoreIdentifier: '1661741363',
  );
  rating() {
    rateMyApp.showStarRateDialog(
      context,
      title: 'Rate this app',
      // The dialog title.
      message:
          "You like this app ? Then take a little bit of your time to leave a rating :",
      actionsBuilder: (context, stars) {
        return [
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(fontFamily: "Myfontlight", color: Colors.black),
            ),
            onPressed: () async {
              print('Thanks for the ' +
                  (stars == null ? '0' : stars.round().toString()) +
                  ' star(s) !');

              await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
              Navigator.pop<RateMyAppDialogButton>(
                  context, RateMyAppDialogButton.rate);
            },
          ),
        ];
      },
      ignoreNativeDialog: Platform.isAndroid,
      dialogStyle: const DialogStyle(
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions: const StarRatingOptions(),
      onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
          .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
    );
  }

  loadSettings() async {
    initSharedPreferences();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        isReminderOn = value.getBool("isReminderOn") ?? false;
        isVoiceGuidanceOn = value.getBool("isVoiceGuidanceOn") ?? true;
        isHalfwayOn = value.getBool("isHalfwayPromptOn") ?? true;
        timeController.text =
            value.getString("reminderTime") ?? "Set a reminder";
        _value = value.getDouble("volume") ?? 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: BLACK,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                      child: Stack(children: [
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
                  ]))),
              Center(
                  child: customTextWidget.mediumText(
                      text: 'Sign in and synchronize your data',
                      size: 15,
                      color: WHITE,
                      alignment: TextAlign.center)),
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: PRIMARY),
                        borderRadius: BorderRadius.circular(10),
                        color: BLACK,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/profile/cloud_upload.png'),
                            SizedBox(width: 10),
                            customTextWidget.boldText(
                                text: 'Backup & Restore',
                                color: PRIMARY,
                                size: 20),
                          ]),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Subscribe()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: MAINPADDING),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: PRIMARY),
                        borderRadius: BorderRadius.circular(10),
                        color: PRIMARY,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: BLACK),
                              child: customTextWidget.mediumText(
                                  text: '\$', color: PRIMARY, size: 15),
                            ),
                            SizedBox(width: 10),
                            customTextWidget.boldText(
                                text: 'Go Premium', color: BLACK, size: 20),
                          ]),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  print(sp.getBool("isMember"));
                  print(sp.getInt("memberID"));
                  if (sp.getBool("isMember") ?? false) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login(type: 0)));
                  }
                },
                child: lt.iconTile(
                  icon: "assets/profile/emoji.png",
                  title: 'Edit Profile',
                  widget: Image.asset(
                    "assets/setting/right_arrow.png",
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavoriteList()));
                },
                child: lt.iconTile(
                  icon: "assets/profile/heart.png",
                  title: 'Favorite Workouts',
                  widget: Image.asset(
                    "assets/setting/right_arrow.png",
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              customTextWidget.boldText(text: SETTING, size: 20, color: WHITE),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkoutSetting()));
                },
                child: lt.iconTile(
                  icon: "assets/profile/drop.png",
                  title: 'Workout settings',
                  widget: Image.asset(
                    "assets/setting/right_arrow.png",
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GeneralSetting()));
                },
                child: lt.iconTile(
                  icon: "assets/profile/settings.png",
                  title: 'General Settings',
                  widget: Image.asset(
                    "assets/setting/right_arrow.png",
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Language()));
                },
                child: lt.iconTile(
                  icon: "assets/profile/website.png",
                  title: 'Language Options',
                  widget: Image.asset(
                    "assets/setting/right_arrow.png",
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    ));
  }

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  resetSettings() {
    print("called");
    setState(() {
      isReminderOn = false;
      isVoiceGuidanceOn = false;
      isHalfwayOn = false;
    });
    sharedPreferences!.setBool("isReminderOn", false);
    notificationHelper.cancelNotification(1);
    notificationHelper.cancelNotification(2);
    sharedPreferences!.setBool("isVoiceGuidanceOn", true);
    sharedPreferences!.setBool("isHalfwayPromptOn", true);
    loadSettings();
    Navigator.pop(context);
  }

  showCustomDialog(
      {title,
      msg,
      required onPressedBtnYes(),
      required onPressedButtonNo(),
      btnYesText,
      btnNoText,
      context}) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      t.mediumText(text: title, size: 22),
                      SizedBox(
                        height: 10,
                      ),
                      t.regularText(
                          text: msg, size: 15, alignment: TextAlign.center),
                      SizedBox(
                        height: 20,
                      ),
                      btnYesText == null
                          ? Container()
                          : Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      onPressedBtnYes();
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: BLUE,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Center(
                                          child: t.mediumText(
                                              text: btnYesText,
                                              color: WHITE,
                                              size: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                      btnYesText == null
                          ? Container()
                          : SizedBox(
                              height: 10,
                            ),
                      btnNoText == null
                          ? Container()
                          : Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      onPressedButtonNo();
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: LIGHT_GREY_SCREEN_BACKGROUND,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Center(
                                          child: t.mediumText(
                                              text: btnNoText,
                                              color: BLACK,
                                              size: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  loadAudio321(double v) async {
    await player.setAsset('assets/audios/321.wav').then((value) async {
      print("duration : ${value!.inMilliseconds}");
      player.setVolume(v);
      player.play();
    });
  }
}

extension TOD on TimeOfDay {
  DateTime toDateTime() {
    return DateTime(1, 1, 1, hour, minute);
  }
}

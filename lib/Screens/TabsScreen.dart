import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/Screens/CustomWorkoutCategory.dart';
import 'package:exercise_app/Screens/Daily.dart';
import 'package:exercise_app/Screens/Home.dart';
import 'package:exercise_app/Screens/Stores.dart';
import 'package:exercise_app/Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../CustomWidgets/CustomDialogues.dart';
import '../Modals/AllWorkoutsClass.dart';
import '../main.dart';
import 'AllWorkouts.dart';
import 'CustomWorkouts.dart';
import 'HomeScreen.dart';
import 'SmashScreen.dart';
import 'Settings.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> screens = [
    Home(),
    SmashScreen(),
    CustomWorkouts(),
    Daily(),
    Settings()
  ];

  int index = 0;

  Future<bool> _onWillPop() async {
    showCustomDialog(
        title: '',
        msg: 'Are you sure you want to exit?',
        btnYesText: YES,
        btnNoText: NO,
        onPressedButtonNo: () {
          Navigator.pop(context);
        },
        onPressedBtnYes: () {
          SystemNavigator.pop();
        },
        context: context);
    return Future.value();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            backgroundColor: BLACK,
            body: Container(
                width: WIDTH,
                height: HEIGHT,
                child: Stack(children: [
                  Column(
                    children: [
                      Expanded(
                        child: screens[index],
                      ),
                    ],
                  ),
                ])),
            bottomNavigationBar: Container(
              margin: EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        index == 0
                            ? "assets/bottom/home_active.png"
                            : "assets/bottom/home.png",
                        height: 25,
                        width: 25,
                        fit: BoxFit.contain,
                      ),
                      label: HOME[LANGUAGE_TYPE],
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        index == 1
                            ? "assets/bottom/smash_active.png"
                            : "assets/bottom/smash.png",
                        height: 25,
                        width: 25,
                        fit: BoxFit.contain,
                      ),
                      label: "Smash +",
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        index == 2
                            ? "assets/bottom/custom_active.png"
                            : "assets/bottom/custom.png",
                        height: 25,
                        width: 25,
                        fit: BoxFit.contain,
                      ),
                      label: CUSTOM[LANGUAGE_TYPE],
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        index == 3
                            ? "assets/bottom/daily_active.svg"
                            : "assets/bottom/daily.svg",
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      ),
                      label: "Daily",
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        index == 4
                            ? "assets/bottom/me_active.svg"
                            : "assets/bottom/me.svg",
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                      label: "Me",
                    ),
                  ],
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  selectedFontSize: ipad ? 24 : 14,
                  unselectedFontSize: ipad ? 24 : 14,
                  selectedItemColor: PRIMARY,
                  unselectedItemColor: LIGHT_GREY_TEXT.withOpacity(0.5),
                  backgroundColor: GRAY,
                  onTap: (i) {
                    setState(() {
                      index = i;
                    });
                  },
                  currentIndex: index,
                ),
              ),
            )),
      ),
    );
  }
}

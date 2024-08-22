import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Themes.dart';
import '../main.dart';

class UnitSetting extends StatefulWidget {
  @override
  _UnitSettingState createState() => _UnitSettingState();
}

class _UnitSettingState extends State<UnitSetting> {
  int heightUnit = 0;
  int weightUnit = 0;
  List<bool> isChipHeightSelected = [true, false];
  List<bool> isChipWeightSelected = [true, false];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      heightUnit = value.getInt("heightunit") ?? 0;
      weightUnit = value.getInt("weightunit") ?? 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BLACK,
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: BLACK,
        leading: IconButton(
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
                      color: LIGHT_GREY_TEXT, spreadRadius: 0.1, blurRadius: 4)
                ],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Icon(
              Icons.arrow_back_ios,
              color: WHITE,
              size: 18,
            ),
          ),
        ),
        title: t.boldText(text: 'Unit Settings', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(children: [
        InkWell(
            onTap: () {
              showDialog<String>(
                  context: context,
                  builder: (context) => weightUnitDialog()).then((value) {
                if (value == 'kg') {
                  setState(() {
                    isChipWeightSelected[0] = true;
                    isChipWeightSelected[1] = false;
                    weightUnit = 0;
                  });
                } else {
                  setState(() {
                    isChipWeightSelected[0] = false;
                    isChipWeightSelected[1] = true;
                    weightUnit = 1;
                  });
                }
                SharedPreferences.getInstance().then((value) {
                  value.setInt("heightunit", heightUnit);
                  value.setInt("weightunit", weightUnit);
                });
              });
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: GRAY),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      t.mediumText(text: 'Weight Unit', size: 18, color: WHITE),
                      t.mediumText(
                          text: weightUnit == 0 ? 'kg' : 'lb',
                          size: 15,
                          color: PRIMARY)
                    ]))),
        InkWell(
            onTap: () {
              showDialog<String>(
                  context: context,
                  builder: (context) => heightUnitDialog()).then((value) {
                if (value == 'cm') {
                  setState(() {
                    isChipHeightSelected[0] = true;
                    isChipHeightSelected[1] = false;
                    heightUnit = 0;
                  });
                } else {
                  setState(() {
                    isChipHeightSelected[0] = false;
                    isChipHeightSelected[1] = true;
                    heightUnit = 1;
                  });
                }
                SharedPreferences.getInstance().then((value) {
                  value.setInt("heightunit", heightUnit);
                  value.setInt("weightunit", weightUnit);
                });
              });
            },
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: GRAY),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      t.mediumText(text: 'Height Unit', size: 18, color: WHITE),
                      t.mediumText(
                          text: heightUnit == 0 ? 'cm' : 'ft',
                          size: 15,
                          color: PRIMARY)
                    ]))),
      ]),
    );
  }

  Widget weightUnitDialog() {
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
                  SizedBox(height: 20),
                  t.mediumText(text: 'Weight Units', color: WHITE, size: 20),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'kg');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: ipad ? 30 : 17,
                                        width: ipad ? 30 : 17,
                                        decoration: BoxDecoration(
                                            color:
                                                isChipWeightSelected[0] == false
                                                    ? PRIMARY
                                                    : PRIMARY,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: GRAY,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    color: isChipWeightSelected[
                                                                0] ==
                                                            false
                                                        ? null
                                                        : PRIMARY,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customTextWidget.mediumText(
                                                  text: 'kg',
                                                  size: ipad ? 32 : 16,
                                                  color: WHITE),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'lb');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: ipad ? 30 : 17,
                                        width: ipad ? 30 : 17,
                                        decoration: BoxDecoration(
                                            color:
                                                isChipWeightSelected[1] == false
                                                    ? PRIMARY
                                                    : PRIMARY,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: GRAY,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    color: isChipWeightSelected[
                                                                1] ==
                                                            false
                                                        ? null
                                                        : PRIMARY,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customTextWidget.mediumText(
                                                  text: 'lb',
                                                  size: ipad ? 32 : 16,
                                                  color: WHITE),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget heightUnitDialog() {
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
                  SizedBox(height: 20),
                  t.mediumText(text: 'Height Units', color: WHITE, size: 20),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'cm');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: ipad ? 30 : 17,
                                        width: ipad ? 30 : 17,
                                        decoration: BoxDecoration(
                                            color:
                                                isChipHeightSelected[0] == false
                                                    ? PRIMARY
                                                    : PRIMARY,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: GRAY,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    color: isChipHeightSelected[
                                                                0] ==
                                                            false
                                                        ? null
                                                        : PRIMARY,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customTextWidget.mediumText(
                                                  text: 'cm',
                                                  size: ipad ? 32 : 16,
                                                  color: WHITE),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'ft');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: ipad ? 30 : 17,
                                        width: ipad ? 30 : 17,
                                        decoration: BoxDecoration(
                                            color:
                                                isChipHeightSelected[1] == false
                                                    ? PRIMARY
                                                    : PRIMARY,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: GRAY,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    color: isChipHeightSelected[
                                                                1] ==
                                                            false
                                                        ? null
                                                        : PRIMARY,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              customTextWidget.mediumText(
                                                  text: 'ft',
                                                  size: ipad ? 32 : 16,
                                                  color: WHITE),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

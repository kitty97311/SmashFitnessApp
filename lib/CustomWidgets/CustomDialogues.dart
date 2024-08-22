import 'dart:async';

import 'package:exercise_app/Modals/AllWorkoutsClass.dart';
import 'package:exercise_app/Screens/TabsScreen.dart';
import 'package:exercise_app/main.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exercise_app/AllText.dart';
import '../Themes.dart';
import 'CustomTextWidget.dart';

class CustomDialogues {
  CustomTextWidget customTextWidget = CustomTextWidget();

  infoDialog(
      {BuildContext? context,
      var title,
      var msg,
      var btnText1,
      var btnText2,
      Widget? widget,
      bool? doPop,
      xyz()?}) {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        xyz!();
        return AlertDialog(
          backgroundColor: WHITE,
          //insetPadding: EdgeInsets.all(16),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              t.boldText(
                text: title,
                size: ipad ? 40 : 20,
                color: BLACK,
              ),
              SizedBox(
                height: 10,
              ),
              t.mediumText(
                text: msg,
                size: ipad ? 24 : 12,
                color: BLACK,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  btnText2 != null
                      ? Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: LIGHT_GREY_SCREEN_BACKGROUND,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: BLUE, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                              child: customTextWidget.boldText(
                                  text: btnText2,
                                  size: ipad ? 28 : 14,
                                  color: BLACK),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        )
                      : Container(),
                ],
              ),
              Row(
                children: [
                  btnText1 != null
                      ? Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BLUE,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: LIGHT_GREY_TEXT, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                              child: customTextWidget.boldText(
                                  text: btnText1,
                                  size: ipad ? 28 : 14,
                                  color: WHITE),
                              onPressed: () {
                                if (doPop!) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => widget!));
                                }
                              }),
                        )
                      : Container(),
                ],
              )
            ],
          ),
          // child: Stack(
          //   children: [
          //     Center(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Container(
          //             height: 180,
          //             width: 180,
          //             decoration: BoxDecoration(
          //                 color: BLUE,
          //                 borderRadius: BorderRadius.all(Radius.circular(90))),
          //
          //           ),
          //         ],
          //       ),
          //     ),
          //     Center(
          //       child: Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Container(
          //           decoration: BoxDecoration(
          //               color: WHITE,
          //             shape: BoxShape.circle
          //           ),
          //               //borderRadius: BorderRadius.only(topLeft: Radius.circular(75),bottomLeft: Radius.circular(75),topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
          //           child: Row(
          //             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(16.0),
          //                 child: Container(
          //
          //                  child: Icon(Icons.info,size: 60,color: BLUE,),
          //                 ),
          //               ),
          //               Expanded(
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(left: 8,top: 12,right: 8),
          //                   child: Column(
          //                     mainAxisSize: MainAxisSize.min,
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //
          //                       customTextWidget.boldText(text:title,size: 15,color: BLACK),
          //                       SizedBox(height: 10,),
          //                       Row(
          //                         children: [
          //                           Container(
          //                               child: customTextWidget.mediumText(text:msg.toString().substring(0,50),size: 10,color: BLACK),
          //                           )
          //                         ],
          //                       ),
          //                       SizedBox(height: 10,),
          //                       Row(
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           btnText2 != null ? SizedBox(
          //                             width: 60,
          //                             child: RaisedButton(
          //                                 disabledColor: LIGHT_GREY_TEXT,
          //                                 shape: RoundedRectangleBorder(
          //                                     side: BorderSide(color:BLUE, width: 1),
          //
          //                                     borderRadius: BorderRadius.all(Radius.circular(20.0))),
          //                                  child: customTextWidget.regularText(text: btnText2,size: 10,color: BLACK),
          //                                 onPressed: (){
          //                                   Navigator.pop(context);
          //
          //                             }),
          //                           ) : Container(),
          //                           SizedBox(width: 10,),

          //                         ],
          //                       ),
          //                       SizedBox(height: 10,),
          //                     ],
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          //
          // )
        );
      },
    );
  }

  progressDialog({BuildContext? context, String? title}) {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            color: BLUE,
                            borderRadius:
                                BorderRadius.all(Radius.circular(90))),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: WHITE,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(75),
                              bottomLeft: Radius.circular(75),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 60,
                              width: 60,
                              // decoration: BoxDecoration(
                              //
                              //     borderRadius: BorderRadius.all(Radius.circular(50))),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          customTextWidget.mediumText(
                              text: title, size: ipad ? 30 : 15, color: BLACK),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }

  confirmDialog(
      {BuildContext? context,
      double? annualpay,
      String? trial,
      Widget? widget,
      bool? doPop}) {
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            elevation: 0.0,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: BLACK,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0))),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      t.boldText(
                        text: '🤫',
                        size: 30,
                        color: WHITE,
                      ),
                      SizedBox(height: 10),
                      t.boldText(
                          text:
                              'Not ready to commit? No problem give us a test drive for free.',
                          size: 20,
                          color: WHITE,
                          alignment: TextAlign.center),
                      SizedBox(height: 10),
                      t.mediumText(
                          text:
                              'There is an ample amount of workouts available to all users 100% Free',
                          size: 15,
                          color: WHITE,
                          alignment: TextAlign.center),
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
                                      side:
                                          BorderSide(color: PRIMARY, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                ),
                                child: Column(children: [
                                  customTextWidget.boldText(
                                      text: 'Yes, I\'m sure',
                                      size: 20,
                                      color: WHITE)
                                ]),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TabsScreen()));
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
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  shape: RoundedRectangleBorder(
                                      side:
                                          BorderSide(color: PRIMARY, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                ),
                                child: Column(children: [
                                  customTextWidget.boldText(
                                      text: 'Keep the plan',
                                      size: 20,
                                      color: BLACK),
                                  customTextWidget.lightText(
                                      text: '${trial}\$${annualpay}/year',
                                      size: 15,
                                      color: BLACK)
                                ]),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TabsScreen()));
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
      },
    );
  }

  header(
      {String? text,
      context,
      Widget? widget,
      bool? whiteicon,
      bool? goToHomeScreen}) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              goToHomeScreen != null
                  ? Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => TabsScreen()))
                  : Navigator.pop(context);
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                whiteicon == true
                    ? Image.asset(
                        "assets/bottom/back.png",
                        height: 20,
                        width: 30,
                      )
                    : Image.asset(
                        "assets/setting/back.png",
                        height: 20,
                        width: 30,
                      ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text!,
                        style: TextStyle(
                          fontSize: ipad ? 30 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Bold',
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
    );
  }

  messageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "hi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            color: BLUE,
                            borderRadius:
                                BorderRadius.all(Radius.circular(90))),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: WHITE,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(75),
                              bottomLeft: Radius.circular(75),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 60,
                              width: 60,
                              // decoration: BoxDecoration(
                              //
                              //     borderRadius: BorderRadius.all(Radius.circular(50))),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          customTextWidget.mediumText(
                              text: "Loading..",
                              size: ipad ? 30 : 15,
                              color: BLACK),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "ok",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: BLACK,
                  ),
                ),
              ),
            ],
          );
        });
  }
}

loader({double? height, double? width, double? borderRadius}) {
  return Container(
      height: height,
      width: width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius!),
          child: FlareActor("flare/loader.flr",
              alignment: Alignment.center,
              fit: BoxFit.fill,
              animation: "Untitled")));
}

placeHolder({double? height, double? width, double? borderRadius}) {
  return Container(
      height: height,
      width: width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius!),
          child: FlareActor("flare/placeholder.flr",
              alignment: Alignment.center,
              fit: BoxFit.fill,
              animation: "idle")));
}

myCustomDialog(
    {title,
    msg,
    onPressedBtnYes()?,
    onPressedButtonNo()?,
    btnYesText,
    btnNoText}) {
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
              t.mediumText(text: title, size: ipad ? 44 : 22),
              SizedBox(
                height: 10,
              ),
              t.regularText(
                  text: msg, size: ipad ? 30 : 15, alignment: TextAlign.center),
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
                              onPressedBtnYes!();
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
                                      size: ipad ? 30 : 15),
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
                              onPressedButtonNo!();
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
                                      size: ipad ? 30 : 15),
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
}

showCustomDialog(
    {title,
    msg,
    onPressedBtnYes()?,
    onPressedButtonNo()?,
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
              color: GRAY,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    t.mediumText(
                        text: title, size: ipad ? 44 : 22, color: WHITE),
                    SizedBox(
                      height: 10,
                    ),
                    t.regularText(
                        text: msg,
                        size: ipad ? 30 : 15,
                        color: WHITE,
                        alignment: TextAlign.center),
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
                                    onPressedBtnYes!();
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: PRIMARY,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: t.mediumText(
                                            text: btnYesText,
                                            color: BLACK,
                                            size: ipad ? 30 : 15),
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
                                    onPressedButtonNo!();
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

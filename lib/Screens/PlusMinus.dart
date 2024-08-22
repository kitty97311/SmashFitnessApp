import 'package:exercise_app/LocalDatabase/CustomWorkoutsClass.dart';
import 'package:exercise_app/LocalDatabase/ProgressClass.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Themes.dart';
import '../main.dart';
import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';

class PlusMinus extends StatefulWidget {
  int type;

  PlusMinus(this.type);

  @override
  _PlusMinusState createState() => _PlusMinusState();
}

class _PlusMinusState extends State<PlusMinus> {
  int duration = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    SharedPreferences.getInstance().then((value) {
      int countdown = value.getInt("countdown") ?? 3;
      int rest = value.getInt("rest") ?? 4;
      if (widget.type == 0) duration = countdown;
      if (widget.type == 1) duration = rest;
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
        title: t.boldText(text: 'Set Duration', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: 50),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    SharedPreferences.getInstance().then((value) {
                      setState(() {
                        if (duration > 1) duration -= 1;
                      });
                      if (widget.type == 0) value.setInt("countdown", duration);
                      if (widget.type == 1) value.setInt("rest", duration);
                    });
                  },
                  child: Icon(Icons.arrow_back_ios, size: 30, color: WHITE)),
              SizedBox(width: 50),
              t.boldText(text: duration.toString(), color: PRIMARY, size: 50),
              SizedBox(width: 50),
              InkWell(
                  onTap: () {
                    SharedPreferences.getInstance().then((value) {
                      setState(() {
                        duration += 1;
                      });
                      if (widget.type == 0) value.setInt("countdown", duration);
                      if (widget.type == 1) value.setInt("rest", duration);
                    });
                  },
                  child: Icon(Icons.arrow_forward_ios, size: 30, color: WHITE))
            ]),
        Center(
          child: t.mediumText(text: 'secs', color: WHITE, size: 20),
        )
      ]),
    );
  }
}

import 'package:exercise_app/Screens/TabsScreen.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../Themes.dart';

class Plan2 extends StatefulWidget {
  @override
  _Plan2State createState() => _Plan2State();
}

class _Plan2State extends State<Plan2> {
  int selectedPlan = 1;
  List<Map<String, dynamic>> list = [
    {"month": 1, "weekpay": 6.00, "annualpay": 59.00},
    {"month": 12, "weekpay": 2.00, "annualpay": 150.00},
    {"month": 3, "weekpay": 4.00, "annualpay": 100.00},
  ];
  bool light = true;
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
    List<Widget> widgetList = list.asMap().entries.map((entry) {
      return Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: entry.key == selectedPlan ? PRIMARY : BLACK,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: customTextWidget.boldText(
                      text: 'HOTTEST', color: BLACK, size: 18),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedPlan = entry.key;
                      });
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: GRAY),
                        child: Column(children: [
                          Text(entry.value['month'].toString(),
                              style: TextStyle(color: WHITE, fontSize: 30)),
                          customTextWidget.mediumText(
                              text: 'Months', color: WHITE, size: 15),
                          customTextWidget.boldText(
                              text:
                                  '\$${entry.value['weekpay'].toString()}/Week',
                              color: WHITE,
                              size: 16),
                          customTextWidget.mediumText(
                              text:
                                  '\$${entry.value['annualpay'].toString()} yearly',
                              color: WHITE,
                              size: 16),
                        ]))),
              ])));
    }).toList();
    return Scaffold(
        backgroundColor: BLACK,
        body: Stack(children: [
          ListView(
            children: [
              Stack(children: [
                Container(
                    width: WIDTH,
                    child: Image.asset('assets/setup/plan2.png',
                        fit: BoxFit.cover)),
                Positioned(
                    bottom: 0,
                    width: WIDTH,
                    child: Column(children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [BLACK.withOpacity(0.05), BLACK])),
                      ),
                    ]))
              ]),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: customTextWidget.boldText(
                      text: 'SELECT YOUR PLAN',
                      color: WHITE,
                      size: 35,
                      alignment: TextAlign.center)),
              Center(
                  child: Container(
                      width: WIDTH * 0.6,
                      height: 2,
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          color: PRIMARY,
                          borderRadius: BorderRadius.circular(100)))),
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(children: widgetList)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: PRIMARY),
                      borderRadius: BorderRadius.circular(100)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customTextWidget.mediumText(
                            text: 'Enable 7-day free trial',
                            color: WHITE,
                            size: 18,
                            alignment: TextAlign.center),
                        Switch(
                          value: light,
                          activeColor: PRIMARY,
                          onChanged: (bool value) {
                            setState(() {
                              light = value;
                            });
                          },
                        )
                      ])),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      customDialogues.confirmDialog(
                          context: context,
                          annualpay: list[selectedPlan]['annualpay'],
                          trial: light ? 'Free 7-day trial ' : '');
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
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/setup/check.png'),
                        SizedBox(width: 5),
                        customTextWidget.mediumText(
                            text: 'No Payment now!', color: WHITE, size: 18),
                      ]))
            ],
          ),
          Positioned(
              left: 16,
              top: 50,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => TabsScreen()));
                },
                icon: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: BLACK,
                      boxShadow: [
                        BoxShadow(
                            color: LIGHT_GREY_TEXT,
                            spreadRadius: 0.1,
                            blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Icon(
                    Icons.close,
                    color: WHITE,
                    size: 18,
                  ),
                ),
              ))
        ]));
  }
}

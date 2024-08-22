import 'package:flutter/material.dart';

import '../Themes.dart';
import '../main.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  List<Map<String, dynamic>> list = [
    {'language': 'en', 'name': 'English'},
  ];
  List<bool> isChipSelected = [];

  @override
  void initState() {
    super.initState();
    initialiseList();
  }

  initialiseList() {
    for (int i = 0; i < list.length; i++) {
      if (list[i]['language'] == LANGUAGE_TYPE)
        isChipSelected.add(true);
      else
        isChipSelected.add(false);
    }
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
        title: t.boldText(text: 'Language Options', color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(children: [
        list.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Icon(Icons.language, color: WHITE, size: 50)),
                      SizedBox(height: 20),
                      Center(
                          child: t.mediumText(
                              text: 'No Languages', color: WHITE, size: 20))
                    ]))
            : Container(
                child: Column(
                    children: List.generate(
                        list.length,
                        (index) => tile(list[index]['name'],
                            list[index]['language'], index)))),
      ]),
    );
  }

  tile(String name, String language, int index) => Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2),
        child: GestureDetector(
          onTap: () {
            for (int i = 0; i < isChipSelected.length; i++) {
              isChipSelected[i] = false;
            }
            isChipSelected[index] = true;
            setState(() {});
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: ipad ? 30 : 17,
                            width: ipad ? 30 : 17,
                            decoration: BoxDecoration(
                                color: isChipSelected[index] == false
                                    ? PRIMARY
                                    : PRIMARY,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                    color: GRAY,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        color: isChipSelected[index] == false
                                            ? null
                                            : PRIMARY,
                                        borderRadius: BorderRadius.circular(8)),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customTextWidget.mediumText(
                                      text: name,
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
      );
}

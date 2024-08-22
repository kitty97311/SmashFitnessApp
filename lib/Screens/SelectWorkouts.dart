import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutCreateClass.dart';
import 'package:exercise_app/Modals/AllWorkoutsClass.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseMp4.dart';
import 'package:exercise_app/Screens/SelectExercise.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import '../AllText.dart';
import '../Themes.dart';
import '../main.dart';
import 'HowToExercise/HowToExerciseYoutube.dart';

class SelectWorkouts extends StatefulWidget {
  int id;
  String title;
  List<Create> list;
  int supersetPrimaryId;
  int updateIndex; // workoutBox index

  SelectWorkouts(
      this.id, this.title, this.list, this.supersetPrimaryId, this.updateIndex);
  @override
  _SelectWorkoutsState createState() => _SelectWorkoutsState();
}

class _SelectWorkoutsState extends State<SelectWorkouts> {
  List<bool> isChipSelected = [];
  List<Create> workoutslist = [];
  AllWorkoutsClass? allWorkoutsClass;
  BannerAd? banner;

  List<String> sorts = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '#'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getExercisesList();
    BannerAd(
      adUnitId: getBannerAdUnitId()!,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            banner = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  initialiseList() {
    for (int i = 0; i < workoutslist.length; i++) {
      int exist = 0;
      for (int j = 0; j < widget.list.length; j++) {
        if (workoutslist[i].id == widget.list[j].id) {
          exist = 1;
          break;
        }
      }
      if (exist > 0)
        isChipSelected.add(true);
      else
        isChipSelected.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
        title: t.boldText(text: widget.title, color: WHITE, size: 25),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              decoration: BoxDecoration(
                  color: GRAY, borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: LIGHT_GREY_TEXT,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: TAB_GREY_DARK, fontSize: 15),
                ),
                style: TextStyle(
                    color: LIGHT_GREY_TEXT, fontFamily: 'Bold', fontSize: 15),
              )),
          workoutslist.isEmpty
              ? allWorkoutsClass != null
                  ? Container()
                  : Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return exercisesCardLoader();
                          }),
                    )
              : Expanded(
                  child: Stack(children: [
                  ListView.builder(
                      itemCount: workoutslist.length,
                      itemBuilder: (BuildContext builder, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 2),
                          child: GestureDetector(
                            onTap: () {
                              if (widget.supersetPrimaryId > 0)
                                for (int i = 0;
                                    i < isChipSelected.length;
                                    i++) {
                                  if (isChipSelected[i] == true && i != index) {
                                    showCustomDialog(
                                        context: context,
                                        title: ERROR,
                                        msg: 'Select only one exercise.',
                                        btnYesText: OK,
                                        onPressedBtnYes: () {
                                          Navigator.pop(context);
                                        });
                                    return;
                                  }
                                }

                              setState(() {
                                isChipSelected[index] = !isChipSelected[index];
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  margin: EdgeInsets.symmetric(horizontal: 32),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: GRAY),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: BACK_GREY,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  height: 30,
                                                  width: 30,
                                                  imageUrl:
                                                      IMAGE_URL_MENU_ITEMLive +
                                                              workoutslist[
                                                                      index]
                                                                  .image! ??
                                                          " ",
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Container(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          placeHolder(
                                                              borderRadius: 10),
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //   width: 30,
                                            //   height: 30,
                                            //   child: ClipRRect(
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               100),
                                            //       child: Image.asset(
                                            //           'assets/excercises/round2.png',
                                            //           fit: BoxFit.cover)),
                                            // ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    customTextWidget.mediumText(
                                                        text:
                                                            workoutslist[index]
                                                                    .name ??
                                                                " ",
                                                        size: ipad ? 32 : 16,
                                                        color: WHITE),
                                                    // customTextWidget.mediumText(
                                                    //     text: "X " +
                                                    //         workoutslist[index]
                                                    //             .repeatCount!,
                                                    //     size: ipad ? 20 : 16,
                                                    //     color: DARK_GREY_TEXT),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: ipad ? 30 : 17,
                                              width: ipad ? 30 : 17,
                                              decoration: BoxDecoration(
                                                  color:
                                                      isChipSelected[index] ==
                                                              false
                                                          ? PRIMARY
                                                          : PRIMARY,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  decoration: BoxDecoration(
                                                      color: GRAY,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Container(
                                                      height: 16,
                                                      width: 16,
                                                      decoration: BoxDecoration(
                                                          color: isChipSelected[
                                                                      index] ==
                                                                  false
                                                              ? null
                                                              : PRIMARY,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DISPLAY_ADS &&
                                        banner != null &&
                                        (index + 1) % 4 == 0
                                    ? AdWidget(
                                        ad: banner!,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        );
                      }),
                  Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color: GRAY,
                        child: Column(
                            children: List.generate(
                                sorts.length,
                                (index) => t.regularText(
                                    text: sorts[index], color: WHITE))),
                      ))
                ])),
          InkWell(
            onTap: () {
              List<Create> value = [];
              bool checked = false;
              for (int i = 0; i < widget.list.length; i++) {
                value.add(widget.list[i]);
              }
              for (int i = 0; i < workoutslist.length; i++) {
                if (isChipSelected[i] == true) {
                  checked = true;
                  value.add(workoutslist[i]);
                }
              }

              int ttlcalories = 0;
              int ttltime = 0;

              for (int i = 0; i < value.length; i++) {
                ttlcalories =
                    (int.parse(value[i].calories ?? "0")) + ttlcalories;
                ttltime = (int.parse(value[i].time ?? "0")) + ttltime;
              }

              if (checked) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectExercise(
                        value,
                        ttltime.toString(),
                        ttlcalories.toString(),
                        value.length.toString(),
                        widget.supersetPrimaryId,
                        widget.updateIndex),
                  ),
                );
              } else {
                showCustomDialog(
                    context: context,
                    title: ERROR,
                    msg: 'Select at least one exercise.',
                    btnYesText: OK,
                    onPressedBtnYes: () {
                      Navigator.pop(context);
                    });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 16),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: PRIMARY,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Center(
                    child: t.boldText(
                        text: 'Next', color: BLACK, size: ipad ? 36 : 18),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  getExercisesList() async {
    final _response = await http.get(Uri.parse(SERVER_ADDRESSLive +
        "/api/get_subsmashexcercise?sub_smash_id=" +
        widget.id.toString()));
    final _jsonResponse = jsonDecode(_response.body);

    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      allWorkoutsClass = AllWorkoutsClass.fromJson(_jsonResponse);

      if (widget.list.isEmpty) {
        workoutslist = allWorkoutsClass!.exercise!.create!;
      } else {
        for (int i = 0; i < allWorkoutsClass!.exercise!.create!.length; i++) {
          int exist = 0;
          for (int j = 0; j < widget.list.length; j++) {
            if (allWorkoutsClass!.exercise!.create![i].id ==
                widget.list[j].id) {
              exist = 1;
              break;
            }
          }
          if (exist == 0) {
            workoutslist.add(allWorkoutsClass!.exercise!.create![i]);
          }
        }
      }
      workoutslist
          .sort((a, b) => a.name.toString().compareTo(b.name.toString()));
      setState(() {});
      initialiseList();
    } else {}
  }

  Widget exercisesCardLoader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: GRAY, borderRadius: BorderRadius.circular(100)),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: BACK_GREY,
                        borderRadius: BorderRadius.circular(10)),
                    child: loader(height: 30, width: 30, borderRadius: 5),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: loader(height: 12, width: 150, borderRadius: 100),
                  )
                ],
              ),
            ),
            loader(height: 30, width: 30, borderRadius: 25)
          ],
        ),
      ),
    );
  }
}

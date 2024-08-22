import 'dart:convert';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/Screens/StoreDetail.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../Themes.dart';
import '../main.dart';
import '../AllText.dart';

class Stores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  List<Map<String, dynamic>> list = [];

  @override
  void initState() {
    super.initState();
    getData();
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
        title: t.boldText(
            text: 'Supplement Store'.toUpperCase(), color: WHITE, size: 20),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return GridView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.85,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        children: List.generate(
            list.length,
            (index) => card(list[index]['image1'], list[index]['name'],
                list[index]['price'], list[index]['like'], index)));
  }

  card(String img, String title, String price, int like, int index) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StoreDetail(item: list[index])));
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: GRAY),
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: IMAGE_SUPPLEMENT_ITEMLive + img ?? " ",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(),
                        errorWidget: (context, url, error) => placeHolder(
                            height: 100, width: 100, borderRadius: 10),
                      )),
                ),
              ),
              SizedBox(height: 15),
              t.mediumText(text: title, size: 15, color: WHITE),
              t.mediumText(text: "\$$price", size: 15, color: WHITE),
              Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: PRIMARY),
                    borderRadius: BorderRadius.circular(5),
                    color: null,
                  ),
                  child: Center(
                    child: customTextWidget.mediumText(
                        text: 'Add to Cart', color: PRIMARY, size: 12),
                  ),
                ),
              )
            ]),
            Positioned(
                right: 0,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        list[index]['like'] = 1 - list[index]['like'];
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      color: (like == 0) ? LIGHT_GREY_TEXT : PRIMARY,
                    )))
          ])));

  getData() async {
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive + "/api/get_supplement"))
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

    final _jsonResponse = jsonDecode(_response.body);
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      for (int i = 0; i < _jsonResponse['data'].length; i++) {
        Map<String, dynamic> item = {};
        item['id'] = _jsonResponse['data'][i]['id'];
        item['name'] = _jsonResponse['data'][i]['name'];
        item['description'] = _jsonResponse['data'][i]['description'];
        item['price'] = _jsonResponse['data'][i]['price'];
        item['rating'] = _jsonResponse['data'][i]['rating'];
        item['image1'] = _jsonResponse['data'][i]['image1'];
        item['image2'] = _jsonResponse['data'][i]['image2'];
        item['image3'] = _jsonResponse['data'][i]['image3'];
        item['like'] = 0;
        list.add(item);
      }
      if (mounted) setState(() {});
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
}

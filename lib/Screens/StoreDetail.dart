import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Themes.dart';
import '../main.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';

class StoreDetail extends StatefulWidget {
  Map<String, dynamic>? item;
  StoreDetail({this.item});
  @override
  _StoreDetailState createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail>
    with TickerProviderStateMixin {
  int selectedItem = 0;
  List<Map<String, dynamic>> list = [];

  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.item!['image1'] != null)
        list.add({'img': IMAGE_SUPPLEMENT_ITEMLive + widget.item!['image1']});
      if (widget.item!['image2'] != null)
        list.add({'img': IMAGE_SUPPLEMENT_ITEMLive + widget.item!['image2']});
      if (widget.item!['image3'] != null)
        list.add({'img': IMAGE_SUPPLEMENT_ITEMLive + widget.item!['image3']});
    });
    _animationControllers = List.generate(
        list.length,
        (index) =>
            AnimationController(duration: Duration(seconds: 4), vsync: this));
    _animations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0, end: 50).animate(controller);
    }).toList();
    _animationControllers[0].forward();
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
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
    String name = (widget.item!['name'].toString().length < 15)
        ? widget.item!['name'].toString()
        : widget.item!['name'].toString().substring(0, 15) + '...';
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 250,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            decoration: BoxDecoration(
                color: GRAY, borderRadius: BorderRadius.circular(10)),
            child: Stack(children: [
              ListView(
                children: [
                  CarouselSlider.builder(
                    itemCount: list.length,
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedItem = index;
                        });
                        if (index == 0) {
                          for (var controller in _animationControllers) {
                            controller.reset();
                          }
                        }
                        _animationControllers[index].forward();
                      },
                    ),
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                            width: double.infinity,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: list[itemIndex]['img'],
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Container(),
                              errorWidget: (context, url, error) => placeHolder(
                                  height: 100, width: 100, borderRadius: 10),
                            )),
                  ),
                ],
              ),
              Positioned(
                  bottom: 10,
                  child: Container(
                      width: WIDTH - 16 * 2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              _animations.length, (index) => card(index)))))
            ])),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: PRIMARY),
                    borderRadius: BorderRadius.circular(5),
                    color: null,
                  ),
                  child: Center(
                    child: customTextWidget.mediumText(
                        text: 'Add to Cart', color: PRIMARY, size: 18),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            (widget.item!['like'] > 0)
                ? Icon(
                    Icons.favorite,
                    color: PRIMARY,
                  )
                : Icon(
                    Icons.favorite,
                    color: LIGHT_GREY_TEXT,
                  )
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            t.mediumText(text: name, size: 35, color: WHITE),
            Spacer(),
            t.mediumText(
                text: '\$${widget.item!['price']}', size: 20, color: PRIMARY),
          ]),
        ),
        if (widget.item!['description'] != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: t.mediumText(
                text: widget.item!['description'], size: 15, color: WHITE),
          )
      ],
    );
  }

  card(int index) => Container(
      width: 50,
      height: 5,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration:
          BoxDecoration(color: WHITE, borderRadius: BorderRadius.circular(100)),
      child: AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Stack(children: [
              Container(
                width: _animations[index].value,
                height: 5,
                decoration: BoxDecoration(
                    color: PRIMARY, borderRadius: BorderRadius.circular(100)),
              )
            ]);
          }));
}

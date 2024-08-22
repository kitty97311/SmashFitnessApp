import 'dart:io';
import 'package:exercise_app/Screens/EditProfile.dart';
import 'package:exercise_app/Screens/Upload.dart';
import 'package:exercise_app/Screens/Upload2.dart';
import 'package:exercise_app/testing/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';
import '../Themes.dart';
import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedTabIndex = 0;
  int selectedImageIndex = -1;
  int selectedVideoIndex = -1;

  String name = "";
  int postCount = 0;
  int followingCount = 0;
  int followerCount = 0;
  List<Map<String, dynamic>> images = [];
  List<Map<String, dynamic>> videos = [];
  int like = 0;
  int react = 0;
  List<Map<String, dynamic>> reactList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getUserInfo();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BLACK,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(400.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.only(left: 10),
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
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: WHITE,
                          size: 18,
                        ),
                      )),
                ),
              ),
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
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: customTextWidget.mediumText(
                      text: name,
                      color: WHITE,
                      size: 20,
                      alignment: TextAlign.center)),
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 100,
                            child: Column(children: [
                              t.boldText(
                                  text: postCount.toString(),
                                  color: WHITE,
                                  size: 20),
                              SizedBox(height: 5),
                              t.mediumText(
                                  text: 'Posts',
                                  color: LIGHT_GREY_TEXT,
                                  size: 15),
                            ])),
                        SizedBox(
                            width: 100,
                            child: Column(children: [
                              t.boldText(
                                  text: followingCount.toString(),
                                  color: WHITE,
                                  size: 20),
                              SizedBox(height: 5),
                              t.mediumText(
                                  text: 'Following',
                                  color: LIGHT_GREY_TEXT,
                                  size: 15),
                            ])),
                        SizedBox(
                            width: 100,
                            child: Column(children: [
                              t.boldText(
                                  text: followerCount.toString(),
                                  color: WHITE,
                                  size: 20),
                              SizedBox(height: 5),
                              t.mediumText(
                                  text: 'Followers',
                                  color: LIGHT_GREY_TEXT,
                                  size: 15),
                            ])),
                      ])),
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()));
                          },
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: PRIMARY,
                            ),
                            child: Center(
                                child: Row(children: [
                              customTextWidget.mediumText(
                                  text: 'Edit Profile', color: BLACK, size: 15),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ])),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            final url = 'https://www.google.com';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: PRIMARY),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Image.asset('assets/profile/share.png'),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            if (selectedTabIndex == 0)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UploadPage()));
                            if (selectedTabIndex == 1)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UploadPage2()));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: PRIMARY),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Image.asset('assets/profile/plus.png'),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {},
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: PRIMARY),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Image.asset('assets/profile/vector.png'),
                            ),
                          ),
                        ),
                      ])),
              TabBar(
                padding: EdgeInsets.symmetric(horizontal: 16),
                controller: _tabController,
                indicatorColor: PRIMARY,
                onTap: (value) {
                  setState(() {
                    selectedTabIndex = value;
                  });
                },
                tabs: [
                  Tab(
                      icon: Image.asset(selectedTabIndex == 0
                          ? 'assets/profile/image_active.png'
                          : 'assets/profile/image.png')),
                  Tab(
                      icon: Image.asset(selectedTabIndex == 1
                          ? 'assets/profile/video_active.png'
                          : 'assets/profile/video.png')),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          images.isEmpty
              ? Center(child: Icon(Icons.image, color: WHITE, size: 100))
              : ImageSection(
                  images: images,
                  selected: selectedImageIndex,
                  like: like,
                  react: react,
                  reactList: reactList,
                  onSelected: (index) {
                    getFeed(images[index]['id'], 0);
                    setState(() {
                      selectedImageIndex = index;
                    });
                  },
                  onBack: () {
                    setState(() {
                      selectedImageIndex = -1;
                    });
                  },
                ),
          videos.isEmpty
              ? Center(child: Icon(Icons.videocam, color: WHITE, size: 100))
              : VideoSection(
                  videos: videos,
                  selected: selectedVideoIndex,
                  like: like,
                  react: react,
                  reactList: reactList,
                  onSelected: (index) {
                    getFeed(videos[index]['id'], 1);
                    setState(() {
                      selectedVideoIndex = index;
                    });
                  },
                  onBack: () {
                    setState(() {
                      selectedVideoIndex = -1;
                    });
                  },
                ),
        ],
      ),
    );
  }

  getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive +
            "/api/get_userinfo?id=" +
            sp.getInt('memberID').toString()))
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
      Map<String, dynamic> info = _jsonResponse['data'];
      name = info['name'];
      if (info['upload'] != null) {
        for (var element in info['upload']) {
          images.add(element);
        }
      }
      if (info['upload2'] != null) {
        for (var element in info['upload2']) {
          Map<String, dynamic> item = {};
          final thumbnail = await VideoThumbnail.thumbnailFile(
            video: IMAGE_UPLOAD_ITEMLive + element['video'],
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.WEBP,
            maxHeight: 64,
            quality: 75,
          );
          item['id'] = element['id'];
          item['video'] = element['video'];
          item['thumbnail'] = thumbnail;
          item['owner_id'] = element['owner_id'];
          videos.add(item);
        }
      }
      postCount = images.length + videos.length;
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

  getFeed(int id, int media) async {
    reactList = [];
    like = 0;
    react = 0;
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESSLive +
            "/api/get_feed?id=" +
            id.toString() +
            "&media=" +
            media.toString()))
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
    if (_response.statusCode == 200) {
      if (_jsonResponse['data'] != null) {
        for (var data in _jsonResponse['data']) {
          if (data['favorite'] > 0) like = 1;
          if (data['react'].toString().isNotEmpty) {
            react = 1;
            reactList
                .add({'name': data['user']['name'], 'react': data['react']});
          }
        }
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

class ImageSection extends StatelessWidget {
  const ImageSection(
      {Key? key,
      required this.images,
      required this.selected,
      required this.like,
      required this.react,
      required this.reactList,
      required this.onSelected,
      required this.onBack})
      : super(key: key);
  final List<Map<String, dynamic>> images;
  final int selected;
  final int like;
  final int react;
  final List<Map<String, dynamic>> reactList;
  final Function(int) onSelected;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    if (selected >= 0) {
      print(reactList);
      return ListView(children: [
        Container(
          width: WIDTH,
          margin: EdgeInsets.symmetric(vertical: 16),
          child: InkWell(
              onTap: () {
                onBack();
              },
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    IMAGE_UPLOAD_ITEMLive + images[selected]['image'] ?? " ",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(),
                errorWidget: (context, url, error) =>
                    placeHolder(height: 180, width: 280, borderRadius: 10),
              )),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              if (like > 0) Image.asset('assets/profile/like.png'),
              if (like > 0) SizedBox(width: 15),
              if (react > 0) Image.asset('assets/profile/message.png'),
            ])),
        SizedBox(height: 10),
        SingleChildScrollView(
          child: Column(
              children: List.generate(
                  reactList.length,
                  (index) => Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: t.mediumText(
                              text: reactList[index]['react'] != null
                                  ? reactList[index]['name'] +
                                      ' : ' +
                                      reactList[index]['react']
                                  : '',
                              color: WHITE,
                              size: 18))))),
        ),
      ]);
    } else {
      return GridView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
          children: List.generate(
              images.length,
              (index) => InkWell(
                  onTap: () {
                    onSelected(index);
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            IMAGE_UPLOAD_ITEMLive + images[index]['image'] ??
                                " ",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(),
                        errorWidget: (context, url, error) => placeHolder(
                            height: 180, width: 280, borderRadius: 10),
                      )))));
    }
  }
}

class VideoSection extends StatelessWidget {
  const VideoSection(
      {Key? key,
      required this.videos,
      required this.selected,
      required this.like,
      required this.react,
      required this.reactList,
      required this.onSelected,
      required this.onBack})
      : super(key: key);
  final List<Map<String, dynamic>> videos;
  final int selected;
  final int like;
  final int react;
  final List<Map<String, dynamic>> reactList;
  final Function(int) onSelected;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    if (selected >= 0) {
      print(reactList);
      return ListView(children: [
        Container(
          width: WIDTH,
          height: 200,
          color: BLACK,
          margin: EdgeInsets.symmetric(vertical: 16),
          child: InkWell(
              onTap: () {
                onBack();
              },
              child: MyVideoPlayer(
                  IMAGE_UPLOAD_ITEMLive + videos[selected]['video'])),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              if (like > 0) Image.asset('assets/profile/like.png'),
              if (like > 0) SizedBox(width: 15),
              if (react > 0) Image.asset('assets/profile/message.png'),
            ])),
        SizedBox(height: 10),
        SingleChildScrollView(
          child: Column(
              children: List.generate(
                  reactList.length,
                  (index) => Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: t.mediumText(
                              text: reactList[index]['react'] != null
                                  ? reactList[index]['name'] +
                                      ' : ' +
                                      reactList[index]['react']
                                  : '',
                              color: WHITE,
                              size: 18))))),
        ),
      ]);
    } else {
      return GridView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
          children: List.generate(
              videos.length,
              (index) => InkWell(
                  onTap: () {
                    onSelected(index);
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(File(videos[index]['thumbnail']),
                          fit: BoxFit.cover)))));
    }
  }
}

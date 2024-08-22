import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../Themes.dart';
import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';

class UploadPage2 extends StatefulWidget {
  @override
  _UploadPage2State createState() => _UploadPage2State();
}

class _UploadPage2State extends State<UploadPage2> {
  late List<XFile> videoList = [];
  late List<dynamic> thumbnailList = [];

  final ImagePicker picker = ImagePicker();

  Future getVideo(ImageSource media, BuildContext context) async {
    var video = await picker.pickVideo(source: media);
    Navigator.pop(context);
    if (video == null) return;
    var uint8list = await VideoThumbnail.thumbnailData(
      video: video.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );
    setState(() {
      videoList.add(video);
      thumbnailList.add(uint8list);
    });
  }

  Future<void> _postVideos() async {
    try {
      List<File> files = [];
      videoList.forEach((image) {
        File uploadvideo = File(image.path);
        files.add(uploadvideo);
      });

      SharedPreferences sp = await SharedPreferences.getInstance();

      var request = http.MultipartRequest(
          'POST', Uri.parse('$SERVER_ADDRESSLive/api/post_videos'));

      // Add the video files to the request
      for (final file in files) {
        final fileField =
            await http.MultipartFile.fromPath('videos[]', file.path);
        request.files.add(fileField);
      }
      request.fields.addAll({'id': sp.getInt('memberID').toString()});

      http.StreamedResponse response = await request.send();

      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsondata = jsonDecode(await response.stream.bytesToString());
        if (jsondata['success'] == '0') {
          showCustomDialog(
              context: context,
              title: ERROR,
              msg: jsondata["message"],
              btnYesText: OK,
              onPressedBtnYes: () {
                Navigator.pop(context);
              });
        } else {
          setState(() {
            videoList = [];
            thumbnailList = [];
          });
          showCustomDialog(
              context: context,
              title: "Success",
              msg: jsondata["message"],
              btnYesText: OK,
              onPressedBtnYes: () {
                Navigator.pop(context);
              });
        }
      } else {
        debugPrint("Error during connection to server");
      }
    } catch (error) {
      debugPrint('Upload error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
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
        title: t.boldText(text: '', color: WHITE, size: 25),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(5)),
            onPressed: () {
              if (videoList.length > 0) {
                _postVideos();
              }
            },
            child: Text(
              'Post',
              style: TextStyle(
                  color: BLACK, fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
      ),
      body: body(),
    );
  }

  body() {
    List<Widget> lists = thumbnailList.map((item) {
      return Container(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            item,
            fit: BoxFit.cover,
            width: (MediaQuery.of(context).size.width - 120) / 3,
            height: (MediaQuery.of(context).size.width - 120) / 3,
          ),
        ),
      ));
    }).toList();
    lists.add(Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.width / 3,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: GRAY,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(5)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Wrap(
                    children: [
                      ListTile(
                        leading: Icon(Icons.photo),
                        title: Text('Gallery'),
                        onTap: () {
                          getVideo(ImageSource.gallery, context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.camera),
                        title: Text('Camera'),
                        onTap: () {
                          getVideo(ImageSource.camera, context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              '+',
              style: TextStyle(
                  color: LIGHT_GREY_TEXT,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          )),
    ));

    int rowCount = lists.length ~/ 3;
    List<Widget> rowList = [];
    for (int i = 0; i < rowCount + 1; i++) {
      if (lists.length > 3 * (i + 1)) {
        rowList.add(Row(children: lists.sublist(3 * i, 3 * (i + 1))));
      } else {
        rowList.add(Row(children: lists.sublist(3 * i, lists.length)));
      }
    }

    return Stack(alignment: Alignment.bottomCenter, children: [
      SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowList,
      ))
    ]);
  }
}

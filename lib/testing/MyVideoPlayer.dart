import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../Themes.dart';


class MyVideoPlayer extends StatefulWidget {
  String url;

  MyVideoPlayer(this.url);

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {

  TargetPlatform? _platform;
  VideoPlayerController? _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    this.initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.url);
    await _videoPlayerController1!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1!,
      autoPlay: false,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: BLACK,
      body: _chewieController != null &&
          _chewieController!
              .videoPlayerController.value.isInitialized
          ? Container(
            child: Chewie(
        controller: _chewieController!,
      ),
          )
          : Center(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading...'),
        ],
      ),
          ),
    );
  }
}

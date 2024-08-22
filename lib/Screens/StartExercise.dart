/*
import 'dart:async';
import 'dart:io';

//import 'package:assets_audio_player/assets_audio_player.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/CustomWidgets/VoiceAssistant.dart';
import 'package:exercise_app/LocalDatabase/ProgressClass.dart';
import 'package:exercise_app/Modals/ExercisesClass.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseMp4.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseYoutube.dart';
import 'package:flare_flutter/base/actor_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../AllText.dart';
import '../Themes.dart';
import '../main.dart';

class StartExercise extends StatefulWidget {

  List createList;
  int intervalTime;
  StartExercise(this.createList,this.intervalTime);

  @override
  _StartExerciseState createState() => _StartExerciseState();
}

class _StartExerciseState extends State<StartExercise> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  AnimationController? rotationController;
  double value = 0.0;
  bool isPlaying = true;
  int minutes = 00;
  int seconds = 00;
  int starting321 = 3;
  FlutterTts flutterTts = FlutterTts();
  List list = [];
  int currentIndex = 0;
  int completedExerciseTime = 0;
  int previousCompletedExerciseTime = 0;
  double executedAnimationTime = 0.0;
  int getReady10sec=0;
  int resumeTime = 0;
  Timer threeTwoOneTimer = Timer(Duration(seconds: 1),(){});
  Timer resumeTimer = Timer(Duration(seconds: 1),(){});
  Timer getReady10secTimerAction= Timer(Duration(seconds: 1),(){});
  Timer voicePauseTimer = Timer(Duration(seconds: 1),(){});
  ProgressClass? progressClass;
  bool isVoiceGuidanceOn = true;
  bool isTickTickVolumeOn = true;
  //AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  double volumeValue = 1.0;
  double volume = 1.0;
  bool isHalfwayOn = true;
  final player = AudioPlayer();
  bool showDialog = false;
  InterstitialAd? _interstitialAd;


  @override
  void initState() {
    // TODO: implement initState
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
    startCountDownAndInitializeValues();
    super.initState();
  }

  startCountDownAndInitializeValues(){
    getReady10sec = widget.intervalTime ?? 10;
    print(getReady10sec);
    voiceSetup();
    SharedPreferences.getInstance().then((value){
      setState(() {
        isVoiceGuidanceOn = value.getBool("isVoiceGuidanceOn") ?? true;
        isHalfwayOn = value.getBool("isHalfwayPromptOn") ?? true;
        volumeValue = volume = value.getDouble("volume") ?? 1;
      });
    });
    list.addAll(widget.createList);
    // print(list[currentIndex].image);
    getReady10secTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    threeTwoOneTimer.cancel();
    player.stop();
    player.dispose();
    //assetsAudioPlayer.stop();
    //audioCache.clear('321.wav');
    //audioCache.clear('tickTick.wav');
    print(rotationController!.status);
    rotationController!.dispose();
    rotationController!.removeListener(() { });
    print(rotationController!.status);
    voiceAssistant!.stop();
    resumeTimer.cancel();
    voicePauseTimer.cancel();
    currentIndex = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return starting321 >= 1 ? SafeArea(
      child: Scaffold(
        body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.black87,
            child: Center(
              child: t.mediumText(
                text: starting321.toString(),
                size: 120,
                color: WHITE,
              ),
            )
        ),
      ),
    ) :SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            body(),
            showDialog ? InkWell(
              onTap: (){
                // setState(() {
                //   showDialog = false;
                // });
              },
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.black54,
                child: myCustomDialog(
                  title: HURRAY,
                  msg: YOU_HAVE_SUCCESSFULLY_COMPLETED_YOUR_WORKOUT_WOULD_YOU_LIKE_TO_REPEAT_IT,
                  btnNoText: ENOUGH_FOR_TODAY,
                  btnYesText: YES_AM_READY,
                  onPressedBtnYes: () async{
                    setState(() {
                      showDialog = false;
                    });
                    if(DISPLAY_ADS){
                      customDialogues.progressDialog(context: context, title: SHOWING_AD[LANGUAGE_TYPE]);
                      // createInterstitialAd(true);
                    }else{
                      Navigator.pop(context);
                      await Future.delayed(Duration.zero);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StartExercise(widget.createList,0)),
                      );
                    }

                  },
                  onPressedButtonNo: (){
                    setState(() {
                      showDialog = false;
                    });
                    if(DISPLAY_ADS){
                      customDialogues.progressDialog(context: context, title: SHOWING_AD[LANGUAGE_TYPE]);
                      // createInterstitialAd(false);
                    }else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }

  body() {
    return Column(
      children: [
        SizedBox(height: 10,),
        AppBar(

          toolbarHeight: 40,
          elevation: 0,
          backgroundColor: BACK_GREY,
          leading: Container(),
          flexibleSpace: customDialogues.header(text: "",context: context),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                color: WHITE,
                padding: EdgeInsets.all(MediaQuery.of(context).size.height < 600 ? 8 : 16),
                child: Row(
                  children: List.generate(list.length, (index){
                    return Expanded(
                      child: currentIndex == index && getReady10sec == 0
                          ? LinearProgressIndicator(
                        backgroundColor: LIGHT_GREY_SCREEN_BACKGROUND,
                        minHeight: MediaQuery.of(context).size.height < 600 ? 4 : 6,
                        valueColor: AlwaysStoppedAnimation(BLUE),
                        value: value,
                      )
                          : Container(
                        height: MediaQuery.of(context).size.height < 600 ? 4 :6,
                        margin: EdgeInsets.all(1),
                        color: currentIndex > index ? BLUE : LIGHT_GREY_SCREEN_BACKGROUND,
                      ),
                    );
                  }),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height < 600 ? 10 :20,),
              Expanded(
                child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  height: 280,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  imageUrl: IMAGE_URL_MENU_ITEMLive + list[currentIndex].image,
                  progressIndicatorBuilder: (context, url,
                      downloadProgress) =>
                      Container(),
                  errorWidget: (context, url, error) =>
                      placeHolder(
                          borderRadius: 10
                      )
                )
              ),
              SizedBox(height: MediaQuery.of(context).size.height < 600 ? 10 :20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () async{
                        pauseOrPlay(false);
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => PLAY_YOUTUBE_VIDEOS ? HowToExerciseYoutube(list[currentIndex].id) : HowToExerciseMp4(list[currentIndex].id)));
                        pauseOrPlay(isPlaying ? true : false);
                        },
                      child: Image.asset("assets/startExcercise/about.png", height: MediaQuery.of(context).size.height < 600 ? 25 : 40, width: MediaQuery.of(context).size.height < 600 ? 25 : 40, fit: BoxFit.fill,)),
                  SizedBox(width: 10,),
                  InkWell(
                      onTap: () async{
                        setState(() {
                          isTickTickVolumeOn = !isTickTickVolumeOn;
                          isTickTickVolumeOn ? volume = volumeValue : volume = 0;
                        });
                      },
                      child: Image.asset(isTickTickVolumeOn ? "assets/startExcercise/volume.png" : "assets/startExcercise/mute.png", height: MediaQuery.of(context).size.height < 600 ? 25 : 40, width: MediaQuery.of(context).size.height < 600 ? 25 : 40, fit: BoxFit.fill,)),
                  SizedBox(width: 10,),
                  InkWell(
                      onTap: (){
                        setState(() {
                          isVoiceGuidanceOn = !isVoiceGuidanceOn;
                          if(!isVoiceGuidanceOn){
                            voiceAssistant!.stop();
                          }
                          isVoiceGuidanceOn ? flutterTts.setVolume(volumeValue) : flutterTts.setVolume(0);
                        });
                      },
                      child: Image.asset(isVoiceGuidanceOn ? "assets/startExcercise/mike.png" : "assets/startExcercise/mike_mute.png", height: MediaQuery.of(context).size.height < 600 ? 25 : 40, width: MediaQuery.of(context).size.height < 600 ? 25 : 40, fit: BoxFit.fill,)),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height < 600 ? 5 : 15,),
              Padding(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: t.boldText(
                    text: getReady10sec == 0 ? list[currentIndex].name : GET_READY[LANGUAGE_TYPE],
                    size: MediaQuery.of(context).size.height < 600 ? 20 : 27,
                    alignment: TextAlign.center
                ),
              ),
              SizedBox(height: 5,),
              Padding(
              padding: EdgeInsets.only(left: 16,right: 16),
              child:
              t.boldText(
                  text: getReady10sec == 0 ? NEXT_SMALL[LANGUAGE_TYPE]+" ${list[currentIndex + 1  < list.length ? currentIndex+1 : 0].name}" : NEXT_SMALL[LANGUAGE_TYPE]+ " ${list[currentIndex < list.length ? currentIndex : 0].name}",
                  size: MediaQuery.of(context).size.height < 600 ? 10 : 14,
                color: DARK_GREY_TEXT,

              ),),
              SizedBox(height: MediaQuery.of(context).size.height < 600 ? 5 : 20,),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.height / 4,
                child: Stack(
                  children: [
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(rotationController!),
                      alignment: Alignment.center,
                      child: Center(
                        child: Transform.rotate(
                          angle: 4.7,
                          child: Container(
                            margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black26.withOpacity(0.3),blurRadius: 5),
                              ],
                            ),
                            child: ShaderMask(
                                shaderCallback: (rect){
                                  return SweepGradient(
                                    colors: [WHITE, BLUE],
                                    center: Alignment.center,
                                    startAngle: 0.0,
                                    stops: [1-value,0],
                                    endAngle: 3.14 * 2,
                                  ).createShader(rect);
                                },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.height / 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: WHITE,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: WHITE,
                        ),
                        child: Container(

                          margin: EdgeInsets.all(MediaQuery.of(context).size.height < 600 ? 8 :15),
                          decoration: BoxDecoration(

                            shape: BoxShape.circle,
                            color: BLUE,
                          ),
                          child: Center(
                            child: resumeTime == 0
                                ?  getReady10sec == 0
                                    ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                t.mediumText(
                                    text : int.parse(list[currentIndex].time) > 60
                                        ? "00:00"
                                        : "00:${(int.parse(list[currentIndex].time) - completedExerciseTime) < 10 ? "0${(int.parse(list[currentIndex].time) - completedExerciseTime)}" : (int.parse(list[currentIndex].time) - completedExerciseTime)}",
                                    color: WHITE,
                                    size: MediaQuery.of(context).size.height < 600 ? MediaQuery.of(context).size.height < 450 ? 10 : 25 : 35
                                ),
                                t.boldText(
                                    text :MINUTES,
                                    color: WHITE,
                                    size: MediaQuery.of(context).size.height < 600 ? MediaQuery.of(context).size.height < 450 ? 5 : 10 : 14
                                )
                              ],
                            ) : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                t.mediumText(
                                    text : "${(int.parse(widget.intervalTime==null?"10":"${widget.intervalTime}") - completedExerciseTime)}",
                                    color: WHITE,
                                    size: 50
                                ),
                                t.boldText(
                                    text :SECONDS,
                                    color: WHITE,
                                    size: MediaQuery.of(context).size.height < 600 ? MediaQuery.of(context).size.height < 450 ? 5 : 10 : 14
                                )
                              ],
                            )
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                t.mediumText(
                                    text : "${resumeTime}",
                                    color: WHITE,
                                    size: 50
                                ),
                              ],
                            )
                          ),
                        ),
                      ),
                    ),
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(rotationController!),
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.height / 4,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: BLUE,
                            border: Border.all(color: WHITE, width: 2)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height < 600 ? 5 : 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: (){
                        if(mounted) {
                          setState(() {
                            currentIndex <= 0
                                ? 0
                                : currentIndex--;
                            completedExerciseTime =
                                int.parse(list[currentIndex].time);
                            value = 0.0;
                            isPlaying = true;
                            executedAnimationTime = 0.0;
                            completedExerciseTime = 0;
                            previousCompletedExerciseTime = 0;
                            getReady10sec = widget.intervalTime ?? 10;
                            //rotationController!.animateBack(0);
                            rotationController!.stop();
                            getReady10secTimer();
                            voiceAssistant!.speak(
                                GET_READY_NEXT_IS[LANGUAGE_TYPE]+"${list[currentIndex].name}");
                            rotationController!.forward();
                          });
                        }
                      },
                      child: Image.asset("assets/startExcercise/prev.png", height: MediaQuery.of(context).size.height < 600 ? 20 :30, width: 30,)),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          isPlaying = !isPlaying;
                          // if(isPlaying && rotationController!.isCompleted) {
                          //   initializeController();
                           // }
                        });

                        pauseOrPlay(isPlaying);

                        print("1->" + rotationController!.isCompleted.toString());
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height < 600 ? 40 : 50,
                      width: 180,
                      child: Stack(
                        children: [
                          Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: BLUE,
                                boxShadow: [
                                  BoxShadow(color: Colors.blue.withOpacity(0.4),blurRadius: 5),
                                ],
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          Center(
                            child: t.boldText(
                                text: isPlaying ? PAUSE : PLAY,
                                color: WHITE,
                                size: MediaQuery.of(context).size.height < 600 ? 14 : 17
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                      onTap: (){
                        if(mounted) {
                          setState(() {
                            isPlaying = true;
                            currentIndex < list.length - 1
                                ? currentIndex++
                                : currentIndex = 0;
                            completedExerciseTime =
                                int.parse(list[currentIndex].time);
                            value = 0.0;
                            executedAnimationTime = 0.0;
                            completedExerciseTime = 0;
                            previousCompletedExerciseTime = 0;
                            getReady10sec = widget.intervalTime ?? 10;
                            //rotationController!.animateBack(0);
                            rotationController!.stop();
                            getReady10secTimer();
                            voiceAssistant!.speak(
                                GET_READY_NEXT_IS[LANGUAGE_TYPE]+"${list[currentIndex].name}");
                            rotationController!.forward();
                          });

                        }
                      },
                      child: Image.asset("assets/startExcercise/next.png", height: MediaQuery.of(context).size.height < 600 ? 15 : 30, width: 30,))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height < 600 ? 10 : 25,),
              DISPLAY_ADS && banner != null ? AdWidget(ad: banner!,) : Container(),
            ],
          ),
        ),
      ],
    );
  }
  BannerAd? banner;

  voiceSetup() async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(Platform.isIOS ? 0.5 : 1.0);
    await flutterTts.setVolume(isVoiceGuidanceOn ? volumeValue : 0);
    await flutterTts.setPitch(1.0);
    if(mounted) {
      setState(() {
        voiceAssistant = VoiceAssistant(flutterTts);
      });
    }
    sayThreeTwoOne();
  }

  sayThreeTwoOne() {
    setState(() {
    threeTwoOneTimer = Timer(Duration(milliseconds: 700), () async{
      if(starting321 >= 1){
        //voiceAssistant.speak("${starting321.toString()}");
        Vibrate.vibrate().then((value){
          print("vibrated");
        }).catchError((e){
          print(e);
        });
        await Future.delayed(Duration(milliseconds: 500));
        if(mounted) {
          setState(() {
            starting321--;
          });
        }
        sayThreeTwoOne();
      }else{
        voiceAssistant!.speak(GET_READY_NEXT_IS[LANGUAGE_TYPE]+"${list[currentIndex].name}");
        rotationController!.forward();
      }
    });
    });
  }

  initializeController() async {

    try {
      if (mounted) {
        setState(() {
          voicePauseTimer.cancel();
        });
      }

      if (mounted) {
        setState(() {
          rotationController = AnimationController(duration: Duration(
              seconds: int.parse(list[currentIndex].time.toString())),
            vsync: this,);

          rotationController!.addListener(() {
            //print("$executedAnimationTime");
            if (rotationController!.isAnimating) {
              //print(executedAnimationTime  + rotationController.lastElapsedDuration.inSeconds);
              //print(executedAnimationTime + (rotationController.lastElapsedDuration.inMilliseconds/rotationController.duration.inMilliseconds));
              if (mounted) {
                setState(() {
                  value = executedAnimationTime +
                      (rotationController!.lastElapsedDuration!.inMilliseconds /
                          rotationController!.duration!.inMilliseconds);
                  completedExerciseTime =
                      (value * double.parse(list[currentIndex].time)).toInt();
                  //print(value);
                });
              }

              if (previousCompletedExerciseTime < completedExerciseTime ||
                  value == 0) {
                //print(completedExerciseTime);
                previousCompletedExerciseTime = completedExerciseTime;

                if(int.parse(list[currentIndex].time)~/2 == completedExerciseTime){
                  voiceAssistant!.speak(HALF_COMPLETED[LANGUAGE_TYPE]);

                }

                if ((int.parse(list[currentIndex].time) -
                    completedExerciseTime) < 4) {
                  loadAudio321();
                  // assetsAudioPlayer.open(
                  //   Audio("assets/audios/321.wav"),
                  //   volume: volume
                  // );
                  voiceAssistant!.speak(
                      (int.parse(list[currentIndex].time) -
                          completedExerciseTime)
                          .toString());
                }else{
                  // assetsAudioPlayer.open(
                  //   Audio("assets/audios/tickTick.wav"),
                  //   volume: volume
                  // );
                  loadAudioTickTick();
                }
              }
            } else if (rotationController!.isCompleted) {
              if (mounted) {
                progressClass!.addData(
                  calories: list[currentIndex].calories.toString(),
                  workOuts: "1",
                  seconds: list[currentIndex].time.toString(),
                  context: context,
                );
                setState(() {
                  if (currentIndex == list.length - 1) {
                    isPlaying = false;
                    print("Workout Completed");
                    voiceAssistant!.speak(WORKOUT_COMPLETED[LANGUAGE_TYPE]);
                  }
                  value = 1.0;
                  completedExerciseTime = int.parse(list[currentIndex].time);
                  //print(currentIndex.toString() + " -- " + list.length.toString());
                  if (currentIndex < list.length - 1) {
                    currentIndex++;
                    value = 0.0;
                    executedAnimationTime = 0.0;
                    completedExerciseTime = 0;
                    previousCompletedExerciseTime = 0;
                    getReady10sec = widget.intervalTime ?? 10;
                    getReady10secTimer();
                    voiceAssistant!.speak(
                        GET_READY_NEXT_IS[LANGUAGE_TYPE]+"${list[currentIndex].name}");
                    rotationController!.forward();
                  }else{
                    setState(() {
                      showDialog = true;
                    });
                  }
                });
              }
            }
          });
        });

        if (mounted) {
          await voiceAssistant!.speak( BEGIN[LANGUAGE_TYPE]+"${list[currentIndex].name}").then((
              value) {
            setState(() {
              voicePauseTimer = Timer(Duration(seconds: 1), () {
                rotationController!.forward();
              });
            });
          });
        }
      }
    }catch(e){
      print("Caught Error : "+e.toString());
    }
  }


  */
/*void createInterstitialAd(bool doRestart) {
    _interstitialAd ??= InterstitialAd(
      adUnitId: INTERSTITIAL_AD_ID,//"ca-app-pub-1534623013393777/2381290914",
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          Navigator.pop(context);
          _interstitialAd.show();
          //ad.dispose();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) async{
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          Navigator.pop(context);
          _interstitialAd = null;
          if(doRestart){
            Navigator.pop(context);
            await Future.delayed(Duration.zero);
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => StartExercise(widget.createList,0)),
            );
          }else{
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) async{
          print('${ad.runtimeType} closed.');
          ad.dispose();
          if(doRestart){
            Navigator.pop(context);
            await Future.delayed(Duration.zero);
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => StartExercise(widget.createList,0)),
            );
          }else{
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    )..load();
  }*/ /*



  getReady10secTimer() async{
    if(mounted) {
        rotationController = AnimationController(
          duration: Duration(seconds: getReady10sec), vsync: this,);
    }

    rotationController!.addListener(() {
      //print("$executedAnimationTime");
      if(rotationController!.isAnimating){
        //print(executedAnimationTime  + rotationController.lastElapsedDuration.inSeconds);
        //print(executedAnimationTime + (rotationController.lastElapsedDuration.inMilliseconds/rotationController.duration.inMilliseconds));
        if(mounted) {
          setState(() {
            value = executedAnimationTime +
                (rotationController!.lastElapsedDuration!.inMilliseconds /
                    rotationController!.duration!.inMilliseconds);
            completedExerciseTime = (value * double.parse(widget.intervalTime==null?"10":"${widget.intervalTime}")).toInt();
          });
        }

        //print(previousCompletedExerciseTime < completedExerciseTime);

        if(previousCompletedExerciseTime < completedExerciseTime || value == 0) {
          previousCompletedExerciseTime = completedExerciseTime;
          if((int.parse(widget.intervalTime==null?"10":"${widget.intervalTime}") - completedExerciseTime) < 4){
            print((int.parse(widget.intervalTime==null?"10":"${widget.intervalTime}") - completedExerciseTime).toString());
            voiceAssistant!.speak((int.parse(widget.intervalTime==null?"10":"${widget.intervalTime}") - completedExerciseTime).toString());
            // assetsAudioPlayer.open(
            //   Audio("assets/audios/321.wav",),
            //   volume: volume
            // );
            loadAudio321();
          }else{
            // assetsAudioPlayer.open(
            //   Audio("assets/audios/tickTick.wav"),
            //   volume: volume
            // );
            loadAudioTickTick();
          }
        }

      }else if(rotationController!.isCompleted){
        if(mounted) {
          setState(() {
            getReady10sec = 0;
            previousCompletedExerciseTime = 0;
            completedExerciseTime = 0;
            executedAnimationTime = 0.0;
            value = 0.0;
            initializeController();
          });
        }
      }
    });
  }

  resumeExercise() async{

    if(resumeTime > 0){
      if(resumeTime == 3){
        voiceAssistant!.speak(RESUMING[LANGUAGE_TYPE]);
        await Future.delayed(Duration(seconds: 1));
      }
      voiceAssistant!.speak((resumeTime).toString());
    }

    resumeTimer = Timer(Duration(seconds: 1), () async{
      if(mounted) {
        setState(() {
          if (resumeTime > 0) {
            resumeTime--;
          }
        });
        if (resumeTime > 0) {
          print(resumeTime);
          resumeExercise();
        }
        else {
          voiceAssistant!.speak(START_SMALL[LANGUAGE_TYPE]);
          await Future.delayed(Duration(seconds: 1));
          if (getReady10sec == 0) {
            if (isPlaying && value > 0.0) {
              if(mounted) {
                setState(() {
                  executedAnimationTime = value;
                  completedExerciseTime =
                      (value * double.parse(list[currentIndex].time))
                          .toInt();
                  print("completedExerciseTime = ${(value * double.parse(
                      list[currentIndex].time)).toInt()}");
                });
                rotationController!.forward();
              }
            } else if (isPlaying) {
              rotationController!.forward();
            }
          }
          else {
            if (isPlaying && value > 0.0) {
              if(mounted) {
                setState(() {
                  executedAnimationTime = value;
                  completedExerciseTime =
                      (value * double.parse(list[currentIndex].time))
                          .toInt();
                  print("completedExerciseTime = ${(value * double.parse(
                      list[currentIndex].time)).toInt()}");
                });
                rotationController!.forward();
              }
            } else if (isPlaying) {
              rotationController!.forward();
            }
          }
        }
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;

  void pauseOrPlay(bool isPlaying) {
    if (currentIndex == list.length - 1 && rotationController!.isCompleted) {
      print("reached last");
      if(mounted) {
        setState(() {
          currentIndex++;
          value = 0.0;
          currentIndex = 0;
          executedAnimationTime = 0.0;
          completedExerciseTime = 0;
          previousCompletedExerciseTime = 0;
          getReady10sec = widget.intervalTime ?? 10;
          getReady10secTimer();
          voiceAssistant!.speak(
              GET_READY_NEXT_IS[LANGUAGE_TYPE]+"${list[currentIndex].name}");
          rotationController!.forward();
        });
      }
    } else if (getReady10sec == 0) {
      if (isPlaying) {
        if(mounted) {
          setState(() {
            resumeTime = 3;
          });
          resumeExercise();
        }
      }
      else if (!isPlaying) {
        resumeTimer.cancel();
        rotationController!.stop();
      }
    }
    else {
      if (isPlaying) {
        if(mounted) {
          setState(() {
            resumeTime = 3;
          });
          resumeExercise();
        }
      } else if (!isPlaying) {
        rotationController!.stop();
        resumeTimer.cancel();
      }
    }
  }

  loadAudio321() async{
    await player.setAsset('assets/audios/321.wav').then((value) async{
      print("duration : ${value!.inMilliseconds}");
      await player.setVolume(volume);
      player.play();
    });
  }

  loadAudioTickTick() async{
    await player.setAsset('assets/audios/tickTick.wav').then((value) async{
      print("duration : ${value!.inMilliseconds}");
      await player.setVolume(volume);
      player.play();
    });
  }

}
*/

import 'dart:async';
import 'dart:io';

//import 'package:assets_audio_player/assets_audio_player.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/CustomWidgets/VoiceAssistant.dart';
import 'package:exercise_app/LocalDatabase/ProgressClass.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseMp4.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseYoutube.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AllText.dart';
import '../Themes.dart';
import '../main.dart';

class StartExercise extends StatefulWidget {
  List? createList;
  int? intervalTime;
  StartExercise({this.createList, this.intervalTime});

  @override
  _StartExerciseState createState() => _StartExerciseState();
}

class _StartExerciseState extends State<StartExercise>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? rotationController;
  double value = 0.0;
  bool isPlaying = true;
  int minutes = 00;
  int seconds = 00;
  int starting321 = 3;
  FlutterTts flutterTts = FlutterTts();
  List list = [];
  int currentIndex = 0;
  int completedExerciseTime = 0;
  int previousCompletedExerciseTime = 0;
  double executedAnimationTime = 0.0;
  int getReady10sec = 0;
  int resumeTime = 0;
  Timer threeTwoOneTimer = Timer(Duration(seconds: 1), () {});
  Timer resumeTimer = Timer(Duration(seconds: 1), () {});
  Timer getReady10secTimerAction = Timer(Duration(seconds: 1), () {});
  Timer voicePauseTimer = Timer(Duration(seconds: 1), () {});
  ProgressClass progressClass = ProgressClass();
  bool isVoiceGuidanceOn = true;
  bool isTickTickVolumeOn = true;
  //AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  double volumeValue = 1.0;
  double volume = 1.0;
  bool isHalfwayOn = true;
  final player = AudioPlayer();
  bool showDialog = false;
  // InterstitialAd _interstitialAd;

  BannerAd? banner;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        starting321 = value.getInt("countdown") ?? 3;
      });
      createInterstitialAd();
      startCountDownAndInitializeValues();
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
    });
    super.initState();
  }

  startCountDownAndInitializeValues() {
    getReady10sec = widget.intervalTime ?? 10;
    print(getReady10sec);
    voiceSetup();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        isVoiceGuidanceOn = value.getBool("isVoiceGuidanceOn") ?? true;
        isHalfwayOn = value.getBool("isHalfwayPromptOn") ?? true;
        volumeValue = volume = value.getDouble("volume") ?? 1;
      });
    });
    list.addAll(widget.createList!);
    // print(list[currentIndex].image);
    getReady10secTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    threeTwoOneTimer.cancel();
    player.stop();
    player.dispose();
    //assetsAudioPlayer.stop();
    //audioCache.clear('321.wav');
    //audioCache.clear('tickTick.wav');
    print(rotationController!.status);
    rotationController!.dispose();
    rotationController!.removeListener(() {});
    print(rotationController!.status);
    voiceAssistant.stop();
    resumeTimer.cancel();
    voicePauseTimer.cancel();
    currentIndex = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return starting321 >= 1
        ? SafeArea(
            child: Scaffold(
              body: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  color: Colors.black87,
                  child: Center(
                    child: t.mediumText(
                      text: starting321.toString(),
                      size: ipad ? 200 : 120,
                      color: WHITE,
                    ),
                  )),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  body(),
                  showDialog
                      ? InkWell(
                          onTap: () {
                            // setState(() {
                            //   showDialog = false;
                            // });
                          },
                          child: Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            color: Colors.black54,
                            child: myCustomDialog(
                              title: HURRAY,
                              msg:
                                  YOU_HAVE_SUCCESSFULLY_COMPLETED_YOUR_WORKOUT_WOULD_YOU_LIKE_TO_REPEAT_IT,
                              btnNoText: ENOUGH_FOR_TODAY,
                              btnYesText: YES_AM_READY,
                              onPressedBtnYes: () async {
                                setState(() {
                                  showDialog = false;
                                });
                                if (DISPLAY_ADS1) {
                                  customDialogues.progressDialog(
                                      context: context,
                                      title: SHOWING_AD[LANGUAGE_TYPE]);
                                  showInterstitialAd1(true);
                                  // createInterstitialAd(true);
                                } else {
                                  Navigator.pop(context);
                                  await Future.delayed(Duration.zero);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StartExercise(
                                              createList: widget.createList,
                                            )),
                                  );
                                }
                              },
                              onPressedButtonNo: () {
                                setState(() {
                                  showDialog = false;
                                });
                                if (DISPLAY_ADS1) {
                                  customDialogues.progressDialog(
                                      context: context,
                                      title: SHOWING_AD[LANGUAGE_TYPE]);
                                  showInterstitialAd1(false);
                                  // createInterstitialAd(false);
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
  }

  body() {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Column(
        children: [
          Container(
            color: WHITE,
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.height < 600 ? 8 : 16),
            child: Row(
              children: List.generate(list.length, (index) {
                return Expanded(
                  child: currentIndex == index && getReady10sec == 0
                      ? LinearProgressIndicator(
                          backgroundColor: LIGHT_GREY_SCREEN_BACKGROUND,
                          minHeight:
                              MediaQuery.of(context).size.height < 600 ? 4 : 6,
                          valueColor: AlwaysStoppedAnimation(PRIMARY),
                          value: value,
                        )
                      : Container(
                          height:
                              MediaQuery.of(context).size.height < 600 ? 4 : 6,
                          margin: EdgeInsets.all(1),
                          color: currentIndex > index
                              ? PRIMARY
                              : LIGHT_GREY_SCREEN_BACKGROUND,
                        ),
                );
              }),
            ),
          ),
          Container(
              width: size.width,
              height: 320,
              child: Stack(children: [
                SizedBox(height: 320),
                Positioned(
                  bottom: 0,
                  child: CachedNetworkImage(
                      fit: BoxFit.fitHeight,
                      height: 280,
                      width: size.width,
                      imageUrl:
                          IMAGE_URL_MENU_ITEMLive + list[currentIndex].image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(),
                      errorWidget: (context, url, error) =>
                          placeHolder(borderRadius: 10)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              t.boldText(
                                  text: getReady10sec == 0
                                      ? "${list[currentIndex + 1 < list.length ? currentIndex + 1 : 0].name}"
                                      : "${list[currentIndex < list.length ? currentIndex : 0].name}",
                                  color: BLACK,
                                  size: 18),
                              t.regularText(
                                  text: 'Next',
                                  color: LIGHT_GREY_TEXT,
                                  size: 15),
                            ]),
                        IconButton(
                          onPressed: () {},
                          icon: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: LIGHT_GREY_TEXT,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Icon(
                              Icons.settings,
                              color: BLACK,
                              size: 18,
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                ),
              ])),
          Spacer(),
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                  width: size.width,
                  padding: EdgeInsets.all(16),
                  color: BLACK,
                  child: Column(children: [
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () async {
                        pauseOrPlay(false);
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PLAY_YOUTUBE_VIDEOS
                                    ? HowToExerciseYoutube(
                                        list[currentIndex].id.toString())
                                    : HowToExerciseMp4(list[currentIndex].id)));
                        pauseOrPlay(isPlaying ? true : false);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            t.boldText(
                                text: getReady10sec == 0
                                    ? list[currentIndex].name
                                    : GET_READY[LANGUAGE_TYPE],
                                color: WHITE,
                                size: 18),
                            SizedBox(width: 10),
                            Icon(Icons.question_mark,
                                color: LIGHT_GREY_TEXT, size: 18)
                          ]),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                            child: resumeTime == 0
                                ? getReady10sec == 0
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          t.boldText(
                                              text: int.parse(list[currentIndex]
                                                          .time) >
                                                      60
                                                  ? "00:00"
                                                  : "00:${(int.parse(list[currentIndex].time) - completedExerciseTime) < 10 ? "0${(int.parse(list[currentIndex].time) - completedExerciseTime)}" : (int.parse(list[currentIndex].time) - completedExerciseTime)}",
                                              color: WHITE,
                                              size: 60),
                                          t.boldText(
                                              text: MINUTES,
                                              color: WHITE,
                                              size: 15)
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          t.boldText(
                                              text:
                                                  "${(int.parse(widget.intervalTime == null ? "10" : "${widget.intervalTime}") - completedExerciseTime)}",
                                              color: WHITE,
                                              size: 50),
                                          t.boldText(
                                              text: SECONDS,
                                              color: WHITE,
                                              size: 15)
                                        ],
                                      )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      t.mediumText(
                                          text: "${resumeTime}",
                                          color: WHITE,
                                          size: 50),
                                    ],
                                  ))),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.all(5),
                        color: BLACK,
                        child: Icon(Icons.ac_unit, color: BLACK),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              isPlaying = !isPlaying;
                            });

                            pauseOrPlay(isPlaying);

                            print("1->" +
                                rotationController!.isCompleted.toString());
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: PRIMARY,
                          ),
                          child: Center(
                            child: isPlaying
                                ? Icon(Icons.stop, size: 50, color: BLACK)
                                : Icon(Icons.check, size: 50, color: BLACK),
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              isPlaying = true;
                              currentIndex < list.length - 1
                                  ? currentIndex++
                                  : currentIndex = 0;
                              completedExerciseTime =
                                  int.parse(list[currentIndex].time);
                              value = 0.0;
                              executedAnimationTime = 0.0;
                              completedExerciseTime = 0;
                              previousCompletedExerciseTime = 0;
                              getReady10sec = widget.intervalTime ?? 10;
                              //rotationController.animateBack(0);
                              rotationController!.stop();
                              getReady10secTimer();
                              voiceAssistant.speak(
                                  GET_READY_NEXT_IS[LANGUAGE_TYPE] +
                                      "${list[currentIndex].name}");
                              rotationController!.forward();
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: WHITE.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Icon(Icons.play_arrow_sharp,
                                size: 40, color: WHITE),
                          ),
                        ),
                      ),
                    ]),
                  ]))),
          DISPLAY_ADS && banner != null
              ? AdWidget(
                  ad: banner!,
                )
              : Container(),
        ],
      ),
      Positioned(
          left: 16,
          top: 50,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LIGHT_GREY_TEXT,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Icon(
                Icons.close,
                color: BLACK,
                size: 18,
              ),
            ),
          ))
    ]);
  }

  voiceSetup() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(Platform.isIOS ? 0.5 : 0.5);
    await flutterTts.setVolume(isVoiceGuidanceOn ? volumeValue : 0);
    await flutterTts.setPitch(1.0);
    if (mounted) {
      setState(() {
        voiceAssistant = VoiceAssistant(flutterTts);
      });
    }
    sayThreeTwoOne();
  }

  sayThreeTwoOne() {
    setState(() {
      threeTwoOneTimer = Timer(Duration(milliseconds: 700), () async {
        if (starting321 >= 1) {
          //voiceAssistant.speak("${starting321.toString()}");
          Vibrate.vibrate().then((value) {
            print("vibrated");
          }).catchError((e) {
            print(e);
          });
          await Future.delayed(Duration(milliseconds: 500));
          if (mounted) {
            setState(() {
              starting321--;
            });
          }
          sayThreeTwoOne();
        } else {
          voiceAssistant.speak(
              GET_READY_NEXT_IS[LANGUAGE_TYPE] + "${list[currentIndex].name}");
          rotationController!.forward();
        }
      });
    });
  }

  initializeController() async {
    try {
      if (mounted) {
        setState(() {
          voicePauseTimer.cancel();
        });
      }

      if (mounted) {
        setState(() {
          rotationController = AnimationController(
            duration: Duration(
                seconds: int.parse(list[currentIndex].time.toString())),
            vsync: this,
          );

          rotationController!.addListener(() {
            //print("$executedAnimationTime");
            if (rotationController!.isAnimating) {
              //print(executedAnimationTime  + rotationController.lastElapsedDuration.inSeconds);
              //print(executedAnimationTime + (rotationController.lastElapsedDuration.inMilliseconds/rotationController.duration.inMilliseconds));
              if (mounted) {
                setState(() {
                  value = executedAnimationTime +
                      (rotationController!.lastElapsedDuration!.inMilliseconds /
                          rotationController!.duration!.inMilliseconds);
                  completedExerciseTime =
                      (value * double.parse(list[currentIndex].time)).toInt();
                  //print(value);
                });
              }

              if (previousCompletedExerciseTime < completedExerciseTime ||
                  value == 0) {
                //print(completedExerciseTime);
                previousCompletedExerciseTime = completedExerciseTime;

                if (int.parse(list[currentIndex].time) ~/ 2 ==
                    completedExerciseTime) {
                  voiceAssistant.speak(HALF_COMPLETED[LANGUAGE_TYPE]);
                }

                if ((int.parse(list[currentIndex].time) -
                        completedExerciseTime) <
                    4) {
                  // loadAudio321();
                  // assetsAudioPlayer.open(
                  //   Audio("assets/audios/321.wav"),
                  //   volume: volume
                  // );
                  voiceAssistant.speak((int.parse(list[currentIndex].time) -
                          completedExerciseTime)
                      .toString());
                } else {
                  // assetsAudioPlayer.open(
                  //   Audio("assets/audios/tickTick.wav"),
                  //   volume: volume
                  // );
                  loadAudioTickTick();
                }
              }
            } else if (rotationController!.isCompleted) {
              if (mounted) {
                SharedPreferences.getInstance().then((value) {
                  List<String> dates = value.getStringList("dates") ?? [];
                  DateTime dateTime = DateTime.now();
                  String date = dateTime.toString().substring(0, 10);
                  if (!dates.contains(date)) {
                    dates.add(date);
                    value.setStringList("dates", dates);
                  }
                });
                progressClass.addData(
                  calories: list[currentIndex].calories.toString(),
                  workOuts: "1",
                  seconds: list[currentIndex].time.toString(),
                  context: context,
                );
                print("here");
                print("${list[currentIndex].time.toString()}");
                print("${list[currentIndex].calories.toString()}");
                setState(() {
                  if (currentIndex == list.length - 1) {
                    isPlaying = false;
                    print("Workout Completed");
                    voiceAssistant.speak(WORKOUT_COMPLETED[LANGUAGE_TYPE]);
                  }
                  value = 1.0;
                  completedExerciseTime = int.parse(list[currentIndex].time);
                  //print(currentIndex.toString() + " -- " + list.length.toString());
                  if (currentIndex < list.length - 1) {
                    currentIndex++;
                    value = 0.0;
                    executedAnimationTime = 0.0;
                    completedExerciseTime = 0;
                    previousCompletedExerciseTime = 0;
                    getReady10sec = widget.intervalTime ?? 10;
                    getReady10secTimer();
                    voiceAssistant.speak(GET_READY_NEXT_IS[LANGUAGE_TYPE] +
                        "${list[currentIndex].name}");
                    rotationController!.forward();
                  } else {
                    setState(() {
                      showDialog = true;
                    });
                  }
                });
              }
            }
          });
        });

        if (mounted) {
          await voiceAssistant
              .speak(BEGIN[LANGUAGE_TYPE] + "${list[currentIndex].name}")
              .then((value) {
            setState(() {
              voicePauseTimer = Timer(Duration(seconds: 1), () {
                rotationController!.forward();
              });
            });
          });
        }
      }
    } catch (e) {
      print("Caught Error : " + e.toString());
    }
  }

  /*void createInterstitialAd(bool doRestart) {
    _interstitialAd ??= InterstitialAd(
      adUnitId: INTERSTITIAL_AD_ID,//"ca-app-pub-1534623013393777/2381290914",
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          Navigator.pop(context);
          _interstitialAd.show();
          //ad.dispose();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) async{
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          Navigator.pop(context);
          _interstitialAd = null;
          if(doRestart){
            Navigator.pop(context);
            await Future.delayed(Duration.zero);
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => StartExercise(createList: widget.createList,)),
            );
          }else{
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) async{
          print('${ad.runtimeType} closed.');
          ad.dispose();
          if(doRestart){
            Navigator.pop(context);
            await Future.delayed(Duration.zero);
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => StartExercise(createList: widget.createList,)),
            );
          }else{
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    )..load();
  }*/

  getReady10secTimer() async {
    if (mounted) {
      rotationController = AnimationController(
        duration: Duration(seconds: getReady10sec),
        vsync: this,
      );
    }

    rotationController!.addListener(() {
      //print("$executedAnimationTime");
      if (rotationController!.isAnimating) {
        //print(executedAnimationTime  + rotationController!.lastElapsedDuration.inSeconds);
        //print(executedAnimationTime + (rotationController.lastElapsedDuration.inMilliseconds/rotationController.duration.inMilliseconds));
        if (mounted) {
          setState(() {
            value = executedAnimationTime +
                (rotationController!.lastElapsedDuration!.inMilliseconds /
                    rotationController!.duration!.inMilliseconds);
            completedExerciseTime = (value *
                    double.parse(widget.intervalTime == null
                        ? "10"
                        : "${widget.intervalTime}"))
                .toInt();
          });
        }

        //print(previousCompletedExerciseTime < completedExerciseTime);

        if (previousCompletedExerciseTime < completedExerciseTime ||
            value == 0) {
          previousCompletedExerciseTime = completedExerciseTime;
          if ((int.parse(widget.intervalTime == null
                      ? "10"
                      : "${widget.intervalTime}") -
                  completedExerciseTime) <
              4) {
            print((int.parse(widget.intervalTime == null
                        ? "10"
                        : "${widget.intervalTime}") -
                    completedExerciseTime)
                .toString());
            voiceAssistant.speak((int.parse(widget.intervalTime == null
                        ? "10"
                        : "${widget.intervalTime}") -
                    completedExerciseTime)
                .toString());
            // assetsAudioPlayer.open(
            //   Audio("assets/audios/321.wav",),
            //   volume: volume
            // );
            // loadAudio321();
          } else {
            // assetsAudioPlayer.open(
            //   Audio("assets/audios/tickTick.wav"),
            //   volume: volume
            // );
            loadAudioTickTick();
          }
        }
      } else if (rotationController!.isCompleted) {
        if (mounted) {
          setState(() {
            getReady10sec = 0;
            previousCompletedExerciseTime = 0;
            completedExerciseTime = 0;
            executedAnimationTime = 0.0;
            value = 0.0;
            initializeController();
          });
        }
      }
    });
  }

  resumeExercise() async {
    if (resumeTime > 0) {
      if (resumeTime == 3) {
        voiceAssistant.speak(RESUMING[LANGUAGE_TYPE]);
        await Future.delayed(Duration(seconds: 1));
      }
      voiceAssistant.speak((resumeTime).toString());
    }

    resumeTimer = Timer(Duration(seconds: 1), () async {
      if (mounted) {
        setState(() {
          if (resumeTime > 0) {
            resumeTime--;
          }
        });
        if (resumeTime > 0) {
          print(resumeTime);
          resumeExercise();
        } else {
          voiceAssistant.speak(START_SMALL[LANGUAGE_TYPE]);
          await Future.delayed(Duration(seconds: 1));
          if (getReady10sec == 0) {
            if (isPlaying && value > 0.0) {
              if (mounted) {
                setState(() {
                  executedAnimationTime = value;
                  completedExerciseTime =
                      (value * double.parse(list[currentIndex].time)).toInt();
                  print(
                      "completedExerciseTime = ${(value * double.parse(list[currentIndex].time)).toInt()}");
                });
                rotationController!.forward();
              }
            } else if (isPlaying) {
              rotationController!.forward();
            }
          } else {
            if (isPlaying && value > 0.0) {
              if (mounted) {
                setState(() {
                  executedAnimationTime = value;
                  completedExerciseTime =
                      (value * double.parse(list[currentIndex].time)).toInt();
                  print(
                      "completedExerciseTime = ${(value * double.parse(list[currentIndex].time)).toInt()}");
                });
                rotationController!.forward();
              }
            } else if (isPlaying) {
              rotationController!.forward();
            }
          }
        }
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;

  void pauseOrPlay(bool isPlaying) {
    if (currentIndex == list.length - 1 && rotationController!.isCompleted) {
      print("reached last");
      if (mounted) {
        setState(() {
          currentIndex++;
          value = 0.0;
          currentIndex = 0;
          executedAnimationTime = 0.0;
          completedExerciseTime = 0;
          previousCompletedExerciseTime = 0;
          getReady10sec = widget.intervalTime ?? 10;
          getReady10secTimer();
          voiceAssistant.speak(
              GET_READY_NEXT_IS[LANGUAGE_TYPE] + "${list[currentIndex].name}");
          rotationController!.forward();
        });
      }
    } else if (getReady10sec == 0) {
      if (isPlaying) {
        if (mounted) {
          setState(() {
            resumeTime = 3;
          });
          resumeExercise();
        }
      } else if (!isPlaying) {
        resumeTimer.cancel();
        rotationController!.stop();
      }
    } else {
      if (isPlaying) {
        if (mounted) {
          setState(() {
            resumeTime = 3;
          });
          resumeExercise();
        }
      } else if (!isPlaying) {
        rotationController!.stop();
        resumeTimer.cancel();
      }
    }
  }

  loadAudio321() async {
    await player.setAsset('assets/audios/321.wav').then((value) async {
      print("duration : ${value!.inMilliseconds}");
      await player.setVolume(volume);
      player.play();
    });
  }

  loadAudioTickTick() async {
    await player.setAsset('assets/audios/tickTick.wav').then((value) async {
      print("duration : ${value!.inMilliseconds}");
      await player.setVolume(volume);
      player.play();
    });
  }

  void showInterstitialAd1(bool st) {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) async {
        // print('$ad onAdDismissedFullScreenContent.');
        // ad.dispose();
        print('${ad.runtimeType} closed.');
        ad.dispose();
        if (st) {
          Navigator.pop(context);
          await Future.delayed(Duration.zero);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StartExercise(
                      createList: widget.createList,
                    )),
          );
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      onAdFailedToShowFullScreenContent:
          (InterstitialAd ad, AdError error) async {
        print('${ad.runtimeType} failed to load: $error.');
        await Future.delayed(Duration(seconds: 1));
        print('${ad.runtimeType} failed to load: $error.');
        ad.dispose();
        Navigator.pop(context);
        interstitialAd = null;
        if (st) {
          Navigator.pop(context);
          await Future.delayed(Duration.zero);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StartExercise(
                      createList: widget.createList,
                    )),
          );
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }
}

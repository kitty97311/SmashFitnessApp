// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/CustomWidgets/CustomSettingsList.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutCreateClass.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutsClass.dart';
import 'package:exercise_app/Modals/AllWorkoutsClass.dart';
import 'package:exercise_app/Screens/SplashScreen.dart';
import 'package:exercise_app/Themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:exercise_app/notificationHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'CustomWidgets/CustomTextWidget.dart';
import 'CustomWidgets/VoiceAssistant.dart';
import 'LocalDatabase/ProgressClass.dart';
import 'LocalDatabase/HabitClass.dart';
import 'LocalDatabase/TrackerClass.dart';

CustomTextWidget customTextWidget = CustomTextWidget(), t = CustomTextWidget();
CustomDialogues customDialogues = CustomDialogues();
VoiceAssistant voiceAssistant = voiceAssistant;
CustomSettingsListTile customSettingsListTile = CustomSettingsListTile(),
    lt = CustomSettingsListTile();
//CustomAds customAds = CustomAds();
const String SERVER_ADDRESSLive = "https://app.smash.com";
// const String SERVER_ADDRESSLive = "https://demo.freaktemplate.com/fitness";
const String IMAGE_ADDRESS_HOMELive =
    "https://app.smash.com/storage/app/public/images/menu_cat_icon/";
const String IMAGE_URL_MENU_ITEMLive =
    "https://app.smash.com/storage/app/public/images/menu_item_icon/";
const String IMAGE_UPLOAD_ITEMLive =
    "https://app.smash.com/storage/app/public/images/upload/";
const String IMAGE_SUPPLEMENT_ITEMLive =
    "https://app.smash.com/storage/app/public/images/supplement/";
const String IMAGE_HOME_SECTIONLive =
    "https://app.smash.com/storage/app/public/images/sub_smash/";
const String IMAGE_SUBSMASHPLUS_SECTIONLive =
    "https://app.smash.com/storage/app/public/images/sub_smashplus/";
const String IMAGE_WORKOUT_SECTIONLive =
    "https://app.smash.com/storage/app/public/images/workout/";

NotificationHelper notificationHelper = NotificationHelper();
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
const SELECT_WORKOUTS_LIMIT = 60;
double HEIGHT = 800;
double WIDTH = 800;

bool DISPLAY_ADS = false;
bool DISPLAY_ADS1 = false;
bool PLAY_YOUTUBE_VIDEOS = true;
bool ipad = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (Platform.isAndroid) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: BLACK, statusBarIconBrightness: Brightness.light));
  MobileAds.instance.initialize();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  print('${appDocumentDir}');
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ProgressClassAdapter());
  Hive.registerAdapter(HabitClassAdapter());
  Hive.registerAdapter(TrackerClassAdapter());
  Hive
    ..registerAdapter(CreateAdapter())
    ..registerAdapter(WorkOutAdapter());
  Hive.registerAdapter(CustomWorkoutCreateClassAdapter());
  tz.initializeTimeZones();
  NotificationHelper().initialize();
  workoutBox = await Hive.openBox<WorkOut>("custom workOut Box");
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      Locale("en", "US"),
      Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      Locale('ar', 'AE'),
    ],
    //locale: Locale('ar', 'AE'),
  ));
}

String? getBannerAdUnitId() {
  return BANNER;
}

String? getInterstitialAdUnitId() {
  return INTERSTITIAL;
}

void createInterstitialAd() {
  InterstitialAd.load(
      adUnitId: getInterstitialAdUnitId()!,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('LINE NO ${ad.responseInfo!.responseExtras} loaded');
          interstitialAd = ad;
          numInterstitialLoadAttempts = 0;
          interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          numInterstitialLoadAttempts += 1;
          interstitialAd = null;
          if (numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ));
}

void showInterstitialAd() {
  if (interstitialAd == null) {
    print('Warning: attempt to show interstitial before loaded.');
    return;
  }
  interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) =>
        print('ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print('$ad onAdDismissedFullScreenContent.');
      ad.dispose();
      createInterstitialAd();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
      createInterstitialAd();
    },
  );
  interstitialAd!.show();
  interstitialAd = null;
}

final AdRequest request = const AdRequest(
  keywords: <String>['foo', 'bar'],
  contentUrl: 'http://foo.com/bar.html',
  nonPersonalizedAds: true,
);

InterstitialAd? interstitialAd;
int numInterstitialLoadAttempts = 0;
int maxFailedLoadAttempts = 3;

String BANNER = "ca-app-pub-3940256099942544/6300978111";
String INTERSTITIAL = "ca-app-pub-3940256099942544/1033173712";

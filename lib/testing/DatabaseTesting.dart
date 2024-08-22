
import 'package:exercise_app/LocalDatabase/ProgressClass.dart';
import 'package:exercise_app/main.dart';
//import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DatabaseTesting extends StatefulWidget {

  int x;

  DatabaseTesting(this.x);

  @override
  _DatabaseTestingState createState() => _DatabaseTestingState();
}

class _DatabaseTestingState extends State<DatabaseTesting> {

  ProgressClass? progressClass;
 // final assetsAudioPlayer = AssetsAudioPlayer();
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool _rewardedReady = false;


  @override
  void initState() {
    // TODO: implement initState
    print(widget.x);
    super.initState();
    //for(int i=0; i<1000; i++) {
    //   createInterstitialAd();
    //}
    //_loadInterstitialAd();
    //faceBookInterstitalAd();
  }

  // void createInterstitialAd() {
  //   _interstitialAd ??= InterstitialAd(
  //     adUnitId: "ca-app-pub-1534623013393777/2381290914",
  //     request: AdRequest(),
  //     listener: AdListener(
  //       onAdLoaded: (Ad ad) {
  //         print('${ad.runtimeType} loaded.');
  //         _interstitialAd.show();
  //         //ad.dispose();
  //       },
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         print('${ad.runtimeType} failed to load: $error.');
  //         ad.dispose();
  //         _interstitialAd = null;
  //         createInterstitialAd();
  //       },
  //       onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
  //       onAdClosed: (Ad ad) {
  //         print('${ad.runtimeType} closed.');
  //         ad.dispose();
  //         createInterstitialAd();
  //       },
  //       onApplicationExit: (Ad ad) =>
  //           print('${ad.runtimeType} onApplicationExit.'),
  //     ),
  //   )..load();
  // }
  //
  // void createRewardedAd() {
  //   _rewardedAd ??= RewardedAd(
  //     adUnitId: "ca-app-pub-7803172892594923/4898062092",
  //     request: AdRequest(),
  //     listener: AdListener(
  //         onAdLoaded: (Ad ad) {
  //           print('${ad.runtimeType} loaded.');
  //           _rewardedReady = true;
  //           _rewardedAd.show();
  //         },
  //         onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //           print('${ad.runtimeType} failed to load: $error');
  //           ad.dispose();
  //           _rewardedAd = null;
  //           createRewardedAd();
  //         },
  //         onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
  //         onAdClosed: (Ad ad) {
  //           print('${ad.runtimeType} closed.');
  //           ad.dispose();
  //           createRewardedAd();
  //         },
  //         onApplicationExit: (Ad ad) =>
  //             print('${ad.runtimeType} onApplicationExit.'),
  //         onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
  //           print(
  //             '$RewardedAd with reward $RewardItem(${reward.amount}, ${reward.type})',
  //           );
  //         }),
  //   )..load();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(0, (index){
          return  Container(
            // child: customAds.nativeAds(id: 0),
          );
        }),
      ),
    );
  }


  faceBookInterstitalAd() {
    // FacebookInterstitialAd.loadInterstitialAd(
    //   placementId: "843043572952180_883336532256217",
    //   listener: (result, value) {
    //     if (result == InterstitialAdResult.LOADED) {
    //       FacebookInterstitialAd.showInterstitialAd(delay: 1000);
    //       //FacebookInterstitialAd.
    //     }else{
    //       print("ERROR : ");
    //     }
    //   },
    // ).onError((error, stackTrace){
    //   print("ERROR : $error");
    //   return;
    // });
  }

  void _loadInterstitialAd() {
    // FacebookInterstitialAd.loadInterstitialAd(
    //   placementId:
    //   "843043572952180_883336532256217",// YOUR_PLACEMENT_ID
    //   listener: (result, value) {
    //     print(">> FAN > Interstitial Ad: $result --> $value");
    //     if (result == InterstitialAdResult.LOADED)
    //       //_isInterstitialAdLoaded = true;
    //
    //       FacebookInterstitialAd.showInterstitialAd();
    //
    //     /// Once an Interstitial Ad has been dismissed and becomes invalidated,
    //     /// load a fresh Ad by calling this function.
    //     if (result == InterstitialAdResult.DISMISSED &&
    //         value["invalidated"] == true) {
    //       //_isInterstitialAdLoaded = false;
    //       //_loadInterstitialAd();
    //     }
    //   },
    // );
  }

}
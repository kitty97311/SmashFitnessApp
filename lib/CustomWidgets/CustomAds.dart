/*
//import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_admob/flutter_native_admob.dart';
// import 'package:flutter_native_admob/native_admob_controller.dart';
// import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Themes.dart';
import '../main.dart';
class CustomAds{


// FacebookAudienceNetwork.init(
//        testingId: "4677e125-82ae-4307-8a7d-8fa3954494ef", //optional
//     );
//put this code in init state of calling class
  BannerAd? banner;

  //final _nativeAdController = NativeAdmobController();
  final String ADMOB_ID = "ca-app-pub-1534623013393777/8175572876";
  final String FACEBOOK_AD_ID = "727786934549239_727793487881917";
  String BANNERIOS = "ca-app-pub-3940256099942544/6300978111";
  String INTERSTITIALIOS = "ca-app-pub-3940256099942544/1033173712";



  Widget nativeAds({int? id}) {


    // BannerAd bannerAd = BannerAd(
    //   adUnitId: "ca-app-pub-7803172892594923/8910648660",
    //   size: AdSize.banner,
    //   request: AdRequest(),
    //   listener: AdListener(),
    // );

    if (id == 0) {

      return Container(
        height: 70,
        //color: BLUE.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
          */
/*child: NativeAdmob(
            // Your ad unit id
            adUnitID: NATIVE_AD_ID,//"ca-app-pub-1534623013393777/8175572876",
            numberAds: 5,
            controller: nativeAdController,
            type: NativeAdmobType.banner,
          ),*//*

          child: banner != null ? AdWidget(ad: banner!,) : Container(),
        ),
      );
      //bannerAd.load();

      // return Container(
      //   height: 50,
      //   child: AdWidget(
      //     ad: bannerAd,
      //   ),
      // );

    } else if (id == 1) {
      return Container();
      // return FacebookNativeAd(
      //   placementId: FACEBOOK_AD_ID,
      //   adType: NativeAdType.NATIVE_AD,
      //   width: double.infinity,
      //   height: 300,
      //   backgroundColor: Colors.blue,
      //   titleColor: Colors.white,
      //   descriptionColor: Colors.white,
      //   buttonColor: Colors.deepPurple,
      //   buttonTitleColor: Colors.white,
      //   buttonBorderColor: Colors.white,
      //   keepAlive: true,
      //   //set true if you do not want adview to refresh on widget rebuild
      //   keepExpandedWhileLoading: false,
      //   // set false if you want to collapse the native ad view when the ad is loading
      //   expandAnimationDuraion: 300,
      //   //in milliseconds. Expands the adview with animation when ad is loaded
      //   listener: (result, value) {
      //     print("Native Ad: $result --> $value");
      //   },
      // );
    }else if(id == 2){
      // final InterstitialAd myInterstitial = InterstitialAd(
      //   adUnitId: 'ca-app-pub-7803172892594923/3981755613',
      //   request: AdRequest(),
      //   listener: AdListener(),
      // );
      // myInterstitial.load().then((value){
      //   myInterstitial.show();
      // });
      createInterstitialAd();
    }
  }

}


*/

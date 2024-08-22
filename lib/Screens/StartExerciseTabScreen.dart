// import 'dart:async';
//
// import 'package:exercise_app/CustomWidgets/VoiceAssistant.dart';
// import 'package:exercise_app/Modals/ExercisesClass.dart';
// import 'package:exercise_app/Screens/StartExercise.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';
//
// import '../Themes.dart';
// import '../main.dart';
//
// class StartExerciseTabScreen extends StatefulWidget {
//
//   ExercisesClass exercisesClass;
//   StartExerciseTabScreen(this.exercisesClass);
//
//   @override
//   _StartExerciseTabScreenState createState() => _StartExerciseTabScreenState();
// }
//
// class _StartExerciseTabScreenState extends State<StartExerciseTabScreen> with TickerProviderStateMixin{
//
//   int starting321 = 3;
//   FlutterTts flutterTts = FlutterTts();
//   List<Create> list = List();
//   int currentIndex = 0;
//   TabController tabController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     list.addAll(widget.exercisesClass.data.exercise.create);
//     voiceSetup();
//     tabController = TabController(length: list.length, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return starting321 >= 1 ? Scaffold(
//       body: Container(
//           height: double.maxFinite,
//           width: double.maxFinite,
//           color: Colors.black87,
//           child: Center(
//             child: t.mediumText(
//               text: starting321.toString(),
//               size: 120,
//               color: WHITE,
//             ),
//           )
//       ),
//     ) :Scaffold(
//         appBar: AppBar(
//         elevation: 0,
//         backgroundColor: WHITE,
//         leading: Container(),
//         flexibleSpace: customDialogues.header(""),
//         ),
//         body: body(),
//     );
//   }
//
//   voiceSetup() async{
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setSpeechRate(1.0);
//     await flutterTts.setVolume(1.0);
//     await flutterTts.setPitch(1.0);
//     setState(() {
//       voiceAssistant = VoiceAssistant(flutterTts);
//     });
//     sayThreeTwoOne();
//   }
//
//   sayThreeTwoOne() {
//     Timer(Duration(milliseconds: 700), () async{
//       if(starting321 >= 1){
//         voiceAssistant.speak("${starting321.toString()}");
//         Vibrate.vibrate().then((value){
//           print("vibrated");
//         }).catchError((e){
//           print(e);
//         });
//         await Future.delayed(Duration(milliseconds: 500));
//         setState(() {
//           starting321--;
//         });
//         sayThreeTwoOne();
//       }
//     });
//   }
//
//   body() {
//     return Stack(
//       children: [
//         Column(
//           children: [
//             Container(
//               color: WHITE,
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 children: List.generate(list.length, (index){
//                   return Expanded(
//                     child: Container(
//                       height: 6,
//                       margin: EdgeInsets.all(1),
//                       color: BLUE,
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             Expanded(
//                 child: TabBarView(
//                     children: list.map((e){
//                       return StartExercise(e);
//                     }).toList(),
//                   controller: tabController,
//                 ),
//             )
//           ],
//         ),
//         bottomButtons(),
//       ],
//     );
//   }
//
//   bottomButtons() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         SizedBox(height: 25,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset("assets/startExcercise/prev.png", height: 30, width: 30,),
//             SizedBox(width: 20,),
//             Container(
//               height: 50,
//               width: 180,
//             ),
//             SizedBox(width: 20,),
//             Image.asset("assets/startExcercise/next.png", height: 30, width: 30,)
//           ],
//         ),
//         SizedBox(height: 25,),
//       ],
//     );
//   }
//
//
//
// }

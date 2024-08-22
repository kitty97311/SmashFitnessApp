import 'package:flutter_tts/flutter_tts.dart';

class VoiceAssistant{

  FlutterTts flutterTts;


  VoiceAssistant(this.flutterTts);

  Future speak(String x) async{
    var result = await flutterTts.speak(x);
    //if (result == 1) setTtsState(TtsState.playing);
  }

  Future pause() async{
    var result = await flutterTts.pause();
    //if (result == 1) setTtsState(TtsState.paused);
  }

  Future stop() async{
    var result = await flutterTts.stop();
    //if (result == 1) setTtsState(TtsState.playing);
  }


}
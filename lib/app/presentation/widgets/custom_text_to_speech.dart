
import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';



class CustomTextToSpeech extends StatefulWidget {
  CustomTextToSpeech(this.txt);
  final String txt;

  @override
  _CustomTextToSpeechState createState() => _CustomTextToSpeechState();
}

class _CustomTextToSpeechState extends State<CustomTextToSpeech> {
  final FlutterTts flutterTts = FlutterTts();
  bool speaking = false;

  @override
  void initState() {
    flutterTts.setStartHandler(() {
      ///This is called when the audio starts
      setState(() {
        speaking = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      ///This is called when the audio ends
      setState(() {
        speaking = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future _speak(String text) async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1);
    await flutterTts.setVolume(100);
    await flutterTts.speak(text);
  }

  void _startAudio() {
    _speak(widget.txt);
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 30, width: 30,
      child: IconButton(
        icon: Icon(Icons.keyboard_voice, color: Colors.indigoAccent,),
        onPressed: speaking ? null : _startAudio,
      ),
    );
  }
}
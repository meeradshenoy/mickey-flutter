
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:micky/animated_icon.dart';
import 'package:micky/color_pallete.dart';
import 'package:micky/feature_box.dart';
import 'package:micky/openai_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

// Main page for the application
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  // Instances of speech-to-text and text-to-speech services
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();

  // Variable to control the animation of the assistant icon
  bool animate = false;

  // Variable to store recognized speech
  String speech = '';

  // Instance of the OpenAIService for handling communication with OpenAI
  OpenAIService openAIService = OpenAIService();

  // Variables to store generated content and control delayed start for features list
  var generatedContent;
  var delayedStart = 1;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  // Initialize text-to-speech
  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    flutterTts.setStartHandler(() {
      setState(() {
        animate = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        animate = false;
      });
    });
  }

  // Initialize speech-to-text
  Future<void> initSpeechToText() async {
    await speechToText.initialize(debugLogging: true);
    setState(() {});
  }

  // Start listening to user's speech
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  // Stop the active speech recognition session
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  // Callback for speech recognition result
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      speech = result.recognizedWords;
      generatedContent = "...";
    });
    if (result.finalResult) {
      // Trigger actions when the entire sentence has been completed
      getTheDetails();
    }
  }

  // Get details from OpenAI based on the recognized speech
  Future<void> getTheDetails() async {
    final data = await openAIService.chatGPTAPI(speech);
    generatedContent = data;
    setState(() {});
    await convertTextToSpeech(data);
  }

  // Convert generated text to speech
  Future<void> convertTextToSpeech(String data) async {
    await flutterTts.speak(data);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Micky'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Animated assistant icon
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: AnimatedAssistantIcon(
                    animate: animate,
                  ),
                ),
              ),
            ),

            // Chat Bubbles
            if (speech.isNotEmpty)
              SlideInRight(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 40)
                        .copyWith(top: 30),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorPallete.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(20)
                            .copyWith(topRight: Radius.zero)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        speech,
                        style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'SourceCodePro',
                            color: ColorPallete.mainFontColor),
                      ),
                    ),
                  ),
                ),
              ),

            // Assistant's response bubble
            Visibility(
              child: Align(
                alignment: Alignment.centerLeft,
                child: SlideInLeft(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 40)
                        .copyWith(top: 30),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorPallete.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(20)
                            .copyWith(topLeft: Radius.zero)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        generatedContent == null
                            ? 'Good Morning, I am your personal assistant. What task can I do for you?'
                            : generatedContent!,
                        style: TextStyle(
                            fontSize: generatedContent == null ? 22 : 18,
                            fontFamily: 'SourceCodePro',
                            color: ColorPallete.mainFontColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Features list
            Visibility(
              visible: generatedContent == null,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Here are a few features',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'SourceCodePro',
                          color: ColorPallete.mainFontColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Feature boxes with animations
                  SlideInLeft(
                    delay: Duration(seconds: delayedStart),
                    child: const FeatureBox(
                      color: ColorPallete.firstSuggestionBoxColor,
                      headerText: 'ChatGPT',
                      descriptionText:
                      'A smarter way to stay organized and informed with ChatGPT',
                    ),
                  ),
                  SlideInRight(
                    delay: Duration(seconds: delayedStart),
                    child: const FeatureBox(
                      color: ColorPallete.thirdSuggestionBoxColor,
                      headerText: 'Smart Voice Assistant',
                      descriptionText:
                      'Get the best of the world with a voice assistant powered by ChatGPT',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Toggle speech recognition based on the current state
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        backgroundColor: ColorPallete.firstSuggestionBoxColor,
        child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
      ),
    );
  }
}

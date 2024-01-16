# Micky - Your Personal Assistant Flutter App

Micky is a Flutter application that serves as your personal assistant, integrating speech-to-text, text-to-speech, and OpenAI's ChatGPT API to provide an interactive and voice-controlled experience.

## Features

- **Voice Recognition:** Micky uses the `speech_to_text` library for voice recognition, allowing it to listen to your voice commands and convert them into text.
- **ChatGPT Integration:** Utilizes OpenAI's ChatGPT API to generate responses based on user input.
- **Voice Responses:** Micky responds to your commands with voice-generated responses using the `flutter_tts` library for text-to-speech.
- **Animated Assistant Icon:** The assistant icon animates based on its activity.

## Prerequisites

Before running the application, make sure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- Mobile device/emulator for testing

## Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/micky-flutter.git
    ```

2. **Navigate to the project directory:**
    ```bash
    cd micky-flutter
    ```

3. **Install dependencies:**
    ```bash
    flutter pub get
    ```

## Usage

1. Ensure your mobile device/emulator is connected.
2. **Run the application:**
    ```bash
    flutter run
    ```

3. Explore the features of Micky on the Flutter app.

## Configuration

- **OpenAI API Key:** To use OpenAI's ChatGPT API, you need an API key. Follow these steps to obtain your API key:
   - Visit the [OpenAI website](https://beta.openai.com/signup/).
   - Sign up for an account or log in if you already have one.
   - Once logged in, navigate to the API section to create a new API key.
   - Copy the generated API key and replace it in the `openai_service.dart` file.

- **Customize Colors:** Adjust color constants in the `color_pallete.dart` file to match your design.

## Voice Recognition Library

Micky uses the `speech_to_text` library for voice recognition. Visit the [speech_to_text package](https://pub.dev/packages/speech_to_text) for more details on how to customize and use this library.

## Text-to-Speech Library

Micky uses the `flutter_tts` library for text-to-speech. Check out the [flutter_tts package](https://pub.dev/packages/flutter_tts) for information on customizing and implementing text-to-speech functionality.



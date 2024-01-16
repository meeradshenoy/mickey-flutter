import 'package:flutter/material.dart';
import 'package:micky/color_pallete.dart';
import 'package:micky/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Micky',
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: ColorPallete.whiteColor,
          appBarTheme: const AppBarTheme(backgroundColor: ColorPallete.whiteColor)),
      home: const HomePage(),
    );
  }
}

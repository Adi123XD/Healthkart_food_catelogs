import 'package:flutter/material.dart';
import 'package:ocr_food_catelogs/pages/home_page.dart';
import 'package:ocr_food_catelogs/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
  MultiProvider(
    providers:[
      // theme Provider
      ChangeNotifierProvider(create: (context)=>ThemeProvider()),
      // add other providers 
    ],
    child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      // home: const NewPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      // routes: {
      //   "/home_page": (context)=>const HomePage(),
      // },

    );
  }
}
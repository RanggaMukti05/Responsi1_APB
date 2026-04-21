import 'package:flutter/material.dart';
import 'package:responsi1apb/rangga/loginjob.dart';
import '../syauqi/splash_screen.dart';

void main() {
  runApp(const JobieApp());
}

class JobieApp extends StatelessWidget {
  const JobieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jobie Mobile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),

      home: const SplashScreen(),
    );
  }
}

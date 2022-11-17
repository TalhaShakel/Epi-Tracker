import 'package:epi_tracker/constants/ConstColors.dart';
import 'package:epi_tracker/screens/Add_medicine/Add_seizures.dart';
import 'package:epi_tracker/screens/Add_medicine/show.dart';
import 'package:epi_tracker/screens/Home.dart';
import 'package:epi_tracker/screens/Login_screen.dart';
import 'package:epi_tracker/screens/Splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/BarChat.dart';
import 'components/BottomBar.dart';
import 'components/Sync_calender.dart';
import 'components/chart.dart';
import 'components/flutter_calender.dart';
import 'components/linear_chart.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epi Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: SplashScreen(),
    );
  }
}

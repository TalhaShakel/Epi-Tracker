import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/BottomBar.dart';
import '../constants/ConstColors.dart';
import 'Login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    );
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ConstColors.primaryColor,
        child: Center(
          child: Text("Epi Tracker",style: GoogleFonts.orbitron(
            textStyle: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w700)
          ),),
        ),
      ),
    );
  }
}

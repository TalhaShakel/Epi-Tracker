import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/BottomBar.dart';
import '../constants/ConstColors.dart';

class LetsStart extends StatelessWidget {
  const LetsStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ConstColors.background,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70,),
              Container(
                width: 149,
                height: 42,
                color: ConstColors.primaryColor,
                child: Center(
                  child: Text("Epi Tracker",style: GoogleFonts.orbitron(
                      textStyle: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w700)
                  ),),
                ),
              ),
              SizedBox(height: 24,),
              Text("Lets Start",style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: ConstColors.primaryColor,fontSize: 32,fontWeight: FontWeight.w700)
              ),),
              SizedBox(height: 36,),
              Image.asset("assets/images/startBanner.png",height: 230),
              SizedBox(height: 58,),
              Text("Your Password has been reset",style: GoogleFonts.inter(
                  textStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400)
              ),),
              Text("successfully",style: GoogleFonts.inter(
                  textStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400)
              ),),
              SizedBox(height: 83,),
              InkWell(
                onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomBar()));
                },
                child: Container(
                  height: 53,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: ConstColors.primaryColor
                  ),
                  child: Center(
                    child: Text("Done",style: GoogleFonts.inter(textStyle: TextStyle(
                        fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white
                    )),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

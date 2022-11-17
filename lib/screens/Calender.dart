import 'package:epi_tracker/screens/Add_medicine/show.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/ConstColors.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
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
              SizedBox(height: 130,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Show()));
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: ConstColors.primaryColor)
                  ),
                  child: Center(
                    child: Text("Medication Calender",style: GoogleFonts.inter(
                        textStyle: TextStyle(color: ConstColors.primaryColor,fontWeight: FontWeight.w500,fontSize: 24)
                    ),),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              InkWell(
                // onTap: (){
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSeizures()));
                // },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: ConstColors.secondaryColor)
                  ),
                  child: Center(
                    child: Text("Seizures",style: GoogleFonts.inter(
                        textStyle: TextStyle(color: ConstColors.secondaryColor,fontWeight: FontWeight.w500,fontSize: 24)
                    ),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:epi_tracker/screens/seizurecalender.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/ConstColors.dart';
import 'Add_medicine/show.dart';
class Calenders extends StatefulWidget {
  const Calenders({Key? key}) : super(key: key);

  @override
  State<Calenders> createState() => _CalendersState();
}

class _CalendersState extends State<Calenders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body:Container(
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
                SizedBox(height: 40,),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: TabBar(
                    indicatorColor: ConstColors.primaryColor,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: ConstColors.primaryColor
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                            width: 130,
                            child: Center(child: Text("Seizure Calender"))),
                      ),
                      Tab(
                        child: Container(
                            width: 130,
                            child: Center(child: Text("Medication Calender"))),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: TabBarView(
                          children: [
                            SeizureCalender(),
                            Show(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                // InkWell(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Show()));
                //   },
                //   child: Container(
                //     height: 60,
                //     width: double.infinity,
                //     margin: EdgeInsets.only(left: 20,right: 20),
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(14),
                //         border: Border.all(color: ConstColors.primaryColor)
                //     ),
                //     child: Center(
                //       child: Text("Medication Calender",style: GoogleFonts.inter(
                //           textStyle: TextStyle(color: ConstColors.primaryColor,fontWeight: FontWeight.w500,fontSize: 24)
                //       ),),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 30,),
                // InkWell(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SeizureCalender()));
                //   },
                //   child: Container(
                //     height: 60,
                //     width: double.infinity,
                //     margin: EdgeInsets.only(left: 20,right: 20),
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(14),
                //         border: Border.all(color: ConstColors.secondaryColor)
                //     ),
                //     child: Center(
                //       child: Text("Seizures Calender",style: GoogleFonts.inter(
                //           textStyle: TextStyle(color: ConstColors.secondaryColor,fontWeight: FontWeight.w500,fontSize: 24)
                //       ),),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



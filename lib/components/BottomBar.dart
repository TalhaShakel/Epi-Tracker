import 'package:epi_tracker/constants/ConstColors.dart';
import 'package:epi_tracker/screens/Login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';import '../screens/2Calenders.dart';
import '../screens/Calender.dart';


import '../screens/Epilepsy_news.dart';
import '../screens/Home.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> allPages= [
    Calenders(),
    Home(),
    EpiNews(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:allPages[currentIndex!],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:ConstColors.background,
        elevation: 0,
        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },
        currentIndex: currentIndex!,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container
              (height: 62,
                width: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                    color: currentIndex==0?ConstColors.primaryColor:ConstColors.offWhite
                ),
                child: Icon(Icons.calendar_today_outlined)),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex==1?ConstColors.primaryColor:ConstColors.offWhite
                ),
                child: Icon(Icons.home)),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex==2?ConstColors.primaryColor:ConstColors.offWhite
                ),child: Icon(Icons.newspaper)),
            label: ""
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
      ),

    );
  }
  int? currentIndex =1;
}

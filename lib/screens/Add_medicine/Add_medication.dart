import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epi_tracker/components/BottomBar.dart';
import 'package:epi_tracker/components/Events.dart';
import 'package:epi_tracker/screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../constants/ConstColors.dart';

class AddMedication extends StatefulWidget {
  const AddMedication({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  final medicine = TextEditingController();
  final dosage = TextEditingController();
  final time = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  DateTime? selectedCalendarDate;
  var _time = DateFormat('hh:mm a').format(DateTime.now());
  var date= DateFormat('dd-MM-yyyy').format(DateTime.now());
   Map<DateTime, List<MyEvents>> mySelectedEvents={};


  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
     return mySelectedEvents[dateTime] ?? [];
  }
getEvents()async{
   QuerySnapshot<Map<String,dynamic>> snapshot =  await FirebaseFirestore.instance.collection('users').
    doc(FirebaseAuth.instance.currentUser!.uid).
    collection('medicines')
        .get();
//    for(var data in snapshot.docs){
//      setState(() {
//        if (mySelectedEvents[DateTime.parse(data.id)] != null) {
//          mySelectedEvents[DateTime.parse(data.id)]?.add(
//              MyEvents(
//                  eventTitle: data.data()["medicine"],
//                  eventDescp: data.data()["dosage"]
//              ));
//        } else {
//          mySelectedEvents[DateTime.parse(data.id)!] = [
//            MyEvents(
//                eventTitle: data.data()["medicine"],
//                eventDescp: data.data()["dosage"])
//          ];
//        }
//    });
//
// }
  }
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    mySelectedEvents = {};
    getEvents();
    super.initState();
  }

  void dispose() {
    medicine.dispose();
    dosage.dispose();
    time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ConstColors.background,
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        width: 149,
                        height: 42,
                        color: ConstColors.primaryColor,
                        child: Center(
                          child: Text(
                            "Epi Tracker",
                            style: GoogleFonts.orbitron(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomBar()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ConstColors.primaryColor),
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Add Medication",
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: ConstColors.primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 0.1)]),
                  child: Center(
                      child: TextFormField(
                    controller: medicine,
                    cursorColor: Colors.black54,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "Name of medication",
                      hintStyle: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      contentPadding: EdgeInsets.only(
                        left: 22,
                      ),
                      border: InputBorder.none,
                    ),
                    validator: (vaL) {
                      return vaL!.isEmpty ? "Please Enter Medicine" : null;
                    },
                  )),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 0.1)]),
                  child: Center(
                    child: TextFormField(
                      controller: dosage,
                      cursorColor: Colors.black54,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "Dosage",
                        hintStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        contentPadding: EdgeInsets.only(
                          left: 22,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (vaL) {
                        return vaL!.isEmpty ? "Please Enter Dosage" : null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 0.1)]),
                  child: Center(
                    child: TextFormField(
                      cursorColor: Colors.black54,
                      keyboardType: TextInputType.datetime,
                      initialValue: _time,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "Time",
                        hintStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        contentPadding: EdgeInsets.only(
                          left: 22,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (vaL) {
                        return vaL!.isEmpty ? "Please Enter Time" : null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.all(10),
                  child: TableCalendar(
                    eventLoader: _listOfDayEvents,
                    firstDay: _initialCalendarDate,
                    lastDay: _lastCalendarDate,
                    focusedDay: _focusedCalendarDate,
                    selectedDayPredicate: (currentSelectedDate) {
                      return (isSameDay(
                          selectedCalendarDate!, currentSelectedDate));
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(selectedCalendarDate, selectedDay)) {
                        setState(() {
                          selectedCalendarDate = selectedDay;
                          _focusedCalendarDate = focusedDay;
                        });
                      }
                    },
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.redAccent),
                    ),
                    calendarStyle: const CalendarStyle(
                      weekendTextStyle: TextStyle(color: Colors.redAccent),
                    ),
                    headerStyle: HeaderStyle(
                      decoration:
                          BoxDecoration(color: ConstColors.primaryColor),
                      headerMargin: EdgeInsets.only(bottom: 10),
                      titleTextStyle: TextStyle(color: Colors.white),
                      formatButtonDecoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                    // firstDay: DateTime.utc(2010, 10, 16),
                    // lastDay: DateTime.utc(2030, 3, 14),
                    // focusedDay: ,
                  ),
                ),
                ..._listOfDayEvents(selectedCalendarDate!).map((myEvents) => ListTile(
                  leading: const Icon(
                    Icons.done,
                    color: Colors.blue,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('Medicine:   ${myEvents.eventTitle}'),
                  ),
                  subtitle: Text('Dosage:   ${myEvents.eventDescp}'),
                ),),
                    // .map((myEvents) => StreamBuilder<QuerySnapshot>(
                    //       stream: FirebaseFirestore.instance
                    //           .collection('users')
                    //           .doc(FirebaseAuth.instance.currentUser!.uid)
                    //           .collection('medicines')
                    //           .snapshots(),
                    //       builder: (BuildContext context,
                    //           AsyncSnapshot<QuerySnapshot> snapshot) {
                    //         if (snapshot.hasData) {
                    //           return Container(
                    //             height: 100,
                    //             child: ListView.builder(
                    //                 itemCount: 1,
                    //                 itemBuilder: (context, index) {
                    //                   return ListTile(
                    //                     leading: const Icon(
                    //                       Icons.done,
                    //                       color: Colors.blue,
                    //                     ),
                    //                     title: Padding(
                    //                       padding: const EdgeInsets.only(
                    //                           bottom: 8.0),
                    //                       child: Text(
                    //                           'Medicine : ${snapshot.data!.docs[index]['medicine']}'),
                    //                     ),
                    //                     subtitle: Text(
                    //                         'Dosage : ${snapshot.data!.docs[index]['dosage']} '),
                    //                   );
                    //                 }),
                    //           );
                    //         } else {
                    //           return SizedBox();
                    //         }
                    //       },
                    //     )),
                // ..._listOfDayEvents(selectedCalendarDate!).map(
                //   (myEvents) => ListTile(
                //     leading: const Icon(
                //       Icons.done,
                //       color: Colors.blue,
                //     ),
                //     title: Padding(
                //       padding: const EdgeInsets.only(bottom: 8.0),
                //       child: Text('Medicine:   ${myEvents.eventTitle}'),
                //     ),
                //     subtitle: Text('Dosage:   ${myEvents.eventDescp}'),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Image.asset("assets/images/calender2.png",height: 300,),
                // ),
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_key.currentState!.validate()) {
                      print('==--------------');
                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('medicines')
                            .doc(selectedCalendarDate!.toString())
                            .set({
                          "data":selectedCalendarDate.toString(),
                          'medicine': medicine.text,
                          'dosage': dosage.text,
                          "time": DateFormat('hh:mm a').format(DateTime.now()),
                          "date":date,
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Medicine Added Successfully")));
                        setState(() {
                          if (mySelectedEvents[selectedCalendarDate] != null) {
                            mySelectedEvents[selectedCalendarDate]?.add(
                                MyEvents(
                                    eventTitle: medicine.text,
                                    eventDescp: dosage.text));
                          } else {
                            mySelectedEvents[selectedCalendarDate!] = [
                              MyEvents(
                                  eventTitle: medicine.text,
                                  eventDescp: dosage.text)
                            ];
                          }
                        });
                        // medicine.clear();
                        // dosage.clear();
                        return;
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: ConstColors.primaryColor),
                    child: Center(
                      child: Text(
                        "Add",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyEvents {
  final String eventTitle;
  final String eventDescp;

  MyEvents({required this.eventTitle, required this.eventDescp});

  @override
  String toString() => eventTitle;
}

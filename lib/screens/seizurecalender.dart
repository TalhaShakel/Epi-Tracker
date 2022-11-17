import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/ConstColors.dart';
class SeizureCalender extends StatefulWidget {
  const SeizureCalender ({Key? key}) : super(key: key);

  @override
  State<SeizureCalender> createState() => _ShowState();
}

class _ShowState extends State<SeizureCalender> {
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  Map<DateTime, List<MyEvents>> mySelectedEvents = {};

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  getEvents() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance.collection('users').
    doc(FirebaseAuth.instance.currentUser!.uid).
    collection('seizures')
        .get();
    for (var data in snapshot.docs) {
      setState(() {
        if (mySelectedEvents[DateTime.parse(data.id)] != null) {
          mySelectedEvents[DateTime.parse(data.id)]?.add(
              MyEvents(
                  eventTitle: data.data()["seizures"].toString(),
                eventDescp: data.data()["time"].toString(),

              ));
        } else {
          mySelectedEvents[DateTime.parse(data.id)] = [
            MyEvents(
                eventTitle: data.data()["seizures"].toString(),
              eventDescp: data.data()["time"].toString(),)
          ];
        }
      });
    }
  }
  void initState() {
    getEvents();
    selectedCalendarDate = _focusedCalendarDate;
    super.initState();
  }
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
              SizedBox(height: 30,),
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
                  color: Colors.red,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Seizures:   ${myEvents.eventTitle}'),
                ),
                subtitle: Text('Time:   ${myEvents.eventDescp}'),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
class MyEvents {
  final String eventTitle;
  final String eventDescp;

  MyEvents({required this.eventTitle,required this.eventDescp});

  @override
  String toString() => eventTitle;
}

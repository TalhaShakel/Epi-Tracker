import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:d_chart/d_chart.dart';
import 'package:epi_tracker/screens/Add_medicine/Add_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/BarChat.dart';
import '../components/linear_chart.dart';
import '../constants/ConstColors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? selectedCalendarDate;
  Map<DateTime, List<MyEvents>> mySelectedEvents = {};

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  bool medicine = false;
  String _month = DateFormat('dd').format(DateTime.now());
  final streamchart = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('seizures')
      .snapshots(includeMetadataChanges: true);
  List<Color> gradientColors = [
    ConstColors.primaryColor,
    ConstColors.primaryColor,
  ];

  bool showAvg = false;
  var today = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: ConstColors.background,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddScreen()));
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
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Medicines Taken Today",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: ConstColors.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 170,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: ConstColors.primaryColor),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('medicines')
                          .where("date", isEqualTo: today)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(snapshot.hasData){
                              if (snapshot.data!.docs.isNotEmpty) {
                                return Container(
                                  height: 600,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10),
                                          child: Container(
                                            height: 40,
                                            width: double.infinity,
                                            margin:
                                            EdgeInsets.only(
                                                left: 20, right: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .shade400)),
                                            child: Row(children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                ['medicine'],
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight
                                                          .w400,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              // Spacer(),
                                              Text(
                                                '(${snapshot.data!
                                                    .docs[index]['dosage']})',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .w400,
                                                        fontSize: 18)),
                                              ),
                                              Spacer(),
                                              CustomCheckBox(
                                                  value: medicine,
                                                  // shouldShowBorder: true,
                                                  borderColor: Colors.grey,
                                                  checkedFillColor:
                                                  ConstColors.primaryColor,
                                                  uncheckedIconColor: Colors
                                                      .black,
                                                  uncheckedIcon: Icons.check,
                                                  borderRadius: 6,
                                                  borderWidth: 1,
                                                  checkBoxSize: 20,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      medicine = val;
                                                    });
                                                  }),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ]),
                                          ),
                                        );
                                        // return Row(
                                        //   children: [
                                        //     Text(snap[index]['medicine']),
                                        //     Text(snap[index]['dosage']),
                                        //   ],
                                        // );
                                      }),
                                );
                              } else  {
                                return
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 30,
                                        width: double.infinity,
                                        margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey.shade400)),
                                        child: Row(children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Medicine A',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "(100 mg)",
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18)),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 30,
                                        width: double.infinity,
                                        margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey.shade400)),
                                        child: Row(children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Medicine A',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "(100 mg)",
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18)),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 30,
                                        width: double.infinity,
                                        margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey.shade400)),
                                        child: Row(children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Medicine A',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "(100 mg)",
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18)),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 30,
                                        width: double.infinity,
                                        margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey.shade400)),
                                        child: Row(children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Medicine A',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "(100 mg)",
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18)),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ]),
                                      ),
                                    ],
                                  );
                              }
                            }else{
                          return CupertinoActivityIndicator();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  // Container(
                  //   height: 50,
                  //   width: double.infinity,
                  //   margin: EdgeInsets.only(left: 20, right: 20),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12),
                  //       color: Colors.white,
                  //       boxShadow: [BoxShadow(blurRadius: 0.1)]),
                  //   child: Center(
                  //     child: Text(
                  //       "Medicine C Taken In 3 Hrs",
                  //       style: GoogleFonts.poppins(
                  //           textStyle: TextStyle(
                  //               color: ConstColors.primaryColor,
                  //               fontWeight: FontWeight.w700,
                  //               fontSize: 15)),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Seizures Tracked Last 30 Days",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: ConstColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                  ),
                  // Text("This Month Chart",
                  //     style: TextStyle(
                  //         color: ConstColors.primaryColor,
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 14)),
                  // Container(
                  //   height: 33,
                  //   width: double.infinity,
                  //   margin: EdgeInsets.only(left: 49, right: 49),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //       color: Colors.black
                  //   ),
                  //   child: TabBar(
                  //     indicatorColor: Colors.transparent,
                  //     tabs: [
                  //       Tab(
                  //         child: Text("Aug", style: GoogleFonts.poppins(
                  //             textStyle: TextStyle(
                  //                 color: ConstColors.primaryColor,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 14)
                  //         ),),
                  //       ),
                  //       Tab(
                  //         child: Text("Sep", style: GoogleFonts.poppins(
                  //             textStyle: TextStyle(
                  //                 color: ConstColors.primaryColor,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 14)
                  //         ),),
                  //       ),
                  //       Tab(
                  //         child: Text("Oct", style: GoogleFonts.poppins(
                  //             textStyle: TextStyle(
                  //                 color: ConstColors.primaryColor,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 14)
                  //         ),),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 0,
                  ),
                  Container(
                    height: 250,
                    child: ListView(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      children: [
                        StreamBuilder(
                            stream: streamchart,
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              List listChart = snapshot.data!.docs.map((e) {
                                return {
                                  'domain': DateFormat('dd')
                                      .format(DateTime.parse(e.data()['data'])),
                                  'measure': e.data()['seizures'],
                                };
                              }).toList();
                              listChart.sort(
                                  (a, b) => b['domain'].compareTo(a['domain']));
                              if (snapshot.hasData) {
                                if (snapshot.data!.docs.isNotEmpty) {
                                  return Container(
                                    height: 250,
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: DChartBar(
                                        data: [
                                          {
                                            'id': 'Bar',
                                            'data': listChart,
                                          }
                                        ],
                                        axisLineColor: ConstColors.primaryColor,
                                        barColor: (barData, index, id) =>
                                        ConstColors.primaryColor,
                                        showBarValue: true,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 200,
                                        child: ListView(
                                          padding: EdgeInsets.all(16.0),
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: DChartBar(
                                                data: const [
                                                  {
                                                    'id': 'Bar',
                                                    'data': [
                                                      {
                                                        'domain': '1',
                                                        'measure': 0,
                                                      },
                                                      {
                                                        'domain': '2',
                                                        'measure': 0,
                                                      },
                                                      {
                                                        'domain': '3',
                                                        'measure': 0,
                                                      },
                                                      {
                                                        'domain': '4',
                                                        'measure': 0,
                                                      },
                                                      {
                                                        'domain': '5',
                                                        'measure': 0,
                                                      },
                                                      {
                                                        'domain': '6',
                                                        'measure': 0,
                                                      },
                                                      {
                                                        'domain': '7',
                                                        'measure': 0,
                                                      },
                                                    ]
                                                  }
                                                ],
                                                axisLineColor:
                                                ConstColors.primaryColor,
                                                barColor: (barData, index,
                                                    id) =>
                                                ConstColors.primaryColor,
                                                showBarValue: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 30,),
                                      Text('Add Data to check your Chart!'),
                                    ],
                                  );
                                }
                              }
                             else {
                                return CupertinoActivityIndicator();
                              }
                            }
                            )
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 235,
                  //   width: double.infinity,
                  //   margin: EdgeInsets.only(left: 15,right: 15),
                  //   child: Stack(
                  //     children: <Widget>[
                  //       AspectRatio(
                  //         aspectRatio: 1.70,
                  //         child: Container(
                  //           decoration: const BoxDecoration(
                  //             borderRadius: BorderRadius.all(
                  //               Radius.circular(10),
                  //             ),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                   blurRadius: 0.1
                  //               )
                  //             ],
                  //             color: Colors.white,),
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(
                  //                 right: 18.0, left: 12.0, top: 24, bottom: 5),
                  //             child: LineChart(
                  //               showAvg ? avgData() : mainData(),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 60,
                  //         height: 34,
                  //         child: TextButton(
                  //           onPressed: () {
                  //             setState(() {
                  //               showAvg = !showAvg;
                  //             });
                  //           },
                  //           child: Text(
                  //             'Avg',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.w700,
                  //                 fontSize: 12,
                  //                 color:
                  //                 showAvg ? Colors.black.withOpacity(0.5) : Colors.black),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = const Text('Mon', style: style);
//         break;
//       case 2:
//         text = const Text('Tue', style: style);
//         break;
//       case 4:
//         text = const Text('Wed', style: style);
//         break;
//       case 6:
//         text = const Text('Thur', style: style);
//         break;
//       case 8:
//         text = const Text('Fri', style: style);
//         break;
//       case 10:
//         text = const Text('Sat', style: style);
//         break;
//       default :
//         text = const Text('', style: style);
//         break;
//     }
//
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 6.0,
//       child: text,
//     );
//   }
//
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '1';
//         break;
//       case 2:
//         text = '2';
//         break;
//       case 3:
//         text = '3';
//         break;
//       case 4:
//         text = '4';
//         break;
//       case 5:
//         text = '5';
//         break;
//       default:
//         return Container();
//     }
//
//     return Text(text, style: style, textAlign: TextAlign.center);
//   }
//
//   LineChartData mainData() {
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: ConstColors.primaryColor,
//             strokeWidth: 1,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: ConstColors.primaryColor,
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: ConstColors.primaryColor, width: 1)),
//       minX: 0,
//       maxX: 11,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 3),
//             FlSpot(2, 2),
//             FlSpot(4, 5),
//             FlSpot(6, 3),
//             FlSpot(8, 4),
//             FlSpot(10, 3),
//             FlSpot(11, 4),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: gradientColors,
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.3))
//                   .toList(),
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   LineChartData avgData() {
//     return LineChartData(
//       lineTouchData: LineTouchData(enabled: false),
//       gridData: FlGridData(
//         show: true,
//         drawHorizontalLine: true,
//         verticalInterval: 1,
//         horizontalInterval: 1,
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             getTitlesWidget: bottomTitleWidgets,
//             interval: 1,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//             interval: 1,
//           ),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//       ),
//       borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: const Color(0xff37434d), width: 1)),
//       minX: 0,
//       maxX: 11,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 3.44),
//             FlSpot(2.6, 3.44),
//             FlSpot(4.9, 3.44),
//             FlSpot(6.8, 3.44),
//             FlSpot(8, 3.44),
//             FlSpot(9.5, 3.44),
//             FlSpot(11, 3.44),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: [
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//               ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                   .lerp(0.2)!,
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: [
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//                 ColorTween(begin: gradientColors[0], end: gradientColors[1])
//                     .lerp(0.2)!
//                     .withOpacity(0.1),
//               ],
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
}

class MyEvents {
  final String eventTitle;
  final String eventDescp;

  MyEvents({required this.eventTitle, required this.eventDescp});

  @override
  String toString() => eventTitle;
}

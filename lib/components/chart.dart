import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epi_tracker/constants/ConstColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  String _month = DateFormat('MMMM').format(DateTime.now());
  final streamchart = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
  .collection('seizures').snapshots(includeMetadataChanges: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 50),
        children: [
          StreamBuilder(
          stream: streamchart,
            builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot){
            List listChart = snapshot.data!.docs.map((e){
    return {
  'domain':DateFormat('dd MM').format(DateTime.parse(e.data()['data'])),
  'measure':e.data()['seizures'],
};
            }).toList();
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                child: DChartBar(
                  data:  [
                    {
                      'id': 'Bar',
                      'data': listChart,
                    }
                  ],
                  axisLineColor: ConstColors.primaryColor,
                  barColor: (barData, index, id) => ConstColors.primaryColor,
                  showBarValue: true,
                ),
              ),
            );
            })
        ],
      )
    );
  }
}


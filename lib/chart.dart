
import 'dart:math' as math;
import 'package:daily_prayer/prayer_task/tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChartPage extends StatefulWidget {
  ChartPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    chartData = [];
    getDataFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Grafik tanggal $currentCalendar'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.black],
            ),
            color: Colors.black,
            image: DecorationImage(
                opacity: 0.5,
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.fill)),
        child: SfCartesianChart(
          series: <LineSeries<LiveData, int>>[ // Ganti BarSeries menjadi LineSeries
            LineSeries<LiveData, int>( // Ganti BarSeries menjadi LineSeries
              onRendererCreated: (ChartSeriesController controller) {
                _chartSeriesController = controller;
              },
              dataSource: chartData,
              xValueMapper: (LiveData data, _) => data.group + 1,
              yValueMapper: (LiveData data, _) => data.total,
            )
          ],
          primaryXAxis: NumericAxis( // Sesuaikan tipe primaryXAxis jika diperlukan
            title: AxisTitle(text: 'Waktu Shalat (1) Shubuh dst.'),
          ),
          primaryYAxis: NumericAxis(
            interval: 10,
            maximum: 100,
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            title: AxisTitle(text: 'Nilai'),
          ),
        ),
      ),
    );
  }

  void getDataFromFirebase() {
    FirebaseFirestore.instance
        .collection('$userNow')
        .doc('$currentCalendar')
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        List<dynamic> listOfTask = documentSnapshot.data()!['listOfTask'];
        int groupIndex = 0;
        int total = 0;
        for (int i = 0; i < listOfTask.length; i++) {
          bool taskValue = listOfTask[i];
          total += taskValue ? 20 : 0;
          if ((i + 1) % 4 == 0) {
            chartData.add(LiveData(groupIndex++, total));
            total = 0;
          }
        }
        setState(() {});
      } else {
        print('Document does not exist on the database');
      }
    }).catchError((error) {
      print('Error getting document: $error');
    });
  }
}


class LiveData {
  LiveData(this.group, this.total);

  final int group;
  final int total;
}

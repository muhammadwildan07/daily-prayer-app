part of 'prayer_time.dart';

class PrayerTimesWidget extends StatefulWidget {
  @override
  _PrayerTimesWidgetState createState() => _PrayerTimesWidgetState();
}

class _PrayerTimesWidgetState extends State<PrayerTimesWidget> {
  late Future<List<PrayerTime>> futurePrayerTimes;

  @override
  void initState() {
    super.initState();
    futurePrayerTimes = fetchPrayerTimesRetry();
  }

  Future<List<PrayerTime>> fetchPrayerTimesRetry() async {
    try {
      return await fetchPrayerTimes();
    } catch (error) {
      await Future.delayed(Duration(seconds: 1));
      return fetchPrayerTimesRetry();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.settings_backup_restore),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (contex)=> MyPopup2()));
              },
            ),
          ),
        ],
        backgroundColor: Colors.amber,
        title: Text('''Prayer Times 
${selectedLocation!.toUpperCase()}'''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.fill)),
        child: FutureBuilder<List<PrayerTime>>(
          future: futurePrayerTimes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: Mohon periksa jaringan anda '));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    
                    children: [
                      SafeArea(
                        
                        child: DataTable(
                          // decoration: BoxDecoration(color: Colors.amber.withOpacity(0.7)),
                          horizontalMargin: 10,
                          // Margin horizontal dari DataTable
                          columnSpacing: 30,
                          // Jarak horizontal antara DataColumn
                          dataRowHeight: 30,
                          // Tinggi setiap DataRow
                          headingRowHeight: 50,
                          // Tinggi DataRow yang berisi DataColumn
                          dividerThickness: 2,
                          // Ketebalan garis pemisah antara baris
                          columns: [
                            DataColumn(label: Text('Tanggal',style: TextStyle(fontSize: 17,),)),
                            DataColumn(label: Text('Imsyak',style: TextStyle(fontSize: 17,))),
                            DataColumn(label: Text('Shubuh',style: TextStyle(fontSize: 17,))),
                            DataColumn(label: Text('Terbit',style: TextStyle(fontSize: 17,))),
                            DataColumn(label: Text('Dhuha',style: TextStyle(fontSize: 17,))),
                            DataColumn(label: Text('Dzuhur',style: TextStyle(fontSize: 17,))),
                            DataColumn(label: Text('Ashr',style: TextStyle(fontSize: 17,))),
                            DataColumn(label: Text('Magrib',style: TextStyle(fontSize: 17,))),
                            DataColumn(label: Text('Isya',style: TextStyle(fontSize: 17,))),
                          ],
                          rows: snapshot.data!.map((prayerTime) {
                            return DataRow(
                              color: MaterialStateColor.resolveWith(
                                  (states) => Colors.white.withOpacity(0.7)),
                              cells: [
                                DataCell(Text(prayerTime.tanggal,style: TextStyle(fontSize: 17,color: Colors.black),)),
                                DataCell(Text(prayerTime.imsyak)),
                                DataCell(Text(prayerTime.shubuh)),
                                DataCell(Text(prayerTime.terbit)),
                                DataCell(Text(prayerTime.dhuha)),
                                DataCell(Text(prayerTime.dzuhur)),
                                DataCell(Text(prayerTime.ashr)),
                                DataCell(Text(prayerTime.magrib)),
                                DataCell(Text(prayerTime.isya)),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

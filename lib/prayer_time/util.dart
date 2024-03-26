part of 'prayer_time.dart';

Future<List<PrayerTime>> fetchPrayerTimes() async {

  final response = await http.get(Uri.parse(
      'https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/$selectedLocation/$year/${valueLenght(month)?month:'0'+month}.json'
      // 'https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/$selectedLocation/$year/${valueLenght(month)?month:'0'+month}.json'
    ));
  if (response.statusCode == 200) {
    final List<dynamic> parsedJson = jsonDecode(response.body);
    return parsedJson.map((json) => PrayerTime.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load prayer times');
  }
}

bool valueLenght(String val){
  if(val.length == 2 ){
    return true;
  }else{
    return false;
  }
}

// Container(
// child: StreamBuilder<DateTime>(
// stream: _timeStream,
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// _currentTime = snapshot.data!;
// }
// return Container(
// child: Row(
// children: [
// Text(
// "${_currentTime.hour}",
// style: TextStyle(fontSize: 150),
// ),
// Column(
// children: [
// Text(
// "${_currentTime.minute}",
// style: TextStyle(fontSize: 50),
// ),
// Text(
// "${_currentTime.second}",
// style: TextStyle(fontSize: 50),
// ),
// ],
// ),
// ],
// ),
// );
// },
// ),
// ),
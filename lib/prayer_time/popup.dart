part of 'prayer_time.dart';

class MyPopup extends StatefulWidget {
  @override
  State<MyPopup> createState() => _MyPopupState();
}

class _MyPopupState extends State<MyPopup> {

  List<String> locations = []; // Daftar pilihan lokasi

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/kota.json'));

    if (response.statusCode == 200) {
      // Parsing JSON response
      List<dynamic> data = jsonDecode(response.body);
      List<String> cityNames = [];
      for (var city in data) {
        cityNames.add(city.toString());
      }
      setState(() {
        locations = cityNames;
      });
    } else {
      throw Exception('Failed to load cities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Center(
        child: AlertDialog(
          backgroundColor: Colors.amber,

          title: Text('Masukan Lokasi Anda',textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(20)),
              DropdownButton<String>(
                hint: Text(
                  'Lokasi'
                ),
                value: selectedLocation,
                items: locations.map((String location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLocation = newValue;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Tambahkan logika untuk melanjutkan sesuai dengan lokasi yang dipilih
                if(selectedLocation != null) {
                  // Lakukan sesuatu dengan selectedLocation
                  print(selectedLocation);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PrayerTimesWidget()));
                } else {
                  // Tampilkan pesan kesalahan jika tidak ada lokasi yang dipilih
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select a location.'),
                  ));
                }
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

String toUpperCaseFirstChar(String input){
  if (input.isEmpty) {
    return input; // Mengembalikan string kosong jika input kosong
  }
  return input[0].toUpperCase() + input.substring(1);
  
}
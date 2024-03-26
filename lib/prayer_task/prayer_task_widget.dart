part of 'tasks.dart';

class PrayerTaskWidget extends StatefulWidget {
  const PrayerTaskWidget({Key? key}) : super(key: key);

  @override
  State<PrayerTaskWidget> createState() => _PrayerTaskWidgetState();
}

class _PrayerTaskWidgetState extends State<PrayerTaskWidget> {
  late Stream<DateTime> _timeStream;
  late DateTime _currentTime;
  late List<bool> isCheckedList;
  bool isLoading = true; // Deklarasi variabel isLoading

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timeStream = Stream<DateTime>.periodic(
        const Duration(seconds: 1), (_) => DateTime.now());

    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(
              '${user?.email}') // Ganti dengan nama koleksi yang sesuai di Firestore Anda
          .doc('$currentCalendar') // Ganti dengan ID dokumen yang sesuai
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          isCheckedList =
              List<bool>.from(data['listOfTask'] ?? List.filled(20, false));
          print(isCheckedList);
        });
      } else {
        setState(() {
          isCheckedList = List.filled(20, false);
        });
      }
    } catch (error) {
      print("Failed to read data from Firestore: $error");
      setState(() {
        isCheckedList = List.filled(20, false);
      });
    } finally {
      // Setelah pengambilan data selesai (baik berhasil atau gagal), set isLoading menjadi false
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildCheckbox(int index) {
    return Checkbox(
      value: isCheckedList[index],
      onChanged: (value) {
        if (index == 0) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index + 1);
        } else if (index == 1) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index - 1);
        } else if (index == 4) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index + 1);
        } else if (index == 5) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index - 1);
        } else if (index == 8) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index + 1);
        } else if (index == 9) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index - 1);
        } else if (index == 12) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index + 1);
        } else if (index == 13) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index - 1);
        } else if (index == 16) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index + 1);
        } else if (index == 17) {
          toggleCheckbox(value!, index);
          toggleCheckbox(!value, index - 1);
        } else {
          toggleCheckbox(value!, index);
        }
      },
    );
  }

  void toggleCheckbox(bool value, int index) {
    setState(() {
      isCheckedList[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var timeNow = DateTime.now();
    return user == null
        ? const AuthPage()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Daily Task',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              backgroundColor: Colors.amber,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingPage()));
                  },
                ),
              ],
            ),
            body: isLoading
                ? Scaffold(
                    backgroundColor: Colors.amberAccent,
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                  children: [
                    Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/background.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SafeArea(
                                      child: Column(
                                        children: [
                                          const Padding(
                                              padding: EdgeInsets.only(bottom: 35)),
                                          const Center(
                                            child: Text(
                                              "Absensi Harian",
                                              style: TextStyle(
                                                fontSize: 40,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              currentCalendar,
                                              style: const TextStyle(fontSize: 40),
                                            ),
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.only(bottom: 20)),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: isLoading
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Center(
                                                          child: DataTable(
                                                            columnSpacing: 20,
                                                            columns: const [
                                                              DataColumn(
                                                                label: Icon(Icons
                                                                    .mosque_outlined), // Menggunakan Icon sebagai label
                                                              ),
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Tepat Waktu',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center)),
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Qadha',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center)),
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Berjamaah',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center)),
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Tadarus',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center)),
                                                            ],
                                                            rows: [
                                                              DataRow(cells: [
                                                                const DataCell(
                                                                    Text('Shubuh')),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        0)),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        1)),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        2)),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        3)),
                                                              ]),
                                                              DataRow(cells: [
                                                                const DataCell(
                                                                    Text('Dzuhur')),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        4)),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        5)),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        6)),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        7)),
                                                              ]),
                                                              DataRow(cells: [
                                                                const DataCell(
                                                                    Text('Ashar')),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        8)),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        9)),
                                                                DataCell(
                                                                  buildCheckbox(10),
                                                                ),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        11)),
                                                              ]),
                                                              DataRow(cells: [
                                                                const DataCell(Text(
                                                                    'Maghrib')),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        12)),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        13)),
                                                                DataCell(
                                                                  buildCheckbox(14),
                                                                ),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        15)),
                                                              ]),
                                                              DataRow(cells: [
                                                                const DataCell(
                                                                    Text('Isya')),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        16)),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        17)),
                                                                DataCell(
                                                                  buildCheckbox(18),
                                                                ),
                                                                DataCell(
                                                                    buildCheckbox(
                                                                        19)),
                                                              ]),
                                                              // Tambahkan baris DataRow lainnya di sini sesuai kebutuhan
                                                            ],
                                                          ),
                                                        ),
                                                        ElevatedButton.icon(
                                                          style: stylesButton(),
                                                          onPressed: () {
                                                            List<bool> listOfTask =
                                                                [];
                                                            setState(() {
                                                              for (int i = 0;
                                                                  i <
                                                                      isCheckedList
                                                                          .length;
                                                                  i++) {
                                                                listOfTask.add(
                                                                    isCheckedList[
                                                                        i]);
                                                              }
                                                            });

                                                            Map<String, dynamic>
                                                                list = {
                                                              'listOfTask':
                                                                  listOfTask
                                                            };
                                                            pushToDb(list,
                                                                currentCalendar);
                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    'Data telah diperbarui'),
                                                                duration: Duration(
                                                                    seconds: 2),
                                                                action:
                                                                    SnackBarAction(
                                                                  label: 'Tutup',
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          label: Text("update"),
                                                          icon: Icon(Icons.update),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 100),
                                            child: StreamBuilder<DateTime>(
                                              stream: _timeStream,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  _currentTime = snapshot.data!;
                                                }
                                                return Text(
                                                  "${_currentTime.hour}:${_currentTime.minute}:${_currentTime.second}",
                                                  style: TextStyle(
                                                      fontSize: 50,
                                                      color: Colors.white),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(bottom: 175))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
          );
  }
}

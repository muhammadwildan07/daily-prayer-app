part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<DateTime> _timeStream;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timeStream =
        Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return user == null
        ? AuthPage()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Daily Prayer',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              backgroundColor: Colors.amber, // Warna latar belakang app bar
              centerTitle: true, // Pusatkan judul
              actions: [
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingPage()));
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(

                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/background.jpg'),
                              fit: BoxFit.fill)),
                      child: Column(
                        children: [
                          // Padding(padding: EdgeInsets.only(top: 50)),
                          SafeArea(
                            child: SizedBox(
                              width: double.infinity,
                              child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.amberAccent),
                                  child: Container(
                                    color: Colors.amberAccent,
                                    width: 400,
                                    // margin: EdgeInsets.symmetric(horizontal: width / 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: Colors.amberAccent,
                                          child: Text(
                                            'WELCOME',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        textKit(userNow.toString())
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          SafeArea(
                            child: Column(
                              children: [
                                // Widget untuk menampilkan waktu real-time
                                Padding(padding: EdgeInsets.only(bottom: 45)),
                                Container(
                                  child: StreamBuilder<DateTime>(
                                    stream: _timeStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        _currentTime = snapshot.data!;
                                      }
                                      return Container(
                                        child: Text(
                                          "${_currentTime.hour}:${_currentTime.minute}:${_currentTime.second}",
                                          style: TextStyle(fontSize: 50),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // Padding(padding: EdgeInsets.only(bottom: 20)),
                                Center(
                                  child: Text(
                                    "Feature",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 30)),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    padding: EdgeInsets.only(right: 61, left: 61),
                                    // color: Colors.red,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            gestureDetector(
                                                context,
                                                Icons.schedule,
                                                selectedLocation == null
                                                    ? MyPopup()
                                                    : PrayerTimesWidget(),
                                                'Jadwal Shalat'),
                                            Padding(
                                                padding: EdgeInsets.only(
                                              top: 20,
                                              right: 20,
                                            )),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20)),
                                            gestureDetector(
                                                context,
                                                Icons.book_outlined,
                                                DoaWidget(),
                                                'Doa Harian'),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20,top: 20)),
                                            gestureDetector(
                                                context,
                                                Icons.workspace_premium,
                                                ReminderPage1(),
                                                'Self Reminder')
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(right: 20)),
                                        Column(
                                          children: [
                                            gestureDetector(context, Icons.task_alt,
                                                PrayerTaskWidget(), 'Tugas Harian'),
                                            Padding(
                                                padding: EdgeInsets.only(top: 20)),
                                            gestureDetector(
                                                context,
                                                Icons.auto_graph_outlined,
                                                ChartPage(title: 'Graphic'),
                                                'Graphic Hari Ini'),
                                            Padding(
                                                padding: EdgeInsets.only(top: 20)),
                                            gestureDetector(
                                                context,
                                                Icons.history_edu,
                                                ReminderPage1(namePage: 'Task History',),
                                                'Task History')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
  }
}

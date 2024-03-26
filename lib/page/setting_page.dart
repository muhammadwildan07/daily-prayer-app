part of'pages.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}
class _SettingPageState extends State<SettingPage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return user == null ? AuthPage():Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Colors.amber, // Warna latar belakang app bar
        centerTitle: true, // Pusatkan judul
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 20)),
            SingleChildScrollView(
              child:               ElevatedButton.icon(
                  onPressed: () { FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop();},
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out'))
            ),
          ],
        ),
      ),
      // appBar: ,
    );
  }
}


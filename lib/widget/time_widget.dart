part of 'widgets.dart';


class TimeProvider extends ChangeNotifier {
  String _currentTime = '';

  String get currentTime => _currentTime;

  TimeProvider() {
    _updateTime();
  }

  void _updateTime() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now().toString();
      notifyListeners();
    });
  }
}


class TimeNow extends StatelessWidget {
  const TimeNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-time Clock'),
      ),
      body: Center(
        child: Consumer<TimeProvider>(
          builder: (context, timeProvider, _) => Text(
            timeProvider.currentTime,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
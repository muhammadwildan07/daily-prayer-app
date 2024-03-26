import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class ReminderPage1 extends StatelessWidget {
  final String? namePage;
  const ReminderPage1({super.key, this.namePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(namePage !=null? namePage.toString():'Reminder Page'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text('Maaf, Fitur ini sedang dalam tahap pengembangan'),
      ),
    );
  }
}

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  TextEditingController taskController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleNotification(DateTime scheduledNotificationDateTime) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'self_reminder_channel', 'Self Reminder',
        importance: Importance.high, priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Reminder',
        'It\'s time to complete your task!',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
    await showTimePicker(context: context, initialTime: selectedTime);
    if (pickedTime != null && pickedTime != selectedTime)
      setState(() {
        selectedTime = pickedTime;
      });
  }

  void _addReminder() {
    DateTime scheduledDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute);
    _scheduleNotification(scheduledDateTime);
    taskController.clear();
    setState(() {
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay(hour: 0, minute: 0);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reminder added successfully!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Task'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: TextEditingController(
                            text: DateFormat('dd/MM/yyyy').format(selectedDate)),
                        decoration: InputDecoration(
                          labelText: 'Date',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: TextEditingController(
                            text: selectedTime.format(context)),
                        decoration: InputDecoration(
                          labelText: 'Time',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addReminder,
              child: Text('Add Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}

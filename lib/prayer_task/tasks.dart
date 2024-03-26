import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:daily_prayer/auth/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/util.dart';
import '../doa/doas.dart';
import '../main.dart';
import '../page/pages.dart';
import '../prayer_time/prayer_time.dart';

part 'prayer_task_widget.dart';
part 'task_history.dart';

var user = FirebaseAuth.instance.currentUser;
var userNow = user?.email;
var timeNow = DateTime.now();
String currentCalendar = '${timeNow.day} ${timeNow.month} ${timeNow.year}';

Future<List<bool>> getDataFromFirestore(String collectionName,String documentName) async {
  try {
    var documentSnapshot = await FirebaseFirestore.instance.collection(collectionName).doc(documentName).get();

    if (documentSnapshot.exists) {
      var dataList = documentSnapshot.data()!['listOfTask'] as List<bool>; // Ganti 'list' dengan nama field Anda
      return dataList;
    } else {
      print('Dokumen tidak ditemukan!');
      return [];
    }
  } catch (e) {
    print('Terjadi kesalahan: $e');
    return [];
  }
}

  var listData =  getDataFromFirestore(user.toString(), currentCalendar);

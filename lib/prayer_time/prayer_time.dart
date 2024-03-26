import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

part'prayer_time_widget.dart';
part 'util.dart';
part 'popup.dart';
part 'popup_2.dart';

DateTime now = DateTime.now();
String? selectedLocation;
var year =now.year.toString();
var month =now.month.toString();
class PrayerTime {
  final String tanggal;
  final String imsyak;
  final String shubuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashr;
  final String magrib;
  final String isya;

  PrayerTime({
    required this.tanggal,
    required this.imsyak,
    required this.shubuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashr,
    required this.magrib,
    required this.isya,
  });

  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    return PrayerTime(
      tanggal: json['tanggal'],
      imsyak: json['imsyak'],
      shubuh: json['shubuh'],
      terbit: json['terbit'],
      dhuha: json['dhuha'],
      dzuhur: json['dzuhur'],
      ashr: json['ashr'],
      magrib: json['magrib'],
      isya: json['isya'],
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

part 'util.dart';
part 'doa.dart';
part 'doa_detail_widget.dart';
part 'doa_widget.dart';
part 'animated_container_doa.dart';

int indexDoa = 0 ;
String doaName = '' ;
bool isDetailVisible = false;
 // State untuk menampilkan detail
/**
 * @author Aryan Sharma
 *
 * Desc: This class is used to store the history of the detected objects and thus the blind mans encounters
 */

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bndbox.dart';
import 'package:intl/intl.dart';

// referenced: https://stackoverflow.com/questions/54122850/how-to-read-and-write-a-text-file-in-flutter
// referenced: https://stackoverflow.com/questions/51579546/how-to-format-datetime-in-flutter/51579740#51579740
// referenced: https://stackoverflow.com/questions/49764905/how-to-assign-future-to-widget-in-flutter

class fileIO {
  void writeCounter(String objectData, int dist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    String newData = objectData + ', ' + dist.toString() + ', ' + formattedDate;
    String oldData = "";
    if (prefs.containsKey("data")) {
      oldData = prefs.getString("data") + "\n";
    }
    if (!oldData.contains(newData)) {
      await prefs.setString("data", oldData + newData);
    }
    //await prefs.setString("data", "\n" + newData);
  }

  Future<String> readFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("data");
  }
}
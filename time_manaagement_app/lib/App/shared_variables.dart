import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


/*    alarm          */
List? repeatList = [];
bool repeatAllDays = false;
List? snoozeList = [];
List? ringtoneList = [];

/*    task      */
/*
List<int> items = List<int>.generate(10000, (int index) => index); // random key
// for notifications (home screen before getting in task screen)
List<TaskDbModel> sharedTasks = [];
List<TaskDbModel> sharedArchivedTasks = [];
List<AlarmDbModel> alarms = [];
*/
bool showIndicator = false;
late SharedPreferences sharedPreferences ;

int newUniqueId = 0;

int getUniqueId() {
  return Random().nextInt(1000);
}

ThemeMode? myThemeMode;
bool? isDark= false;
bool? is24= false;

class PopupMenueItemModel {
  String? title;
  IconData? icon;
  Color? color;
  PopupMenueItemModel(this.title, this.icon, this.color);
}

List<PopupMenueItemModel> popupMenueItems = [
  PopupMenueItemModel(
      'Settings', Icons.settings, const Color.fromARGB(255, 1, 30, 53)),
  PopupMenueItemModel('Share', Icons.share, const Color.fromARGB(255, 2, 37, 97)),
  PopupMenueItemModel(
      'Contact Us', Icons.contact_page, const Color.fromARGB(255, 15, 148, 215)),
  PopupMenueItemModel('Premium Version', Icons.workspace_premium,
      const Color.fromARGB(255, 29, 134, 183)),
];

class LocalizationLanguagesItemModel {
  String? name;
  String? flag;
  LocalizationLanguagesItemModel(this.name, this.flag);
}

List localizationLanguages = [
LocalizationLanguagesItemModel("العربية", "🇸🇦"),
LocalizationLanguagesItemModel("English", "🇻🇮"),
LocalizationLanguagesItemModel("French", "🇬🇫"),

];

import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_scope/multiselect_scope.dart';
import 'package:open_file/open_file.dart';
import 'package:time_management/Alarm/Presentation/models/item_models.dart';
import 'package:time_management/Alarm/Presentation/screens/options_screen.dart';
import 'package:time_management/Alarm/Presentation/screens/set_alarm.dart';
import 'package:time_management/Alarm/data/models/alarm_db.dart';
import 'package:time_management/Alarm/data/repository/alarms_repository.dart';
import 'package:time_management/App/shared_variables.dart';
import 'package:file_picker/file_picker.dart';

part 'alarm_cubit_state.dart';

class AlarmCubit extends Cubit<AlarmCubitState> {
  static AlarmCubit getAlarmCubit(context) => BlocProvider.of(context);

  AlarmRepository alarmRepository = AlarmRepository();
  List<AlarmDbModel> alarms = [];
  AlarmCubit() : super(AlarmCubitInitial());
  AlarmDbModel item = AlarmDbModel();

  ///*********************************************************************

  TextEditingController alarmLabelController = TextEditingController();
  bool isRepeating = false;
  bool isSnoozing = false;
  bool isSilent = false;
  bool isVibrating = false;
  bool isActive = true;
  String? ringtonePath;

  DateTime selectedTime = DateTime.now();
  DateTime now = DateTime.now();

  final multiselectController = MultiselectController();
  var selectionController;

  ///**********************************************************************
  Future<List<AlarmDbModel>?> getAlarms() async {
    await alarmRepository.getAlarms().then((value) {
      //print("get cubit  $value");

      alarms = value!;
      //   print("get cubit  $alarms");
      emit(AlarmsLoadedState());
      // return alarms;
    }).catchError((onError) {
      //    print("get cubit error");
    });
    //  print("get cubit 2  $alarms");

    return alarms;
  }

  void addNewAlarm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SetAlarm("Save");
      }),
    );

    emit(AddNewAlarmState());
  }

  void onAlarmItemSelected(BuildContext context, AlarmDbModel currentItem) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SetAlarm("Update", currentItem: currentItem);
      }),
    );

    emit(OnAlarmItemSelectedState());
  }

  void onCancelSetAlarmSelected(BuildContext context) {
    Navigator.pop(context);
    emit(CancelSetAlarmState());
  }

/*****************************************************************************************************/
/// ****************************************************************************************************
  Future<void> onSaveSetAlarmSelected(
    BuildContext context,
  ) async {
    insertData(item);
    await alarmRepository.insertAlarms(item).then((value) {
     // checkRepeat(item);
    });
    Navigator.pop(context);
    emit(InsertNewAlarmState());
  }

  Future<void> onUpdateSetAlarmSelected(
      BuildContext context, AlarmDbModel currentItem) async {
    updateData(currentItem);
    await alarmRepository.updateAlarms(currentItem);
   // checkRepeat(currentItem);
    Navigator.pop(context);

    emit(UpdateNewAlarmState());
  }

  void changeIsSnoozing({AlarmDbModel? currentItem}) {
    isSnoozing = !isSnoozing;
    if (currentItem != null) {
      currentItem.isSnoozing.value = !currentItem.isSnoozing.value!;
    }
    emit(ChangeIsSnoozingState());
  }

  void changeIsSilent({AlarmDbModel? currentItem}) {
    isSilent = !isSilent;
    if (currentItem != null) {
      currentItem.isSilent.value = !currentItem.isSilent.value!;
    }

    emit(ChangeIsSilentState());
  }

  void changeIsRepeating({AlarmDbModel? currentItem}) {
    isRepeating = !isRepeating;
    if (currentItem != null) {
      //  currentItem.isRepeating.value = !currentItem.isRepeating.value!;

      emit(ChangeIsRepeatingState());
    }
  }

  void changeIsVibrating({AlarmDbModel? currentItem}) {
    isVibrating = !isVibrating;
    if (currentItem != null) {
      currentItem.isVibrate.value = !currentItem.isVibrate.value!;
    }
    print(item.notificationIds.value);
    emit(ChangeIsVibratingState());
  }

  void changeIsActive(AlarmDbModel currentItem) async {
    currentItem.isActive.value = !currentItem.isActive.value!;
    print(currentItem.notificationIds);

    if (currentItem.isActive.value == true) {
    //  checkRepeat(currentItem);
    } else {
    //  cancelNotifications(currentItem);
    }
    updateExistData(currentItem);
    emit(ChangeIsActiveState());
  }

  void changeSelectedTime(DateTime time, {AlarmDbModel? currentItem}) {
    selectedTime = time;
    if (currentItem != null) currentItem.dateTime.value = time;

    emit(ChangeSelectedTimeState());
  }

  void insertData(AlarmDbModel item) {
    item.isActive.value = isActive;
    item.dateTime.value = selectedTime;
    item.dayNumber.value = selectedTime.weekday;
    item.label.value = alarmLabelController.text;
    item.repeatQ.value = (repeatList!.isEmpty) ? [11] : repeatList;
    item.snoozeQ.value = (snoozeList!.isEmpty) ? [3] : snoozeList;
    item.ringtone.value =
        (ringtoneList!.isEmpty) ? "Ring" : ringtoneList!.first;
    item.ringtonePath.value =
        (ringtonePath == null) ? "assets/ring.mp3" : ringtonePath;

    emit(InsertPrimaryData());
  }

  void updateData(AlarmDbModel currentItem) {
    currentItem.isActive.value = true;
    currentItem.repeatQ.value = (repeatList!.isEmpty) ? [11] : repeatList;
    currentItem.snoozeQ.value = (snoozeList!.isEmpty) ? [3] : snoozeList;
    currentItem.ringtone.value =
        (ringtoneList!.isEmpty) ? "Ring" : ringtoneList!.first;
    currentItem.ringtonePath.value =
        (ringtonePath == null) ? "assets/ring.mp3" : ringtonePath;
    currentItem.dayNumber.value = currentItem.dateTime.value!.weekday;
    emit(UpdatePrimaryData());
  }

  void updateExistData(AlarmDbModel currentItem) {
    //update item in alarm screen not set screen
    alarmRepository.updateAlarms(currentItem);
    emit(UpdateAlarmItemState());
  }

  int remDays = 1;
  int remHours = 0;
  int remMinutes = 0;

  String? selectedAP;
  String? currentAP;

  void getSelectedAP(DateTime time) {
    String selectedFormatedTime =
        DateFormat('yyyy-MM-dd – kk:mm').add_jm().format(time);

    if (selectedFormatedTime.contains('P')) {
      selectedAP = selectedFormatedTime.split(' ')[4];
    } else if (selectedFormatedTime.contains('A')) {
      selectedAP = selectedFormatedTime.split(' ')[4];
    }
  }

  void getCurrentAP() {
    String currentFormatedTime =
        DateFormat('yyyy-MM-dd – kk:mm').add_jm().format(DateTime.now());

    if (currentFormatedTime.contains('P')) {
      currentAP = currentFormatedTime.split(' ')[4];
    } else if (currentFormatedTime.contains('A')) {
      currentAP = currentFormatedTime.split(' ')[4];
    }
  }

  void changeRemainingTime(DateTime time) {
    selectedTime = time;
    getSelectedAP(time);
    getCurrentAP();

    if (currentAP == selectedAP) {
      if (selectedTime.hour == now.hour) {
        remDays = 1;
        remHours = 0;
        remMinutes = 0;

        if (selectedTime.minute > now.minute) {
          remDays = 0;
          remHours = 0;
          remMinutes = selectedTime.minute - now.minute;
        } else if (selectedTime.minute < now.minute) {
          remDays = 0;
          remHours = 0;
          remMinutes = 60 - (now.minute - selectedTime.minute);
        }
      }

      if (selectedTime.hour > now.hour) {
        remDays = 0;
        remHours = (selectedTime.hour - now.hour);

        if (selectedTime.minute > now.minute) {
          remMinutes = selectedTime.minute - now.minute;
        } else if (selectedTime.minute < now.minute) {
          if (remHours > 0) {
            remHours--;
            remMinutes = 60 - (now.minute - selectedTime.minute);
          } else {
            remHours = 0;
            remMinutes = 60 - (now.minute - selectedTime.minute);
          }
        }
      }

      if (selectedTime.hour < now.hour) {
        remDays = 0;
        remHours = -(now.hour - selectedTime.hour - 12);

        if (selectedTime.minute > now.minute) {
          remMinutes = selectedTime.minute - now.minute;
        } else if (selectedTime.minute < now.minute) {
          if (remHours > 0) {
            remHours--;
            remMinutes = 60 - (now.minute - selectedTime.minute);
          } else {
            remHours = 0;
            remMinutes = 60 - (now.minute - selectedTime.minute);
          }
        }
      }
    } else /* if (currentAP != selectedAP) */ {
      if (selectedTime.hour == now.hour) {
        remDays = 0;
        remHours = 12;
        remMinutes = 0;

        if (selectedTime.minute > now.minute) {
          remDays = 0;
          remHours = 0;
          remMinutes = selectedTime.minute - now.minute;
        } else if (selectedTime.minute < now.minute) {
          remDays = 0;
          remHours = 0;
          remMinutes = 60 - (now.minute - selectedTime.minute);
        }
      }

      if (selectedTime.hour > now.hour) {
        remDays = 0;
        remHours = (selectedTime.hour - now.hour);

        if (selectedTime.minute > now.minute) {
          remMinutes = selectedTime.minute - now.minute;
        } else if (selectedTime.minute < now.minute) {
          if (remHours > 0) {
            remHours--;
            remMinutes = 60 - (now.minute - selectedTime.minute);
          } else {
            remHours = 0;
            remMinutes = 60 - (now.minute - selectedTime.minute);
          }
        }
      }

      if (selectedTime.hour < now.hour) {
        remDays = 0;
        remHours = -(now.hour - selectedTime.hour - 12);

        if (selectedTime.minute > now.minute) {
          remMinutes = selectedTime.minute - now.minute;
        } else if (selectedTime.minute < now.minute) {
          if (remHours > 0) {
            remHours--;
            remMinutes = 60 - (now.minute - selectedTime.minute);
          } else {
            remHours = 0;
            remMinutes = 60 - (now.minute - selectedTime.minute);
          }
        }
      }

      emit(ChangeRemainingTimeState());
    }
  }

  void deleteData(AlarmDbModel currentItem) {
    //cancelNotifications(currentItem);
    alarmRepository.deleteAlarms(currentItem);
    emit(DeleteItemState());
  }

  void showSavedData(AlarmDbModel currentItem) {
    isActive = currentItem.isActive.value!;
    selectedTime = currentItem.dateTime.value!;
    alarmLabelController.text = currentItem.label.value!;

    repeatList = currentItem.repeatQ.value!;
    snoozeList = currentItem.snoozeQ.value!;
    ringtoneList = [currentItem.ringtone.value!];
    ringtonePath = currentItem.ringtonePath.value;

    emit(ShowSavedDataState());
  }

  void changeAlarmLabel(String? value, AlarmDbModel currentItem) {
    currentItem.label.value = value;
    emit(ChangeAlarmLabel());
  }

  void onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  /// ****************************** Alarm Options  *******************************************

  List<AlarmOptionsModel>? optionsList = [];
  List<AlarmOptionsModel>? repeatOptionsList = [
    AlarmOptionsModel(title: 'Once', value: false),
    AlarmOptionsModel(title: 'Everyday', value: false),
    AlarmOptionsModel(title: 'Every Saturday', value: false),
    AlarmOptionsModel(title: 'Every Sunday', value: false),
    AlarmOptionsModel(title: 'Every Monday', value: false),
    AlarmOptionsModel(title: 'Every Tuesday', value: false),
    AlarmOptionsModel(title: 'Every Wendsday', value: false),
    AlarmOptionsModel(title: 'Every Thursday', value: false),
    AlarmOptionsModel(title: 'Every Friday', value: false),
  ];
  List<AlarmOptionsModel>? snoozeOptionsList = [
    AlarmOptionsModel(title: 'After 3 min', value: true),
    AlarmOptionsModel(title: 'After 5 min', value: false),
    AlarmOptionsModel(title: 'After 7 min', value: false),
    AlarmOptionsModel(title: 'After 10 min', value: false),
    AlarmOptionsModel(title: 'After 15 min', value: false),
    AlarmOptionsModel(title: 'After 30 min', value: false),
    AlarmOptionsModel(title: 'After 45 min', value: false),
    AlarmOptionsModel(title: 'After 60 min', value: false),
  ];
  List<AlarmOptionsModel>? ringtoneOptionsList = [
    AlarmOptionsModel(
        title: 'Hamsa Fagr',
        value: false,
        isPlaying: false,
        path: "assets/hamsa_fagr.mp3"),
    AlarmOptionsModel(
        title: 'Masr',
        value: false,
        isPlaying: false,
        path: "assets/misr_afasy.mp3"),
    AlarmOptionsModel(
        title: 'Ring', value: false, isPlaying: false, path: "assets/ring.mp3"),
    AlarmOptionsModel(
        title: 'From Files',
        value: false,
        isPlaying: false,
        path: "assets/ring.mp3"),
  ];

  void initializeOptionsList(String? optionId, {AlarmDbModel? currentItem}) {
    switch (optionId) {
      case 'Repeat':
        optionsList = repeatOptionsList;
        repeatAllDays = false;
         
      case 'Snooze':
        optionsList = snoozeOptionsList;
         
      case 'Ringtone':
        optionsList = ringtoneOptionsList;
         
    }

    if (repeatList!.isNotEmpty) {
      showSavedOptions(optionId!);
    }
    if (snoozeList!.isNotEmpty) {
      showSavedOptions(optionId!);
    }
    if (ringtoneList!.isNotEmpty) {
      showSavedOptions(optionId!);
    }
  }
  //5510
  //01004571469 mehna
  //

  void openOptionsScreen(BuildContext context, String optionId,
      {AlarmDbModel? currentItem}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) {
          return OptionsScreen(
            optionId,
            currentItem: currentItem,
          );
        }),
      ),
    );
  }

  void changeAlarmCheckBoxValue(String optionId, int position,
      {AlarmDbModel? currentItem}) {
    optionsList![position].value = !optionsList![position].value!;
    updateCheckedValues(optionId, position);
    fillList(optionId);
    emit(ChangeCheckBoxState());
  }

  void updateCheckedValues(String optionId, int position,
      {AlarmDbModel? currentItem}) {
    switch (optionId) {
      case 'Repeat':
        {
          if (position == 1 && optionsList![1].value == true) {
            for (var element in optionsList!) {
              if (element.title == 'Once') {
                element.value = false;
              } else {
                element.value = true;
                repeatAllDays = true;
              }
            }
          } else if (position == 1 && optionsList![1].value == false) {
            for (var element in optionsList!) {
              if (element.title == 'Once') {
                element.value = true;
              } else {
                element.value = false;
              }
            }
          } else if (position == 0 && optionsList![0].value == true) {
            for (var element in optionsList!) {
              if (element.title != 'Once') element.value = false;
            }
          } else if (position == 0 && optionsList![0].value == false) {
            for (var element in optionsList!) {
              if (element.title != 'Once') element.value = true;
            }
          } else if (optionsList!
                  .sublist(2, 8)
                  .every((element) => element.value!) ==
              true) {
            optionsList![0].value = false;
            optionsList![1].value = true;
          } else if (optionsList!
                  .sublist(2, 8)
                  .every((element) => element.value!) ==
              false) {
            optionsList![0].value = false;

            optionsList![1].value = false;
          }
          if (optionsList!.every((element) => element.value == false)) {
            optionsList![0].value = true;
          }
        } // end of repeat
         

      case 'Snooze':
        {
          return;
        }
         
      case 'Ringtone':
        {
          return;
        }
         
    }

    //emit(UpdateCheckedValuesState());  // لا تجوز شرعاً
  }

  void fillList(String optionId, {AlarmDbModel? currentItem, int? position}) {
    switch (optionId) {
      case 'Repeat':
        {
          if (optionsList![1].value == true) {
            repeatList = [1, 2, 3, 4, 5, 6, 7];
          } else if (optionsList![0].value == true) {
            repeatList = [11]; // means Once
          } else {
            for (int i = 2; i <= 8; i++) {
              if ((optionsList![i].value == true) &&
                  (!repeatList!.contains(
                      setAlarmWeekDay(optionsList![i].title!.substring(6))))) {
                repeatList!
                    .add(setAlarmWeekDay(optionsList![i].title!.substring(6)));
                print(repeatList);
              } else if ((optionsList![i].value == false) &&
                  (repeatList!.contains(
                      setAlarmWeekDay(optionsList![i].title!.substring(6))))) {
                repeatList!.remove(
                    setAlarmWeekDay(optionsList![i].title!.substring(6)));
              }
            }
            if (repeatList!.contains(11)) {
              repeatList!.remove(11);
            }
            /*   for alarm item in alarm screen   */ // (الجزء دا مش بيتنفذ هنا ليه؟)

            /*
            if ((repeatList!.length) == 1 && (repeatList!.first != 11)) {
              shownRepeatedDays = setAlarmWeekDayName(repeatList!.first);
              print("object");
              print(shownRepeatedDays);
              emit(ShowRepeatedDaysState());
            } else {
              shownRepeatedDays = "${repeatList!.length} Days";
              print("object2");
              print(shownRepeatedDays);
              emit(ShowRepeatedDaysState());
            }
            */
            // end
          }
          if (repeatList!.isNotEmpty) {
            repeatList!.sort();
          }
          print(repeatList);
        } // end of Repeat
         
      case 'Snooze':
        {
          if (snoozeList!.isEmpty || snoozeList == null) {
            snoozeList = [3];
          }
          for (var element in optionsList!) {
            if ((element.value == true) &&
                (!snoozeList!
                    .contains(int.parse(element.title!.split(" ")[1])))) {
              snoozeList!.add(int.parse(element.title!.split(" ")[1]));
            } else if ((element.value == false) &&
                (snoozeList!
                    .contains(int.parse(element.title!.split(" ")[1])))) {
              snoozeList!.remove(int.parse(element.title!.split(" ")[1]));
            }
          }
          if (snoozeList!.isNotEmpty) {
            snoozeList!.sort();
          }
          print(snoozeList);
        } // end of Snooze
         
      case 'Ringtone':
        {
          optionsList![2].value = false;
          for (var element in optionsList!) {
            if (element.value == true) {
              ringtoneList!.add(element.title);
              ringtonePath = element.path;
            } else {
              ringtoneList!.remove(element.title);
            }
          }

          if (ringtoneList!.isEmpty ||
              ringtoneList == null ||
              ringtoneList!.contains("From files")) {
            ringtoneList = [ringtoneOptionsList![2].title];
            optionsList![2].value = true;
          }
          if (ringtoneList!.length > 1) {
            ringtoneList!.remove("Ring");
          }

          print(ringtoneList);
        } //end of Ringtone
         
    }
  }

  int? setAlarmWeekDay(String alarmWeekDayName) {
    switch (alarmWeekDayName) {
      case "Monday":
        return 1;
      case "Tuesday":
        return 2;
      case "Wendsday":
        return 3;
      case "Thursday":
        return 4;
      case "Friday":
        return 5;
      case "Saturday":
        return 6;
      case "Sunday":
        return 7;
    }
    return null;
  }

  String? setAlarmWeekDayName(int alarmWeekDay) {
    switch (alarmWeekDay) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wendsday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
    }
    return null;
  }

  String getShownRepeatedDays(AlarmDbModel currentItem) {
    if ((currentItem.repeatQ.value!.length) == 1 &&
        (currentItem.repeatQ.value!.first == 11)) {
      emit(ShowRepeatedDaysState());
      return "Once";
    } else if ((currentItem.repeatQ.value!.length) == 1 &&
        (currentItem.repeatQ.value!.first != 11)) {
      emit(ShowRepeatedDaysState());
      return setAlarmWeekDayName(currentItem.repeatQ.value!.first)!;
    } else if (currentItem.repeatQ.value!.length == 7) {
      emit(ShowRepeatedDaysState());
      return "Everyday";
    } else {
      emit(ShowRepeatedDaysState());
      return "${currentItem.repeatQ.value!.length} Days";
    }
  }

  String? showOuterOption(
    String optionId,
  ) {
    switch (optionId) {
      case 'Repeat':
        {
          if (repeatList!.contains(11) || repeatList!.isEmpty) {
            emit(ShowOuterOptionsState());
            return "Once";
          } else if (repeatList!.length == 7) {
            emit(ShowOuterOptionsState());
            return "Everyday";
          } else if (repeatList!.length == 1 && !repeatList!.contains(11)) {
            emit(ShowOuterOptionsState());
            return setAlarmWeekDayName(repeatList!.first);
          } else {
            emit(ShowOuterOptionsState());
            return "Custom";
          }
        } // end of repeat
      case 'Snooze':
        {
          if (snoozeList!.length == 1) {
            emit(ShowOuterOptionsState());

            return snoozeList!.first.toString() + " min";
          } else if (snoozeList!.isEmpty) {
            return "3 min";
          } else {
            emit(ShowOuterOptionsState());

            return "Custom";
          }
        } // end of Snooze
         
      case 'Ringtone':
        {
          if (ringtoneList!.isEmpty || ringtoneList == null) {
            emit(ShowOuterOptionsState());
            return ringtoneOptionsList![2].title;
          }
          emit(ShowOuterOptionsState());
          return ringtoneList!.first;
        } //end of Ringtone
         
    }

    emit(ShowOuterOptionsState());
    return null;
  }

  void showSavedOptions(String optionId, {AlarmDbModel? currentItem}) {
    if (optionId == "Repeat") {
      if (repeatList!.contains(11) || repeatList!.isEmpty) {
        optionsList![0].value = true;
        for (var element in optionsList!) {
          if (element.title != "Once") {
            element.value = false;
          }
        }
      } else if (repeatList == [1, 2, 3, 4, 5, 6, 7]) {
        optionsList![0].value = false;

        for (var element in optionsList!) {
          if (element.title != "Once") {
            element.value = true;
          }
        }
      } else {
        optionsList![0].value = false;
        for (var element in repeatList!) {
          if (element == 1) {
            optionsList![4].value = true;
          } else if (element == 2) {
            optionsList![5].value = true;
          } else if (element == 3) {
            optionsList![6].value = true;
          } else if (element == 4) {
            optionsList![7].value = true;
          } else if (element == 5) {
            optionsList![8].value = true;
          } else if (element == 6) {
            optionsList![2].value = true;
          } else if (element == 7) {
            optionsList![3].value = true;
          }
        }
      }
    } // end of Repeat

    else if (optionId == "Snooze") {
      if (snoozeList!.length == 8) {
        for (var element in optionsList!) {
          element.value = true;
        }
      } else {
        for (var element in snoozeList!) {
          if (element == 3) {
            optionsList![0].value = true;
          } else if (element == 5) {
            optionsList![1].value = true;
          } else if (element == 7) {
            optionsList![2].value = true;
          } else if (element == 10) {
            optionsList![3].value = true;
          } else if (element == 15) {
            optionsList![4].value = true;
          } else if (element == 30) {
            optionsList![5].value = true;
          } else if (element == 45) {
            optionsList![6].value = true;
          } else if (element == 60) {
            optionsList![7].value = true;
          }
        }
      }
    } // end of Snooze

    else if (optionId == "Ringtone") {
      if ((ringtoneList!.length > 1) /* ||  (ringtoneList!.isEmpty)*/) {
        optionsList![2].value = false;
      }

      if (ringtoneList!.contains("Hamsa Fagr")) {
        optionsList![0].value = true;
      } else if (ringtoneList!.contains("Masr")) {
        optionsList![1].value = true;
      } else if (ringtoneList!.contains("Ring")) {
        optionsList![2].value = true;
      } else if (ringtoneList!.contains("From Files")) {
        optionsList![3].value = true;
      }

      if (sharedPreferences.getString("ringtoneFilePath") != null) {
        ringtoneFilePath = sharedPreferences.getString("ringtoneFilePath");
      }
    } // end of Ringtone
    emit(ShowSavedOptionsState());
  }

  void changeRingtone(int position, bool value, {AlarmDbModel? currentItem}) {
    for (int i = 0; i < optionsList!.length; i++) {
      if (i == position) {
        optionsList![i].value = true;
      } else {
        optionsList![i].value = false;
      }

      if (position == 3) {
        pickRingtoneFile();
      }
    }
    fillList("Ringtone", currentItem: currentItem);

    emit(ChangeRingtoneState());
  }

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  int? currentPlayingPosition;
  bool? isPlayingNow = false;

  void playRingtone(int position, String? path) {
    if ((position == 3) && (path == null)) {
   //  printToast("Select a ringtone from your files, first.");
    } else if (isPlayingNow!) {
      isPlayingNow = false;
      if (position == currentPlayingPosition) {
        optionsList![position].isPlaying = false;
        assetsAudioPlayer.pause();
      } else if (position != currentPlayingPosition) {
        assetsAudioPlayer.stop();
        optionsList![currentPlayingPosition!].isPlaying = false;
        optionsList![position].isPlaying = true;
        if (position == 3) {
          assetsAudioPlayer.open(Audio.file(path!)).then((value) {
            optionsList![3].isPlaying = true;
            isPlayingNow = true;
            currentPlayingPosition = 3;
          });
        } else {
          assetsAudioPlayer.open(Audio(path!)).then((value) {
            isPlayingNow = true;
            currentPlayingPosition = position;
            assetsAudioPlayer.play();
          });
        }
      }
    } else if (!isPlayingNow!) {
      optionsList![position].isPlaying = true;
      if (position == 3) {
        assetsAudioPlayer.open(Audio.file(path!)).then((value) {
          currentPlayingPosition = 3;

          optionsList![3].isPlaying = true;
          isPlayingNow = true;
        });
      } else {
        assetsAudioPlayer.open(Audio(path!)).then((value) {
          currentPlayingPosition = position;
          assetsAudioPlayer.play();
          isPlayingNow = true;
        });
      }
    }

    emit(PlayRingtoneState());
  }

  String? ringtoneFilePath;

  pickRingtoneFile() async {
    FilePicker.platform.clearTemporaryFiles();
    await Future.delayed(const Duration(seconds: 1), () {
      showIndicator = true;
      emit(OpenFileState());
    });

    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result == null) {
      showIndicator = false;
      emit(OpenFileState());
      return;
    } else {
      final file = result.files.first;
      OpenFile.open(file.path).then((value) async {
        ringtoneFilePath = file.path;
        sharedPreferences.setString("ringtoneFilePath", ringtoneFilePath!);
        await Future.delayed(const Duration(seconds: 8), () {
          showIndicator = false;
          emit(OpenFileState());
        });
      });
    }

    emit(OpenFileState());
  }

/*************************************************************************************************************** */
/// *************************************************************************************************************

  List<int>? notificationIds;
/// *************************************************************************************************************
/*
  void checkRepeat(AlarmDbModel item) {
    if (item.repeatQ.value!.contains(11)) {
      fireOnceAlarm(item);
    } else if (item.repeatQ.value!.length == 7) {
      fireEverydayAlarm(item);
    } else if (item.repeatQ.value!.isNotEmpty) {
      fireRepeatlyAlarm(item);
    }
  }
*/

/*
  fireOnceAlarm(AlarmDbModel item) {
    if ((DateTime.parse(item.dateTime.value.toString()).hour ==
            DateTime.now().hour) &&
        (DateTime.parse(item.dateTime.value.toString()).minute ==
            DateTime.now().minute)) {
      AndroidAlarmManager.oneShotAt(
          DateTime.parse(item.dateTime.value.toString()).add(const Duration(days: 1)),
          item.id.value!,
          fireAlarm,
          alarmClock: true,
          wakeup: true,
          rescheduleOnReboot: true);

      LocalNotifcationApi.createAlarmScheduledNotification(
          NotificationWeekAndTime(item.dayNumber.value!+1,
              DateTime.parse(item.dateTime.value.toString())),
          [
            item.id.value,
            "${item.label.value}",
            "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
            {"once": item.id.value.toString()},
            item.snoozeQ.value!.first.toString(),
          ],
          false);
    }

    else if((DateTime.parse(item.dateTime.value.toString()).hour <
            DateTime.now().hour)){
              AndroidAlarmManager.oneShotAt(
          DateTime.parse(item.dateTime.value.toString()).add(const Duration(days: 1)),
          item.id.value!,
          fireAlarm,
          alarmClock: true,
          wakeup: true,
          rescheduleOnReboot: true);

      LocalNotifcationApi.createAlarmScheduledNotification(
          NotificationWeekAndTime(item.dayNumber.value!+1,
              DateTime.parse(item.dateTime.value.toString())),
          [
            item.id.value,
            "${item.label.value}",
            "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
            {"once": item.id.value.toString()},
            item.snoozeQ.value!.first.toString(),
          ],
          false);
            }

            else{
              AndroidAlarmManager.oneShotAt(
          DateTime.parse(item.dateTime.value.toString()),
          item.id.value!,
          fireAlarm,
          alarmClock: true,
          wakeup: true,
          rescheduleOnReboot: true);

      LocalNotifcationApi.createAlarmScheduledNotification(
          NotificationWeekAndTime(item.dayNumber.value!,
              DateTime.parse(item.dateTime.value.toString())),
          [
            item.id.value,
            "${item.label.value}",
            "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
            {"once": item.id.value.toString()},
            item.snoozeQ.value!.first.toString(),
          ],
          false);
            }
            
  }
  */
/*
  fireEverydayAlarm(AlarmDbModel item) {
    DateTime t = DateTime.parse(item.dateTime.value.toString());
    notificationIds = [];

    newUniqueId = getUniqueId();
    notificationIds!.add(newUniqueId);
    AndroidAlarmManager.oneShotAt(t, newUniqueId, fireAlarm);

    LocalNotifcationApi.createAlarmScheduledNotification(
        NotificationWeekAndTime(1, t),
        [
          newUniqueId,
          "${item.label.value}",
          "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
          {"everyday": item.id.value.toString()},
          item.snoozeQ.value!.first.toString(),
        ],
        true);

    newUniqueId = getUniqueId();
    notificationIds!.add(newUniqueId);
    AndroidAlarmManager.oneShotAt(t, newUniqueId, fireAlarm);

    LocalNotifcationApi.createAlarmScheduledNotification(
        NotificationWeekAndTime(2, t),
        [
          newUniqueId,
          "${item.label.value}",
          "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
          {"everyday": item.id.value.toString()},
          item.snoozeQ.value!.first.toString(),
        ],
        true);

    newUniqueId = getUniqueId();
    notificationIds!.add(newUniqueId);
    AndroidAlarmManager.oneShotAt(t, newUniqueId, fireAlarm);

    LocalNotifcationApi.createAlarmScheduledNotification(
      NotificationWeekAndTime(3, t),
      [
        newUniqueId,
        "${item.label.value}",
        "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
        {"everyday": item.id.value.toString()},
        item.snoozeQ.value!.first.toString(),
      ],
      true,
    );
    newUniqueId = getUniqueId();
    notificationIds!.add(newUniqueId);
    AndroidAlarmManager.oneShotAt(t, newUniqueId, fireAlarm);

    LocalNotifcationApi.createAlarmScheduledNotification(
      NotificationWeekAndTime(4, t),
      [
        newUniqueId,
        "${item.label.value}",
        "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
        {"everyday": item.id.value.toString()},
        item.snoozeQ.value!.first.toString(),
      ],
      true,
    );

    newUniqueId = getUniqueId();
    notificationIds!.add(newUniqueId);
    AndroidAlarmManager.oneShotAt(t, newUniqueId, fireAlarm);

    LocalNotifcationApi.createAlarmScheduledNotification(
      NotificationWeekAndTime(5, t),
      [
        newUniqueId,
        "${item.label.value}",
        "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
        {"everyday": item.id.value.toString()},
        item.snoozeQ.value!.first.toString(),
      ],
      true,
    );

    newUniqueId = getUniqueId();
    notificationIds!.add(newUniqueId);
    AndroidAlarmManager.oneShotAt(t, newUniqueId, fireAlarm,
        rescheduleOnReboot: true);

    LocalNotifcationApi.createAlarmScheduledNotification(
        NotificationWeekAndTime(6, t),
        [
          newUniqueId,
          "${item.label.value}",
          "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
          {"everyday": item.id.value.toString()},
          item.snoozeQ.value!.first.toString(),
        ],
        true);

    newUniqueId = getUniqueId();
    notificationIds!.add(newUniqueId);
    AndroidAlarmManager.oneShotAt(t, newUniqueId, fireAlarm);

    LocalNotifcationApi.createAlarmScheduledNotification(
        NotificationWeekAndTime(7, t.add(const Duration(minutes: 2))),
        [
          newUniqueId,
          "${item.label.value}",
          "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
          {"everyday": item.id.value.toString()},
          item.snoozeQ.value!.first.toString(),
        ],
        true);
    item.notificationIds.value = notificationIds!;
    updateExistData(item);
  }
*/
/*
  fireRepeatlyAlarm(AlarmDbModel item) {
    notificationIds = [];

    for (var element in item.repeatQ.value!) {
      newUniqueId = getUniqueId();
      notificationIds!.add(newUniqueId);
      LocalNotifcationApi.createAlarmScheduledNotification(
          NotificationWeekAndTime(
              element, DateTime.parse(item.dateTime.value.toString())),
          [
            newUniqueId,
            "${item.label.value}",
            "${setAlarmWeekDayName(DateTime.now().weekday)}  ${item.dateTime.value!.hour}  :  ${item.dateTime.value!.minute}",
            {"repeat": item.id.value.toString()},
            item.snoozeQ.value!.first.toString(),
          ],
          true);
    }

    item.notificationIds.value = notificationIds!;
    updateExistData(item);
  }
*/

/*
  cancelNotifications(AlarmDbModel currentItem) async {
    if (currentItem.repeatQ.value!.contains(11)) {
      await AwesomeNotifications().dismiss(currentItem.id.value!);
      await AwesomeNotifications().cancel(currentItem.id.value!);
      await AwesomeNotifications().cancelSchedule(currentItem.id.value!);
      await AndroidAlarmManager.cancel(currentItem.id.value!);
    } else if (currentItem.repeatQ.value == [1, 2, 3, 4, 5, 6, 7]) {
      currentItem.notificationIds.value!.forEach((id) async {
        await AwesomeNotifications().dismiss(id);
        await AwesomeNotifications().cancel(id);
        await AwesomeNotifications().cancelSchedule(id);
        await AndroidAlarmManager.cancel(id);
      });
    } else {
      currentItem.notificationIds.value!.forEach((id) async {
        await AwesomeNotifications().dismiss(id);
        await AwesomeNotifications().cancel(id);
        await AwesomeNotifications().cancelSchedule(id);
        await AndroidAlarmManager.cancel(id);
      });
    }
  }
*/

  void selectDeselectItems(int position) {
    if (!selectionController.selectionAttached) {
      selectionController.select(position);
    } else if (selectionController.selectionAttached) {
      selectionController.select(position);
    }
    emit(SelectDeselectState());
  }

  bool? selected = false;
  void changeSelectionStatus() {
    if (!selected!) {
      selected = true;
    } else if ((selected!) &&
        (selectionController.getSelectedItems().length == 0)) {
      selectionController.selectAll();
    } else if ((selected!) &&
        (selectionController.getSelectedItems().length == alarms.length)) {
      selectionController.clearSelection();
    } else {
      selectionController.selectAll();
    }

    emit(ChangeSelectionStatus());
  }

  void deleteSelectedData() {
    if (selectionController.getSelectedItems().length == 0) {
      selected = false;
    } else if (selectionController.getSelectedItems().length == 1) {
      final currentItem = selectionController.getSelectedItems().first;
      alarms.remove(currentItem);
     // cancelNotifications(currentItem);
      alarmRepository.deleteAlarms(currentItem);
      selectionController.clearSelection();
      selected = false;
    } else {
      var selectedItems = selectionController.getSelectedItems();
      for (int i = 0; i < selectedItems.length; i++) {
        final currentItem = selectedItems[i];
        alarms.remove(currentItem);
     //   cancelNotifications(currentItem);
        alarmRepository.deleteAlarms(currentItem);
      }
      selectionController.clearSelection();

      selected = false;
    }

    emit(DeleteSelectedItemState());
  }
}

/********************************************************************************* */

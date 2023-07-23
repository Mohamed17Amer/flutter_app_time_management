import 'package:time_management/Alarm/data/models/alarm_db.dart';

class LocalStorageServices {  // Alarm Package
  AlarmDbProvider alarmDbProvider = AlarmDbProvider();
  List<AlarmDbModel>? alarms = [];

  Future<void> insert(AlarmDbModel item) async {
    await alarmDbProvider.insertEntry(item).then((value) {
      print("insert item  $value   $item");
    }).catchError((error) {
      print("insert error  $error");
    });
  }

  Future<void> update(AlarmDbModel currentItem) async {
    await alarmDbProvider.updateEntry(currentItem).then((value) {
      print("update item  $value   $currentItem");
    }).catchError((error) {
      print("update error  $error");
    });
  }

  Future<void> delete(AlarmDbModel currentItem) async {
    await alarmDbProvider.deleteEntry(currentItem).then((value) {
      print("delete item  $value  $currentItem");
    }).catchError((onError) {
      print("deletion error $onError");
    });
  }

  Future<List<AlarmDbModel>?> retrieve() async {
    await alarmDbProvider.select().then((value) {
    //  print("retrieve items  $value");
      alarms = value;
   //   print("retrieve alarms  $alarms");
      //return alarms;
    }).catchError((onError) {
   //   print("retrieve error $onError");
    });
  //  print("retrieve alarms2  $alarms");

    return alarms;
  }
}

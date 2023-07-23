import 'package:time_management/Alarm/data/models/alarm_db.dart';
import 'package:time_management/Alarm/data/source/local_storage_services.dart';

class AlarmRepository {
  LocalStorageServices localStorageServices = LocalStorageServices();
  List<AlarmDbModel>? alarms;
  AlarmDbModel? itemToInserOrUpdateOrDelete;

  Future<List<AlarmDbModel>?> getAlarms() async {
    await localStorageServices.retrieve().then((value) {
    //  print("get repo items  $value");
      alarms = value;
   //   print("get  repo alarms  $alarms");
      //   return alarms;
    }).catchError((onError) {
  //    print("get repo error  $onError");
    });
  //  print("get  repo alarms 2  $alarms");

    return alarms;
  }

  Future<void> insertAlarms(AlarmDbModel item) async {
    itemToInserOrUpdateOrDelete = item;
    await localStorageServices.insert(itemToInserOrUpdateOrDelete!);
  }

  Future<void> updateAlarms(AlarmDbModel currentItem) async {
    itemToInserOrUpdateOrDelete = currentItem;
    await localStorageServices.update(itemToInserOrUpdateOrDelete!);
  }

  Future<void> deleteAlarms(AlarmDbModel currentItem) async {
    itemToInserOrUpdateOrDelete = currentItem;
    // alarms!.remove(itemToInserOrUpdateOrDelete);
    await localStorageServices.delete(itemToInserOrUpdateOrDelete!);
  }
}

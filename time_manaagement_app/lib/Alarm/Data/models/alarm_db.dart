import 'package:quds_db/quds_db.dart';

class AlarmDbModel extends DbModel {
  StringField label = StringField(columnName: 'Label');
  BoolField isActive = BoolField(columnName: 'IsActive');

  ListField repeatQ = ListField(columnName: 'RepeatQ');
  BoolField isRepeating = BoolField(columnName: 'IsRepeating');

  ListField snoozeQ = ListField(columnName: 'SnoozeQ');
  BoolField isSnoozing = BoolField(columnName: 'IsSnoozing');

  StringField ringtone = StringField(columnName: 'Ringtone');
  StringField ringtonePath = StringField(columnName: 'RingtonePath');

  BoolField isExternalRingtone = BoolField(columnName: 'IsExternalRingtone');
  BoolField isSilent = BoolField(columnName: 'IsSilent');
  BoolField isVibrate = BoolField(columnName: 'IsVibrate');

  StringField remainingTime = StringField(columnName: 'RemainingTime');

  StringField date = StringField(columnName: 'Date');
  StringField time = StringField(columnName: 'Time');
  DateTimeStringField dateTime = DateTimeStringField(columnName: 'DateTime');
  DateTimeStringField nextAlarm = DateTimeStringField(columnName: 'NextAlarm');
  StringField day = StringField(columnName: 'Day');
  IntField dayNumber = IntField(columnName: 'DayNumber');

  ListField notificationIds= ListField(columnName: 'NotificationId');





  @override
  List<FieldWithValue>? getFields() {
    return [
      label,
      isActive,
      repeatQ,
      isRepeating,
      snoozeQ,
      isSnoozing,
      ringtone,
      isExternalRingtone,
      isSilent,
      isVibrate,
      remainingTime,
      date,
      time,
      dateTime,
      nextAlarm,
      day,
      dayNumber,
      notificationIds
    ];
  }
}

class AlarmDbProvider extends DbTableProvider<AlarmDbModel> {
  AlarmDbProvider() : super(() => AlarmDbModel());

  @override
  String get tableName => 'Alarms';
}

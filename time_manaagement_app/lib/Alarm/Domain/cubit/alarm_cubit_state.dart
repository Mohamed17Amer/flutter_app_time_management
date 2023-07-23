part of 'alarm_cubit.dart';

@immutable
abstract class AlarmCubitState {}

class AlarmCubitInitial extends AlarmCubitState {}

class AlarmsLoadedState extends AlarmCubitState{}

class SuccessState extends AlarmCubitState{}

class AddNewAlarmState extends AlarmCubitState{}
class CancelSetAlarmState extends AlarmCubitState{}

class OnAlarmItemSelectedState extends AlarmCubitState{}
class ShowRepeatedDaysState extends AlarmCubitState{}

class InsertNewAlarmState extends AlarmCubitState{}
class UpdateNewAlarmState extends AlarmCubitState{}
class InsertPrimaryData extends AlarmCubitState{}
class UpdatePrimaryData extends AlarmCubitState{}
class UpdateAlarmItemState extends AlarmCubitState{}
class DeleteItemState extends AlarmCubitState{}
class ShowSavedDataState extends AlarmCubitState{}
class GetAlarmsState extends AlarmCubitState{}

class ChangeIsVibratingState extends AlarmCubitState{}
class ChangeIsRepeatingState extends AlarmCubitState{}
class ChangeIsSilentState extends AlarmCubitState{}
class ChangeIsSnoozingState extends AlarmCubitState{}
class ChangeAlarmLabel extends AddNewAlarmState{}

class ChangeSelectedTimeState extends AlarmCubitState{}
class ChangeRemainingTimeState extends AlarmCubitState{}
class ChangeIsActiveState extends AlarmCubitState{}

class ChangeCheckBoxState extends AlarmCubitState{}
class UpdateCheckedValuesState extends AlarmCubitState{}
class ShowOuterOptionsState extends AlarmCubitState{}
class ShowSavedOptionsState extends AlarmCubitState{}
class ChangeRingtoneState extends AlarmCubitState{}

///////////
class PlayRingtoneState extends AlarmCubitState{}
class OpenFileState extends AlarmCubitState{}

class SelectDeselectState extends AlarmCubitState{}
class ChangeSelectionStatus extends AlarmCubitState{}
class DeleteSelectedItemState extends AlarmCubitState{}

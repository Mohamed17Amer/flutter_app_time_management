import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:time_management/Alarm/data/models/alarm_db.dart';
import 'package:time_management/Alarm/domain/cubit/alarm_cubit.dart';
import 'package:time_management/App/shared_variables.dart';

class OptionsWidgets {
 // PremiumVersionWidgets premiumVersionWidgets = PremiumVersionWidgets();

  Widget alarmOptionsItem(BuildContext context, int position, String optionId,
      {AlarmDbModel? currentItem}) {
    switch (optionId) {
      case 'Repeat':
        return alarmRepeatSnoozeItem(context, position, optionId);

      case 'Snooze':
        return alarmRepeatSnoozeItem(context, position, optionId);
      case 'Ringtone':
        return alarmRingtoneItem(context, position, optionId);
    }
    return Container();
  }

  alarmRepeatSnoozeItem(BuildContext context, int position, String optionId,
      {AlarmDbModel? currentItem}) {
    return CheckboxListTile(
      checkColor:                  (isDark!)?Colors.white: Colors.blue,
      activeColor: Colors.black,
      title: Text(
        AlarmCubit.getAlarmCubit(context).optionsList![position].title!,
        style: TextStyle(color:(isDark!) ?Colors.white:Colors.blue, fontSize: 18),
      ),
      value: AlarmCubit.getAlarmCubit(context).optionsList![position].value,
      onChanged: (value) {
        if ((currentItem != null)) {
          AlarmCubit.getAlarmCubit(context).changeAlarmCheckBoxValue(
              optionId, position,
              currentItem: currentItem);
          AlarmCubit.getAlarmCubit(context)
              .updateCheckedValues(optionId, position);
        } else {
          AlarmCubit.getAlarmCubit(context)
              .changeAlarmCheckBoxValue(optionId, position);
          //  AlarmCubit.getAlarmCubit(context).fillList(optionId);
        }
      },
    );
  }

  Widget alarmRingtoneItem(BuildContext context, int position, String optionId,
      {AlarmDbModel? currentItem}) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(
              AlarmCubit.getAlarmCubit(context).optionsList![position].title!,
              style: TextStyle(
color:(isDark!)?Colors.white:Colors.blue,
                fontSize: 18,
              ),
            ),
            value: true,
            groupValue:
                AlarmCubit.getAlarmCubit(context).optionsList![position].value,
            onChanged: (value) async {
              if (currentItem != null) {
                AlarmCubit.getAlarmCubit(context).changeRingtone(
                    position, value as bool,
                    currentItem: currentItem);
              } else {
                AlarmCubit.getAlarmCubit(context)
                    .changeRingtone(position, value as bool);
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(
            (AlarmCubit.getAlarmCubit(context)
                        .optionsList![position]
                        .isPlaying ==
                    false)
                ? Icons.play_arrow
                : Icons.pause_circle,
            size: 30,
            color:(isDark!)?Colors.white: Colors.blue,
          ),
          onPressed: () {
            if(position==3){
              AlarmCubit.getAlarmCubit(context).playRingtone(position,
                AlarmCubit.getAlarmCubit(context).ringtoneFilePath);

            }
            else {
              AlarmCubit.getAlarmCubit(context).playRingtone(position,
                AlarmCubit.getAlarmCubit(context).optionsList![position].path);
            }
          },
        ),
      ],
    );
  }

  Widget drawPremiumVersionAlarmOptions(BuildContext context, String optionId,
      {AlarmDbModel? currentItem}) {
    if ((optionId == "Ringtone") && (currentItem == null)) {
      return Column(
        children: [
          const Center(
            child: SizedBox(
              width: 300,
              child: Text(
                "  You can select a file ringtone in the PREMIUM V.  You can buy it now ${Emojis.activites_ribbon}  ",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red
                ),
              ),
            ),
          ),
         // premiumVersionWidgets.sendMeToBuyWdget(context),
          const SizedBox(height: 20,),
          (showIndicator)? const CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Colors.red,
            strokeWidth: 6.0,
            semanticsValue: "Load a Ringtone",
            semanticsLabel: "Ringtone",
          ): Container(),
        ],
      );
    }
    else if(optionId=="Snooze"){
       return Column(
        children: [
          const SizedBox(height: 10,),
          const Center(
            child: SizedBox(
              width: 300,
              child: Text(
                " We will take only the minimum snooze that you select, You can select multiple snooze in the PREMIUM V.  You can buy it now ${Emojis.activites_ribbon}  ",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red
                ),
              ),
            ),
          ),
         // premiumVersionWidgets.sendMeToBuyWdget(context)
        ],
      );
    } 

    return Container();
  }
}

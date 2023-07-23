import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_management/Alarm/data/models/alarm_db.dart';
import 'package:time_management/Alarm/domain/cubit/alarm_cubit.dart';
import 'package:time_management/Alarm/presentation/clock.dart';
import 'package:time_management/App/shared_variables.dart';

class SetUpdateAlarmWidgets {
//  final PremiumVersionWidgets _premiumVersionWidgets = PremiumVersionWidgets();

  Widget drawAlarmClock(BuildContext context, {AlarmDbModel? currentItem}) {
    return BlocConsumer<AlarmCubit, AlarmCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return CustomTimePickerSpinner(
          is24HourMode: false,
          isForce2Digits: true,
          itemWidth: 45.0,
          itemHeight: 40,
          spacing: 50,
          normalTextStyle:  TextStyle(
            fontSize: 20,
            color:(isDark!)?Colors.grey: Colors.grey,
            textBaseline: TextBaseline.alphabetic,
          ),
          highlightedTextStyle:  TextStyle(
            fontSize: 24,
            color:(isDark!)?Colors.deepOrange: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
          time: AlarmCubit.getAlarmCubit(context).selectedTime,
          onTimeChange: (time) {
            (currentItem == null)
                ? AlarmCubit.getAlarmCubit(context).changeSelectedTime(time)
                : AlarmCubit.getAlarmCubit(context)
                    .changeSelectedTime(time, currentItem: currentItem);
            AlarmCubit.getAlarmCubit(context).changeRemainingTime(time);
            print(AlarmCubit.getAlarmCubit(context).selectedTime);
          },
          alignment: AlignmentDirectional.bottomCenter,
        );
      },
    );
  }

  drawSetAlarmAppBar(
      BuildContext context, String pageId, GlobalKey<FormState> setAlarmFormKey,
      {AlarmDbModel? currentItem}) {
    return AppBar(
      centerTitle: true,
      backgroundColor:(isDark!)?Colors.grey.shade900: Colors.blue[50],
      leadingWidth: 180.0,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 8.0, top: 16),
        child: InkWell(
          child:  Text(
            '   Cancel',
            style: TextStyle(
              color:(isDark!)?Colors.deepOrange: Colors.blue,
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      title:  Text(
        'Set Alarm',
        style: TextStyle(
          color:(isDark!)?Colors.grey:Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0, top: 16),
          child: InkWell(
            child: Text(
              '$pageId   ',
              style:  TextStyle(
                color:(isDark!)?Colors.deepOrange: Colors.blue,
                fontSize: 20,
              ),
            ),
            onTap: () {
              if (setAlarmFormKey.currentState!.validate()) {
                (currentItem == null)
                    ? AlarmCubit.getAlarmCubit(context)
                        .onSaveSetAlarmSelected(context)
                    : AlarmCubit.getAlarmCubit(context)
                        .onUpdateSetAlarmSelected(context, currentItem);
              }
            },
          ),
        ),
      ],
    );
  }

  drawSetAlarmBody(BuildContext context, {AlarmDbModel? currentItem}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsetsDirectional.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color:(isDark!)?Colors.black: Colors.blue[100],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 12.0, end: 4.0, top: 12.0, bottom: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocConsumer<AlarmCubit, AlarmCubitState>(
              listener: (context, state) {
                 
              },
              builder: (context, state) {
                return TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Alarm',
                  ),
                  maxLines: 2,
                  maxLength: 15,
                  controller:
                      AlarmCubit.getAlarmCubit(context).alarmLabelController,
                  validator: (value) {
                    if (currentItem != null) {
                      AlarmCubit.getAlarmCubit(context)
                          .changeAlarmLabel(value, currentItem);
                    }
                    //AlarmCubit.getAlarmCubit(context).alarmLabelController.text;
                    if (value!.isEmpty) {
                      AlarmCubit.getAlarmCubit(context)
                          .alarmLabelController
                          .text = 'Alarm';
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),

            /***************************************************************************************/

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Repeat',
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                  child: Row(
                    children: [
                      BlocConsumer<AlarmCubit, AlarmCubitState>(
                        listener: (context, state) {
                           
                        },
                        builder: (context, state) {
                          return Text(
                            AlarmCubit.getAlarmCubit(context)
                                .showOuterOption("Repeat")!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey),
                          );
                        },
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        size: 30,
                      ),
                    ],
                  ),
                  onTap: () {
                    AlarmCubit.getAlarmCubit(context)
                        .openOptionsScreen(context, "Repeat");
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Snooze',
                  style: TextStyle(fontSize: 20),
                ),
                BlocConsumer<AlarmCubit, AlarmCubitState>(
                  listener: (context, state) {
                     
                  },
                  builder: (context, state) {
                    return AbsorbPointer(
                      absorbing: (currentItem != null) ? true : false,
                      child: IconButton(
                        icon: const Icon(Icons.snooze),
                        iconSize: 30,
                        color: (AlarmCubit.getAlarmCubit(context).isSnoozing ==
                                false)
                            ? Colors.grey
                            :(isDark!) ? Colors.deepOrange : Colors.blue,
                        onPressed: () {
                          (currentItem == null)
                              ? AlarmCubit.getAlarmCubit(context)
                                  .changeIsSnoozing()
                              : AlarmCubit.getAlarmCubit(context)
                                  .changeIsSnoozing(currentItem: currentItem);
                          print(AlarmCubit.getAlarmCubit(context).isSnoozing);
                        },
                      ),
                    );
                  },
                ),
                InkWell(
                  child: Row(
                    children: [
                      BlocConsumer<AlarmCubit, AlarmCubitState>(
                        listener: (context, state) {
                           
                        },
                        builder: (context, state) {
                          return Text(
                            AlarmCubit.getAlarmCubit(context)
                                .showOuterOption("Snooze")!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey),
                          );
                        },
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        size: 30,
                      ),
                    ],
                  ),
                  onTap: () {
                    AlarmCubit.getAlarmCubit(context)
                        .openOptionsScreen(context, "Snooze");
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ringtone',
                  style: TextStyle(fontSize: 20),
                ),
                BlocConsumer<AlarmCubit, AlarmCubitState>(
                  listener: (context, state) {
                  },
                  builder: (context, state) {
                    return AbsorbPointer(
                      absorbing: (currentItem != null) ? true : false,
                      child: IconButton(
                          icon: Icon(
                            Icons.voice_over_off,
                            size: 30,
                            color:
                                (AlarmCubit.getAlarmCubit(context).isSilent ==
                                        false)
                                    ? Colors.grey
                                    :(isDark!) ? Colors.deepOrange : Colors.blue,
                          ),
                          onPressed: () {
                            (currentItem == null)
                                ? AlarmCubit.getAlarmCubit(context)
                                    .changeIsSilent()
                                : AlarmCubit.getAlarmCubit(context)
                                    .changeIsSilent(currentItem: currentItem);
                          }),
                    );
                  },
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      BlocConsumer<AlarmCubit, AlarmCubitState>(
                        listener: (context, state) {
                           
                        },
                        builder: (context, state) {
                          return Text(
                            AlarmCubit.getAlarmCubit(context)
                                .showOuterOption("Ringtone")!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey),
                          );
                        },
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        size: 30,
                      ),
                    ],
                  ),
                  onTap: () {
                    (currentItem == null)
                        ? AlarmCubit.getAlarmCubit(context)
                            .openOptionsScreen(context, "Ringtone")
                        : AlarmCubit.getAlarmCubit(context).openOptionsScreen(
                            context, "Ringtone",
                            currentItem: currentItem);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Vibration   ',
                  style: TextStyle(fontSize: 20),
                ),
                BlocConsumer<AlarmCubit, AlarmCubitState>(
                  listener: (context, state) {
                     
                  },
                  builder: (context, state) {
                    return AbsorbPointer(
                      absorbing: (currentItem != null) ? true : false,
                      child: IconButton(
                        icon: const Icon(Icons.vibration),
                        iconSize: 30,
                        color: (AlarmCubit.getAlarmCubit(context).isVibrating ==
                                false)
                            ? Colors.grey
                            :(isDark!) ? Colors.deepOrange : Colors.blue,
                        onPressed: () {
                          (currentItem == null)
                              ? AlarmCubit.getAlarmCubit(context)
                                  .changeIsVibrating()
                              : AlarmCubit.getAlarmCubit(context)
                                  .changeIsVibrating(currentItem: currentItem);
                        },
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Text(
                        'Vibrate ',
                        style: TextStyle(fontSize: 20, color:(isDark!)?Colors.black: Colors.blue[100]),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_sharp,
                        size: 30,
                        color:(isDark!)?Colors.black: Colors.blue[100],
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
         //   (currentItem == null)
               // ? _premiumVersionWidgets.drawPremiumVersionSetAlarmIcon(context)
             //   : Container(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_management/Alarm/data/models/alarm_db.dart';
import 'package:time_management/Alarm/domain/cubit/alarm_cubit.dart';
import 'package:time_management/Alarm/presentation/widgets/alarm_widgets.dart';
import 'package:time_management/Alarm/presentation/widgets/options_widgets.dart';
import 'package:time_management/Alarm/presentation/widgets/set_update_alarm_widgets.dart';
import 'package:time_management/App/shared_variables.dart';

class OptionsScreen extends StatelessWidget {
  OptionsScreen(this.optionId, {super.key, this.currentItem});
  String? optionId;
  AlarmDbModel? currentItem;
  final AlarmWidgets alarmWidgets = AlarmWidgets();

  final SetUpdateAlarmWidgets _setUpdateAlarmWidgets = SetUpdateAlarmWidgets();
  final OptionsWidgets _optionsWidgets = OptionsWidgets();

  @override
  Widget build(BuildContext context) {
    print(currentItem);
    return BlocProvider(
      create: (context) => AlarmCubit()
        ..initializeOptionsList(optionId!, currentItem: currentItem),
      child: BlocConsumer<AlarmCubit, AlarmCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor:(isDark!)?Colors.grey.shade900:Colors.blue[50],
            appBar: AppBar(
              title: Text(
                "|" + optionId!,
                style:  TextStyle(
                  color:(isDark!)?Colors.white: Colors.blue,
                ),
              ),
              iconTheme: IconThemeData(
                  color:(isDark!)?Colors.white: Colors.blue,
              ),
              backgroundColor:(isDark!)?Colors.grey.shade900: Colors.blue[50],
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  AlarmCubit.getAlarmCubit(context)
                      .onBackButtonPressed(context);
                },
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: ((optionId == "Ringtone") && (currentItem == null))
                      ? MediaQuery.of(context).size.height * .4
                      : (optionId == "Snooze")
                          ? MediaQuery.of(context).size.height * .6
                          : MediaQuery.of(context).size.height * .8,
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 16, end: 12),
                        child: (currentItem == null)
                            ? _optionsWidgets.alarmOptionsItem(
                                context, position, optionId!)
                            : _optionsWidgets.alarmOptionsItem(
                                context, position, optionId!,
                                currentItem: currentItem),
                      );
                    },
                    itemCount: ((optionId == "Ringtone") &&
                            (currentItem != null))
                        ? 3
                        : AlarmCubit.getAlarmCubit(context).optionsList!.length,
                  ),
                ),
                Expanded(
                  child: _optionsWidgets.drawPremiumVersionAlarmOptions(
                      context, optionId!,
                      currentItem: currentItem),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

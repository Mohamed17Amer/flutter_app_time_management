import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_management/Alarm/Domain/cubit/alarm_cubit.dart';
import 'package:time_management/Alarm/Presentation/widgets/alarm_widgets.dart';
import 'package:time_management/App/shared_variables.dart';

class Alarms extends StatelessWidget {
  AlarmWidgets alarmWidgets = AlarmWidgets();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AlarmCubit, AlarmCubitState>(
        listener: (context, state) {
          BlocProvider.of<AlarmCubit>(context).getAlarms();
        },
        builder: (context, state) {
          return Scaffold(
          
            backgroundColor:(isDark!)?Colors.grey.shade900: Colors.white,
            appBar: (BlocProvider.of<AlarmCubit>(context).alarms.isEmpty)
                ? alarmWidgets.drawEmptyAppBar(context)
                : alarmWidgets.drawAppBar(context),
            body: (BlocProvider.of<AlarmCubit>(context).alarms.isEmpty)
                ? alarmWidgets.drawEmptybody(context)
                : alarmWidgets.drawBody(context),
          );
        },
      );
  }
}
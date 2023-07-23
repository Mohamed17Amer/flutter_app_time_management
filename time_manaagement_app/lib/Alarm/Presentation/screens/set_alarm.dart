import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_management/Alarm/data/models/alarm_db.dart';
import 'package:time_management/Alarm/domain/cubit/alarm_cubit.dart';
import 'package:time_management/Alarm/presentation/widgets/alarm_widgets.dart';
import 'package:time_management/Alarm/presentation/widgets/set_update_alarm_widgets.dart';
import 'package:time_management/App/shared_variables.dart';

class SetAlarm extends StatelessWidget {
  late String pageId;
  final AlarmWidgets _alarmWidgets = AlarmWidgets();
  final SetUpdateAlarmWidgets _setUpdateAlarmWidgets = SetUpdateAlarmWidgets();
  //final PremiumVersionWidgets _premiumVersionWidgets=PremiumVersionWidgets();
  final setAlarmFormKey = GlobalKey<FormState>();

  AlarmDbModel? currentItem;
  SetAlarm(this.pageId, {Key? key, this.currentItem}) : super(key: key) {
    if(currentItem==null){
    
    repeatList = [];
    snoozeList = [];
    ringtoneList = ['Ring'];  
    }else{
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AlarmCubit>(context),
     
      child: BlocConsumer<AlarmCubit, AlarmCubitState>(
          listener: (context, state) {},
          builder: (context, state) {
              if (currentItem != null) {
         //  BlocProvider.of<AlarmCubit>(context).showSavedData(currentItem!);
          } else {
       //     BlocProvider.of<AlarmCubit>(context);
          }
            return Scaffold(
              backgroundColor:(isDark!)?Colors.grey.shade900: Colors.blue[50],
              appBar: _setUpdateAlarmWidgets.drawSetAlarmAppBar(
                  context, pageId, setAlarmFormKey, currentItem: currentItem),
              body: SingleChildScrollView(
                child: Form(
                  key: setAlarmFormKey,
                  child: Column(
                    children: [
                      _alarmWidgets.horizontalDivider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        AlarmCubit.getAlarmCubit(context).remDays.toString() +
                            ' days  ' +
                            AlarmCubit.getAlarmCubit(context)
                                .remHours
                                .toString() +
                            ' hours  ' +
                            AlarmCubit.getAlarmCubit(context)
                                .remMinutes
                                .toString() +
                            ' minutes  ',
                        style: TextStyle(
                          color:(isDark!)?Colors.deepOrange: Colors.blueAccent[200],
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _setUpdateAlarmWidgets.drawAlarmClock(context, currentItem: currentItem),
                      const SizedBox(
                        height: 20,
                      ),
                      (currentItem == null)
                          ? _setUpdateAlarmWidgets.drawSetAlarmBody(context)
                          : _setUpdateAlarmWidgets.drawSetAlarmBody(context,
                              currentItem: currentItem),
    
    
    
                    ],
                  ),
                ),
              ),
            );
          },
        ),
    );
    
  }
}

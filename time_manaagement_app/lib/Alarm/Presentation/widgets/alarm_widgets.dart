import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_management/Alarm/data/models/alarm_db.dart';
import 'package:time_management/Alarm/domain/cubit/alarm_cubit.dart';
import 'package:time_management/Alarm/presentation/custom_digital_clock.dart';
import 'package:multiselect_scope/multiselect_scope.dart';
import 'package:time_management/App/reusable_components.dart';
import 'package:time_management/App/shared_variables.dart';


class AlarmWidgets {
  Widget drawItem(
      BuildContext context, AlarmDbModel currentItem, int position) {
  /*  BlocProvider.of<AlarmCubit>(context).selectionController =
        MultiselectScope.controllerOf(context);
        
    final itemIsSelected = BlocProvider.of<AlarmCubit>(context)
        .selectionController
        .isSelected(position);

    return InkWell(
      onTap: () {
        if (!BlocProvider.of<AlarmCubit>(context).selected!) {
          BlocProvider.of<AlarmCubit>(context)
              .onAlarmItemSelected(context, currentItem);
        } else {
          BlocProvider.of<AlarmCubit>(context).selectDeselectItems(position);
        }
      },
      onLongPress: () {
        BlocProvider.of<AlarmCubit>(context).selected = true;
        BlocProvider.of<AlarmCubit>(context).selectDeselectItems(position);
      },
      child:
      */
      return Card(
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.black,
          //elevation: 10,
          child: Container(
            color:Theme.of(context).primaryColor,// itemIsSelected ? Theme.of(context).primaryColor : null,
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsetsDirectional.only(
                start: 8, end: 8, top: 12, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //fist
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                //    drawDigitalClock(currentItem.dateTime.value!),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        currentItem.label.value!,
                        style: TextStyle(
                          color: (isDark!) ? Colors.deepOrange : Colors.black,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle_sharp,
                          color: Colors.purple[700],
                          size: 30,
                        ),
                        onPressed: () {
                          if (!BlocProvider.of<AlarmCubit>(context).selected!) {
                            //alarms.remove(currentItem);
                            BlocProvider.of<AlarmCubit>(context)
                                .deleteData(currentItem);
                          } else {
                            BlocProvider.of<AlarmCubit>(context)
                                .selectDeselectItems(position);
                          }
                        },
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Transform.translate(
                  offset: const Offset(0, -35),
                  child: Text(
                    BlocProvider.of<AlarmCubit>(context)
                        .getShownRepeatedDays(currentItem),
                    style: TextStyle(
                      color: (isDark!) ? Colors.deepOrange : Colors.blue,
                      fontSize: 28,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -35),
                  child: IconButton(
                    icon: Icon(
                      Icons.alarm,
                      size: 32,
                      color: (currentItem.isActive.value == true)
                          ? (isDark!)
                              ? Colors.deepOrange
                              : Colors.blue
                          : Colors.grey,
                    ),
                    onPressed: () {
                      /*
                      if (!BlocProvider.of<AlarmCubit>(context).selected!) {
                        BlocProvider.of<AlarmCubit>(context)
                            .changeIsActive(currentItem);
                        BlocProvider.of<AlarmCubit>(context)
                            .updateExistData(currentItem);
                      } else {
                        BlocProvider.of<AlarmCubit>(context)
                            .selectDeselectItems(position);
                      }
                      */
                    },
                  ),
                ),
              ],
            ),
          ));
    
  }
/*
  drawDigitalClock(DateTime selectedTime) {
    return CustomDigitalClock(
      myTime: selectedTime,
      is24HourTimeFormat: false,
      showSecondsDigit: false,
      areaWidth: 180.0,
      areaHeight: 70.0,
      areaDecoration: BoxDecoration(
          border: Border.all(
            color: (isDark!) ? Colors.orange : Colors.blue,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent),
      areaAligment: AlignmentDirectional.center,
      hourMinuteDigitDecoration:
          BoxDecoration(border: null, borderRadius: BorderRadius.circular(5)),
      secondDigitDecoration:
          BoxDecoration(border: null, borderRadius: BorderRadius.circular(5)),
      digitAnimationStyle: Curves.decelerate,
      hourMinuteDigitTextStyle: TextStyle(
          color: (isDark!) ? Colors.deepOrange : Colors.black, fontSize: 30),
      secondDigitTextStyle: TextStyle(
          color: (isDark!) ? Colors.deepOrange : Colors.black, fontSize: 15),
      amPmDigitTextStyle: TextStyle(
          color: (isDark!) ? Colors.deepOrange : Colors.black, fontSize: 15),
    );
  }
*/
  Widget horizontalDivider({
    Color? color,
    double height = 1,
  }) {
    return Divider(
      height: height,
      thickness: .5,
      endIndent: 20,
      indent: 20,
      color: color,
    );
  }

  drawAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor: (isDark!) ? Colors.grey.shade900 : Colors.white,
      /*
      title: TextButton(
        child: Text(
          (BlocProvider.of<AlarmCubit>(context).selected == false)
              ? 'Edit'
              : (BlocProvider.of<AlarmCubit>(context)
                          .selectionController
                          .getSelectedItems()
                          .cast<AlarmDbModel>()
                          .length ==
                      BlocProvider.of<AlarmCubit>(context).alarms.length)
                  ? 'Undo'
                  : 'Select All',
          style: TextStyle(
            color: (isDark!) ? Colors.deepOrange : Colors.blue,
            fontSize: 24,
          ),
        ),
        onPressed: () {
          BlocProvider.of<AlarmCubit>(context).changeSelectionStatus();
        },
      ),

      */
      actions: [
      /*  (BlocProvider.of<AlarmCubit>(context).selected!)
            ? Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: (isDark!) ? Colors.deepOrange : Colors.blue,
                    ),
                    onPressed: () {
                      BlocProvider.of<AlarmCubit>(context).deleteSelectedData();
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: (isDark!) ? Colors.deepOrange : Colors.blue,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      BlocProvider.of<AlarmCubit>(context)
                          .selectionController
                          .clearSelection();
                      BlocProvider.of<AlarmCubit>(context).selected = false;
                    },
                  ),
                ],
              )
            : const SizedBox(),
            */
        IconButton(
          icon: Icon(
            Icons.add_alarm_rounded,
            color: (isDark!) ? Colors.deepOrange : Colors.black,
            size: 30,
          ),
          onPressed: () {
            print("alarms length");
          
          },
        ),
        drawPopupMenue(context),
      ],
    );
  }

  drawEmptyAppBar(BuildContext context) {
    return null;
  }

  drawEmptybody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '  No Alarms Have Been Registered Yet.  ',
            style: TextStyle(
              color: (isDark!) ? Colors.deepOrange : Colors.blue,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          InkWell(
            onTap: () {
              AlarmCubit().addNewAlarm(context);
            },
            onLongPress: () {},
            child: Container(
              width: 250,
              height: 150,
              decoration: BoxDecoration(
                color: (isDark!) ? Colors.orange : Colors.blue[100],
                border: Border.all(
                  color: (isDark!) ? Colors.deepOrange : Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Tab On The Icon To Add The First',
            style: TextStyle(
              color: (isDark!) ? Colors.deepOrange : Colors.blue,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  drawBody(BuildContext context) {
    
    /*
    return MultiselectScope<AlarmDbModel>(
      controller: BlocProvider.of<AlarmCubit>(context).multiselectController,
      dataSource: BlocProvider.of<AlarmCubit>(context).alarms,
      clearSelectionOnPop: true,
      keepSelectedItemsBetweenUpdates: false,
      //  initialSelectedIndexes: [1, 3],
      onSelectionChanged: (indexes, items) {},
      child: 
      */
     return ListView.separated(
        itemBuilder: (context, position) {
      /*    BlocProvider.of<AlarmCubit>(context).selectionController =
              MultiselectScope.controllerOf(context);*/

          final AlarmDbModel currentItem =
              BlocProvider.of<AlarmCubit>(context).alarms[position];
          return drawItem(context, currentItem, position);
        },
        separatorBuilder: (context, positon) {
          return horizontalDivider(
            color: (isDark!) ? Colors.orange : Colors.white,
          );
        },
        itemCount: BlocProvider.of<AlarmCubit>(context).alarms.length,
      );
    
  }
}

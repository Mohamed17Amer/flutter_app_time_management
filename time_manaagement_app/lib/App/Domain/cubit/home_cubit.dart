import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_management/Alarm/Presentation/screens/alarms.dart';
import 'package:time_management/App/shared_variables.dart';
import 'package:time_management/Tasks/Presentation/tasks.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  int bottomNavIndex = 0;
  List<BottomNavigationBarItem> bottomNavList = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.alarm_add_outlined),
      label: 'Alarm',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.timer_outlined),
      label: 'Timer',
    ),
    const BottomNavigationBarItem(
        icon: Icon(Icons.timer_10_outlined), label: 'Stop Watch'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.task_outlined),
      label: 'Tasks',
    ),
  ];
  List<Widget> bottomNavScreens = [
    Alarms(),
    // const CustomTimer(),
    // const CustomCounter(),
    Tasks(),
  ];
  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;

    emit(BottomNavChangeState());
  }

  changeThemeMode(bool value) {
    isDark = value;

    emit(ChangeAppThemeModeState());
  }

  changeTimeFormat(bool value) {
    is24 = value;
    emit(ChangeAppTimeFormatState());
  }
}

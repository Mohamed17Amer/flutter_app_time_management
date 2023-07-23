part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class BottomNavChangeState extends HomeState{}
class ChangeAppThemeModeState extends HomeState{}
class ChangeAppTimeFormatState extends HomeState{}
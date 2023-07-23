import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management/Alarm/Domain/cubit/alarm_cubit.dart';
import 'package:time_management/App/Domain/cubit/home_cubit.dart';
import 'package:time_management/App/Presentation/home.dart';
import 'package:time_management/App/shared_variables.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
         BlocProvider(
          create: (context) => AlarmCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Time Management',
        themeMode: (sharedPreferences.getBool("isDark") == null)
            ? ThemeMode.light
            : (sharedPreferences.getBool("isDark") == true)
                ? ThemeMode.dark
                : ThemeMode.light,
        darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade900,
            colorScheme: const ColorScheme.dark(),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey.shade900,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarBrightness: Brightness.light,
              ),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.deepOrange),
            ),
            primaryColor: Colors.orange),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarBrightness: Brightness.light,
            ),
          ),
          colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.blue,
            background: Colors.blue,
          ),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,),
          useMaterial3: true,
        ),
        home: Home(),
      ),
    );
  }
}

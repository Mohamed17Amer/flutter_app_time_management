import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_management/App/Domain/cubit/home_cubit.dart';
import 'package:time_management/App/shared_variables.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
                      backgroundColor:(isDark!)?Colors.deepOrange: Colors.white,

          body: BlocProvider.of<HomeCubit>(context)
              .bottomNavScreens[BlocProvider.of<HomeCubit>(context).bottomNavIndex],
          bottomNavigationBar: _drawButtonNavBar(context),
        );
      },
    );
  }

  _drawButtonNavBar(BuildContext context) {
    return BottomNavigationBar(
      items: BlocProvider.of<HomeCubit>(context).bottomNavList,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: BlocProvider.of<HomeCubit>(context).bottomNavIndex,
      onTap: (index) {
        BlocProvider.of<HomeCubit>(context).changeBottomNavIndex(index);
      },
      selectedItemColor:(isDark!)?Colors.deepOrange: Colors.white,
      unselectedItemColor: Colors.black,
    );
  }
}
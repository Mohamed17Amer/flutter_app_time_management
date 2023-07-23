import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_management/App/domain/cubit/home_cubit.dart';
import 'package:time_management/App/reusable_components.dart';
import 'package:time_management/App/shared_variables.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SeettingsScreen extends StatefulWidget {
  const SeettingsScreen({Key? key}) : super(key: key);

  @override
  State<SeettingsScreen> createState() => _SeettingsScreenState();
}

class _SeettingsScreenState extends State<SeettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        //  backgroundColor: (isDark!)?Colors.grey.shade900:Colors.blue,
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Available Settings',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      textBaseline: TextBaseline.ideographic,
                      decoration: TextDecoration.underline,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Dark Mode',
                            style: TextStyle(fontSize: 22),
                          ),
                          drawAndroidSwitch('assets/icons/thumbs_dark.png',
                              'assets/icons/thumbs_light.png',
                              forTheme: true),
                        ],
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  /******************************************* */

                  const Text(
                    'Premium Version Settings',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      textBaseline: TextBaseline.ideographic,
                      decoration: TextDecoration.underline,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Time Format',
                            style: TextStyle(fontSize: 22),
                          ),
                          drawAndroidSwitch('assets/icons/24_h_f.png',
                              'assets/icons/12_h_f.png',
                              forTheme: false),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Change Theme Color  ',
                            style: TextStyle(fontSize: 22),
                          ),
                          IconButton(
                              onPressed: () {
                                openColorPicker(context);
                              },
                              icon: const Icon(
                                Icons.color_lens_outlined,
                                color: Colors.blue,
                                size: 32,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Task Date Time Picker  ',
                            style: TextStyle(fontSize: 22),
                          ),
                          IconButton(
                              onPressed: () {
                                selectDateTimePicker(context);
                              },
                              icon: const Icon(
                                Icons.date_range_outlined,
                                color: Colors.blue,
                                size: 32,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'localization',
                            style: TextStyle(fontSize: 22),
                          ),
                         // drawLocalizationPopupMenue(context),
                        ],
                      ),
                    ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  // bool? switchValue = (isDark==null)? false:isDark;
  Widget drawAndroidSwitch(String? activeImage, String? inActiveImage,
          {bool? forTheme}) =>
      Transform.scale(
        scale: 2,
        child: SizedBox(
          width: 50,
          child: Switch(
            trackColor: MaterialStateProperty.all(Colors.blueGrey),
            activeThumbImage: AssetImage(activeImage!),
            inactiveThumbImage: AssetImage(inActiveImage!),
            value: (forTheme!)
                ? (sharedPreferences.getBool("isDark") == null)
                    ? false
                    : sharedPreferences.getBool("isDark")!
                : (sharedPreferences.getBool("is24") == null)
                    ? false
                    : sharedPreferences.getBool("is24")!,
            onChanged: (value) => setState(() {
              //     this.switchValue = value;
              if (forTheme) {
                print(value);
                BlocProvider.of<HomeCubit>(context).changeThemeMode(value);
                sharedPreferences.setBool("isDark", value);

                if (sharedPreferences.getBool("isDark") == true) {
                  myThemeMode = ThemeMode.dark;
                  isDark = true;
                } else if (sharedPreferences.getBool("isDark") == false) {
                  myThemeMode = ThemeMode.light;
                  isDark = false;
                }
              } else {
                print(value);
              BlocProvider.of<HomeCubit>(context).changeTimeFormat(value);
                sharedPreferences.setBool("is24", value);

                if (sharedPreferences.getBool("is24") == true) {
                  is24 = true;
                } else if (sharedPreferences.getBool("is24") == false) {
                  is24 = false;
                }
              }
            }),
          ),
        ),
      );

  selectDateTimePicker(BuildContext context) {
    showDialog(
        builder: (context) => AlertDialog(
              title: const Text('Select Date Time Picker'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    drawRoundedImage(
                        200, 200, "assets/images/day_night_time_picker.gif",
                        shape: BoxShape.rectangle),
                    const SizedBox(
                      height: 10,
                    ),
                    drawRoundedImage(
                        200, 200, "assets/images/flutter_datetime_picker.gif",
                        shape: BoxShape.rectangle),
                    const SizedBox(
                      height: 10,
                    ),
                    drawRoundedImage(
                        200, 200, "assets/images/flutter_picker.gif",
                        shape: BoxShape.rectangle),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Select'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
        context: context);
  }

  openColorPicker(BuildContext context) {
    // create some values
    Color pickerColor = const Color(0xff443a49);
    Color currentColor = const Color(0xff443a49);

// ValueChanged<Color> callback
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

// raise the [showDialog] widget
    showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),

          // Use Material color picker:

          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   showLabel: true, // only on portrait mode
          // ),

          // Use Block color picker:

          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),

          // child: MultipleChoiceBlockPicker(
          //   pickerColors: currentColors,
          //   onColorsChanged: changeColors,
          // ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      context: context,
    );
  }
}

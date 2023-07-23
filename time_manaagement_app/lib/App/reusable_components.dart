import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_management/Alarm/Presentation/popup_screens/contact_us_screen.dart';
import 'package:time_management/Alarm/Presentation/popup_screens/our_apps_screen.dart';
import 'package:time_management/Alarm/Presentation/popup_screens/premium_v_screen.dart';
import 'package:time_management/Alarm/Presentation/popup_screens/settings_screen.dart';
import 'package:time_management/Alarm/Presentation/popup_screens/share_screen.dart';

import 'package:time_management/App/shared_variables.dart';

drawPopupMenue(BuildContext context) {
  return PopupMenuButton<PopupMenueItemModel>(
    color: (isDark!) ? Colors.black : const Color.fromARGB(255, 124, 26, 210),
    icon: Icon(
      Icons.more_vert_outlined,
      color: (isDark!) ? Colors.deepOrange : Colors.black,
    ),
    iconSize: 30,
    itemBuilder: (context) {
      return popupMenueItems
          .map(
            (item) => PopupMenuItem<PopupMenueItemModel>(
              child: Card(
                //  color: item.color,
                child: Row(children: [
                  Icon(
                    item.icon,
                    color: (isDark!) ? Colors.deepOrange : Colors.black,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    item.title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: (isDark!) ? Colors.deepOrange : Colors.black,
                    ),
                  ),
                ]),
              ),
              value: item,
            ),
          )
          .toList();
    },
    onSelected: (item) {
      if (item.title == 'Settings') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SeettingsScreen();
            },
          ),
        );
      } else if (item.title == 'Share') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const ShareScreen();
            },
          ),
        );
      } else if (item.title == 'Contact Us') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const ContactUsScreen();
            },
          ),
        );
      } else if (item.title == 'Premium Version') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const PremiumVersionScreen();
            },
          ),
        );
      } else if (item.title == 'Our Apps') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const OurAppsScreen();
            },
          ),
        );
      }
    },
  );
}





drawLocalizationPopupMenue(BuildContext context) {
  return DropdownButton(
    
    icon: const Icon(
      Icons.language,
      color:Colors.blue,
    ),
    iconSize: 30,
    dropdownColor: Colors.transparent,
    items: localizationLanguages
          .map(
            (item) => DropdownMenuItem<LocalizationLanguagesItemModel>(
              child: Row(children: [
                Text(
                  item.flag!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: (isDark!) ? Colors.deepOrange : Colors.black,
                  ),
                ),

                const SizedBox(
                  width: 25,
                ),
                Text(
                  item.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: (isDark!) ? Colors.deepOrange : Colors.black,
                  ),
                ),


              ]),
              value: item,
            ),
          )
          .toList(),
           onChanged: (LocalizationLanguagesItemModel? value) { 

            // showDialog(context: context, builder: (context){
            //   return Card(
            //     child: Text("بحيك، اشترِ بقي النسخة المدفوعة يا حبيب قلبي من جوا"),
            //   );
            // });
            },
    
  );

}



  drawRoundedImage(double width, double height, String path,{BoxShape? shape}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: (shape==null)?BoxShape.circle:shape,
        image: DecorationImage(
            image: AssetImage(
              path,
            ),
            fit: BoxFit.fill),
      ),
    );
  }

  drawRoundedSvgImage(double width, double height, String path) {
    return Container(
      width: width,
      height: height,
      child: SvgPicture.asset(path, color: Colors.blue, fit: BoxFit.fill),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
    );
  }

  printToast(String? msg, {Toast? toastLenght}){
    Fluttertoast.showToast(
              msg: msg!,
              toastLength:(toastLenght==null)?Toast.LENGTH_SHORT: toastLenght,
              gravity: ToastGravity.BOTTOM,
              // timeInSe20cForIos: 1,
              timeInSecForIosWeb: 1,
              backgroundColor:(isDark!)?Colors.deepOrange: Colors.blue,
              textColor: Colors.black,
              fontSize: 20,
            );
  }

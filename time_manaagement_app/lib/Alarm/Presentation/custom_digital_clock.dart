import 'package:flutter/material.dart';

/*
class CustomDigitalClock extends StatelessWidget {
  const CustomDigitalClock(
      {super.key, this.is24HourTimeFormat,
      this.showSecondsDigit,
      this.areaWidth,
      this.areaHeight,
      this.areaDecoration,
      this.areaAligment,
      this.hourMinuteDigitDecoration,
      this.secondDigitDecoration,
      this.digitAnimationStyle,
      this.hourMinuteDigitTextStyle,
      this.secondDigitTextStyle,
      this.amPmDigitTextStyle,
      this.myTime,
      });

  final bool? is24HourTimeFormat;
  final bool? showSecondsDigit;
  final double? areaWidth;
  final double? areaHeight;
  final BoxDecoration? areaDecoration;
  final AlignmentDirectional? areaAligment;
  final BoxDecoration? hourMinuteDigitDecoration;
  final BoxDecoration? secondDigitDecoration;
  final Curve? digitAnimationStyle;
  final TextStyle? hourMinuteDigitTextStyle;
  final TextStyle? secondDigitTextStyle;
  final TextStyle? amPmDigitTextStyle;
  final DateTime? myTime;

  @override
  Widget build(BuildContext context) {
    DateTime? dateTime = myTime;
    ClockModel clockModel = ClockModel();

    clockModel.is24HourFormat = is24HourTimeFormat ?? true;
    clockModel.hour = dateTime!.hour;
    clockModel.minute = dateTime.minute;
    clockModel.second = dateTime.second;
    return SizedBox(
      width: areaWidth ??
          (hourMinuteDigitTextStyle != null
              ? hourMinuteDigitTextStyle!.fontSize! * 7
              : 180),
      height: areaHeight,
      child: Container(
        alignment: areaAligment ?? AlignmentDirectional.bottomCenter,
        decoration: areaDecoration ??
            BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 3, 12, 84),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            hour(),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: SpinnerText(
                  text: ":",
                  textStyle: hourMinuteDigitTextStyle,
                )),
            minute,
            second,
            amPm,
          ],
        ),
      ),
    );
  }

  Widget hour() {
    DateTime? dateTime = myTime;
    ClockModel clockModel = ClockModel();
    clockModel.is24HourFormat = is24HourTimeFormat ?? true;
    clockModel.hour = dateTime!.hour;
    clockModel.minute = dateTime.minute;
    clockModel.second = dateTime.second;
    return Container(
      decoration: hourMinuteDigitDecoration ??
          BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(5)),
      child: SpinnerText(
        text: clockModel.is24HourTimeFormat
            ? hTOhh_24hTrue(clockModel.hour)
            : hTOhh_24hFalse(clockModel.hour)[0],
        animationStyle: digitAnimationStyle,
        textStyle: hourMinuteDigitTextStyle,
      ),
    );
  }

  Widget get minute {
    DateTime? dateTime = myTime;
    ClockModel clockModel = ClockModel();
    clockModel.is24HourFormat = is24HourTimeFormat ?? true;
    clockModel.hour = dateTime!.hour;
    clockModel.minute = dateTime.minute;
    clockModel.second = dateTime.second;
    return Container(
      decoration: hourMinuteDigitDecoration ??
          BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(5)),
      child: SpinnerText(
        text: mTOmm(clockModel.minute),
        animationStyle: digitAnimationStyle,
        textStyle: hourMinuteDigitTextStyle,
      ),
    );
  }

  Widget get second {
    DateTime? dateTime = myTime;
    ClockModel clockModel = ClockModel();
    clockModel.is24HourFormat = is24HourTimeFormat ?? true;
    clockModel.hour = dateTime!.hour;
    clockModel.minute = dateTime.minute;
    clockModel.second = dateTime.second;

    return showSecondsDigit != false
        ? Container(
            margin: const EdgeInsets.only(bottom: 0, left: 4, right: 2),
            decoration: secondDigitDecoration ??
                BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5)),
            child: SpinnerText(
              text: sTOss(clockModel.second),
              animationStyle: digitAnimationStyle,
              textStyle: secondDigitTextStyle ??
                  TextStyle(
                      fontSize: hourMinuteDigitTextStyle != null
                          ? hourMinuteDigitTextStyle!.fontSize! / 2
                          : 15,
                      color: hourMinuteDigitTextStyle != null
                          ? hourMinuteDigitTextStyle!.color!
                          : Colors.white),
            ),
          )
        : const Text("");
  }

  Widget get amPm {
    DateTime? dateTime = myTime;
    ClockModel clockModel = ClockModel();
    clockModel.is24HourFormat = is24HourTimeFormat ?? true;
    clockModel.hour = dateTime!.hour;
    clockModel.minute = dateTime.minute;
    clockModel.second = dateTime.second;
    return clockModel.is24HourTimeFormat
        ? const Text("")
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            margin: EdgeInsets.only(
                bottom: hourMinuteDigitTextStyle != null
                    ? hourMinuteDigitTextStyle!.fontSize! / 2
                    : 15),
            child: Text(
              " " + hTOhh_24hFalse(clockModel.hour)[1],
              style: amPmDigitTextStyle ??
                  TextStyle(
                      fontSize: hourMinuteDigitTextStyle != null
                          ? hourMinuteDigitTextStyle!.fontSize! / 2
                          : 15,
                      color: hourMinuteDigitTextStyle != null
                          ? hourMinuteDigitTextStyle!.color!
                          : Colors.white),
            ),
          );
  }
}
*/
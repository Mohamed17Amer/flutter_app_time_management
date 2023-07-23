import 'package:flutter/material.dart';

class PremiumVersionScreen extends StatefulWidget {
  const PremiumVersionScreen({Key? key}) : super(key: key);

  @override
  State<PremiumVersionScreen> createState() => _PremiumVersionScreenState();
}

class _PremiumVersionScreenState extends State<PremiumVersionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ask for the Premium Version',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Wrap(children: [
              Wrap(children: [
                Text(
                  "You can enjoy a lot of features in the paid version,You can record more than 10 alarms and show weather, You also control the time format, and how to specify the time and date,You will be given multiple selection of tasks and also some other features in the archieved tasks, What will impress you more is the conversion of the application language into several languages, such as English and French.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ]),
            ]),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

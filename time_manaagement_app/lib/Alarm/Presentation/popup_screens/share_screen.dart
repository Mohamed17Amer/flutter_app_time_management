import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_management/App/reusable_components.dart';
import 'package:time_management/App/shared_variables.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Share',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Copy App Link",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Copy APk File Link",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Download APK File",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.download_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Send It to a Friend",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                height: 15,
                thickness: 3,
                color: (isDark!)?Colors.deepOrange:Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Copy Github Link    ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: drawRoundedSvgImage(24, 24, "assets/svg/github.svg"),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(
                              text: "https://github.com/Mohamed17Abdelmoneim"))
                          .then((value) {
                        printToast('Github Link was copied to the clipboard');
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Copy Linkedin Link  ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      icon: drawRoundedSvgImage(
                          24, 24, "assets/svg/linkedin.svg"),
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(
                                text:
                                    "https://www.linkedin.com/in/mohamed-abdelmoneim-amer-355b58194/"))
                            .then((value) {
                          printToast(
                              'Linkedin Link was copied to the clipboard');
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Copy WhatsAppp Link",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.soap_outlined),
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(
                                text:
                                    "https://api.whatsapp.com/send/?phone=01011245647&text&type=phone_number&app_absent=0"))
                            .then((value) {
                          printToast(
                              'WhatsApp Link was copied to the clipboard');
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Copy Gmail                 ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.email_outlined),
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(
                                text:
                                    "dev.cs.mohamed@gmail.com"))
                            .then((value) {
                          printToast(
                              'Gmail Link was copied to the clipboard');
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

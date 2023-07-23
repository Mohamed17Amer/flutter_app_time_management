
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_management/App/domain/cubit/home_cubit.dart';
import 'package:time_management/App/reusable_components.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Contact Us',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              drawRoundedImage(200, 200, 'assets/images/my_photo.jpg'),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Software Engineer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  textBaseline: TextBaseline.alphabetic,
                  shadows: [
                    Shadow(offset: Offset(0, 4), color: Colors.black),
                    Shadow(offset: Offset(0, 5), color: Colors.white),
                    Shadow(offset: Offset(0, 6), color: Colors.red),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              /************************************************ */

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Mohamed Amer",
                            style: TextStyle(fontSize: 22),
                          ),
                          drawRoundedImage(
                              30, 30, "assets/images/autograph.png")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Egyptian",
                            style: TextStyle(fontSize: 18),
                          ),
                          drawRoundedImage(30, 30, "assets/images/egypt.png")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Giza Governorate",
                            style: TextStyle(fontSize: 18),
                          ),
                          drawRoundedImage(
                              30, 30, "assets/images/giza_pyramids.jpg")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon:
                                const Icon(Icons.phone, color: Colors.blue, size: 24),
                            onPressed: () {
                              contactMe("tel", "01011245647",
                                  "Please, check Sys DAIL");
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.sms_outlined,
                                color: Colors.blue, size: 24),
                            onPressed: () {
                              contactMe("smsto", "01011245647",
                                  "Please, check Sys Messager",
                                  qp: {
                                    'body': Uri.encodeComponent(
                                        "Time Management App or Ask for Work"),
                                  });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.social_distance,
                                color: Colors.blue, size: 24),
                            onPressed: () {
                              openWhatsApp();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.telegram_outlined,
                                color: Colors.blue, size: 24),
                            onPressed: () {
                              openTelegram();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.email_outlined,
                                color: Colors.blue, size: 24),
                            onPressed: () {
                              contactMe(
                                "mailto",
                                "dev.cs.mohamed@gmail.com",
                                "Check Internet Connection",
                                qp: (<String, String>{
                                  'subject':
                                      'Time Management App or Ask for Work',
                                      'body':""
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: drawRoundedSvgImage(
                                24, 24, "assets/svg/linkedin.svg"),
                            onPressed: () {
                              contactMe(
                                  "https",
                                  'linkedin.com/in/mohamed-abdelmoneim-amer-355b58194/',
                                  "Check Internet Connection");
                            },
                          ),
                          IconButton(
                            icon: drawRoundedSvgImage(
                                24, 24, "assets/svg/github.svg"),
                            onPressed: () async {
                              contactMe(
                                  "https",
                                  'github.com/Mohamed17Abdelmoneim',
                                  "Check Internet Connection");
                            },
                          ),
                          IconButton(
                            icon: drawRoundedSvgImage(
                                24, 24, "assets/svg/facebook.svg"),
                            onPressed: () {
                              contactMe("https", 'facebook.com/Mohamed17Amer',
                                  "Check Internet Connection");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  contactMe(String scheme, String path, String msg,
      {Map<String, dynamic>? qp}) async {
    try {
      final url = Uri(scheme: scheme, path: path, queryParameters: qp);
    //  if (await canLaunchUrl(url)) {
        launchUrl(
          url,
        );
    //  }
    } catch (e) {
      printToast(msg);
      print(e.toString());
            rethrow;

    }
  }

  //https://api.whatsapp.com/send/?phone=201101112165&text&type=phone_number&app_absent=0

  openWhatsApp() async {

    const url = 'https://wa.me/01011245647?text= Hello There'; 

 if (!await launch(url)) throw "Error occurred couldn't open link";
  }
  
  openTelegram()async{
        final url =Uri.parse('https://t.me/mo17amer?text= Hello There'); 

 if (!await launchUrl(url)) throw "Error occurred couldn't open link";

  }
}

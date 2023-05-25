// import 'package:auto_mobile_tracker/login.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String textValue = 'Hello World !';
//   FirebaseMessaging? firebaseMessaging = FirebaseMessaging.instance;
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();

//     var android = const AndroidInitializationSettings('mipmap/ic_launcher');
//     // var ios = IOSInitializationSettings();
//     var platform = InitializationSettings(
//       android: android,
//     );
//     flutterLocalNotificationsPlugin.initialize(platform);

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const LoginPage(),
//         ),
//         // '/message',
//       );
//       // arguments: MessageArguments(message, true));
//     });

//     // firebaseMessaging.requestNotificationPermissions(
//     //     const IosNotificationSettings(sound: true, alert: true, badge: true));
//     // firebaseMessaging.onIosSettingsRegistered
//     //     .listen((IosNotificationSettings setting) {
//     //   print('IOS Setting Registed');
//     // });
//     FirebaseMessaging.instance.getToken().then((token) {
//       update(token ?? "");
//     });
//   }

//   showNotification(Map<String, dynamic> msg) async {
//     var android = const AndroidNotificationDetails(
//       'sdffds dsffds',
//       "CHANNLE NAME",
//     );
//     var platform = NotificationDetails(
//       android: android,
//     );
//     await flutterLocalNotificationsPlugin.show(
//         0, "This is title", "this is demo", platform);
//   }

//   update(String token) {
//     DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
//     databaseReference.child('fcm-token/$token').set({"token": token});
//     textValue = token;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Push Notification'),
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               Text(
//                 textValue,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:auto_mobile_tracker/components.dart';
import 'package:auto_mobile_tracker/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: colors,
      ),
      // home: const HomePage(),
      home: Splash_Screen(),
    );
  }
}

class Splash_Screen extends StatelessWidget {
  const Splash_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: SizedBox(
            height: 800,
            width: 700,
            // color: Colors.amber,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 430,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),
                      // color: Colors.amber,
                      image: DecorationImage(
                          image: AssetImage('assets/images/map.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 59, 59, 61),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  kbutton(
                      Rpage: LoginPage(),
                      BText: "Gets Started !",
                      CHeight: 50.0,
                      CWidth: 200.0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

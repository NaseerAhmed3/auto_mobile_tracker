import 'package:auto_mobile_tracker/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mainclass(),
    );
  }
}

class Mainclass extends StatelessWidget {
  const Mainclass({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Splash_Screen();
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // } else if (snapshot.hasError) {
        //   return Center(
        //     child: Text("Something went wrong!"),
        //   );
        // } else if (snapshot.hasData) {
        //   print("its ok");
        //   return Appbar();
        // } else {
        //   print("its wrong");

        //   return Signin();
        // }
      },
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
            height: 600,
            width: 700,
            // color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(
                    -3.1415926535897932 / 4,
                  ),
                  child: Container(
                    height: 430,
                    width: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: Colors.amber,
                      image: DecorationImage(
                          image: AssetImage('assets/images/map2.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 59, 59, 61),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffCF6F80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: Text("Gets Started !"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

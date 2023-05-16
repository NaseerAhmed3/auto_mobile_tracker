import 'package:auto_mobile_tracker/home_page.dart';
import 'package:auto_mobile_tracker/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

final emailcontroller = TextEditingController();
final passwordcontroller = TextEditingController();

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>(); //for storing form state.

//saving form after validation
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  bool value = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 280),
              child: Container(
                height: 650,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 183, 192),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 250,
                        width: 350,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            Container(
                              height: 190,
                              width: 350,
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                // image: DecorationImage(
                                //   // image: NetworkImage(
                                //   //     "https://images.pexels.com/photos/6307706/pexels-photo-6307706.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                                //   image: AssetImage("assets/images/image2.jpg"),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 350,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                controller: emailcontroller,
                                decoration: InputDecoration(
                                    hintText: ("Email"),
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                    focusColor: Color(0xFFFFFFFF),
                                    focusedBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFFFFFFF)),
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                                validator: (text) {
                                  if (!(text!.contains('@')) || text.isEmpty) {
                                    return 'Enter Valid Email';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                controller: passwordcontroller,
                                decoration: InputDecoration(
                                    hintText: ("Password"),
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                    focusColor: Color(0xFFFFFFFF),
                                    focusedBorder: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFFFFFFF)),
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter your password';
                                  }
                                  // if (text.length < 8) {
                                  //   return "Password must has 8 characters";
                                  // }
                                  // if (!text.contains(RegExp(r'[A-Z]'))) {
                                  //   return "Password must has uppercase";
                                  // }
                                  // if (!text.contains(RegExp(r'[0-9]'))) {
                                  //   return "Password must has digits";
                                  // }
                                  // if (!text.contains(RegExp(r'[a-z]'))) {
                                  //   return "Password must has lowercase";
                                  // }
                                  // if (!text.contains(RegExp(r'[#?!@$%^&*-]'))) {
                                  //   return "Password must has special characters";
                                  // }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              width: 350,
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Forgot your Password?",
                                      style: TextStyle(
                                          color: Color(0xffCF6F80),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // TODO submit
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailcontroller.text.trim(),
                                        password:
                                            passwordcontroller.text.trim());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => home_Page()),
                                );
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffCF6F80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                // color: Color(0xffCF6F80),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You don't have an account?",
                            style: TextStyle(
                                // color: Color(0xffCF6F80),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()),
                                );
                              },
                              child: Text(
                                "Signup Here!",
                                style: TextStyle(
                                    color: Color(0xffCF6F80),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

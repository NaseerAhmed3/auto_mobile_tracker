import 'package:auto_mobile_tracker/home_page.dart';
import 'package:auto_mobile_tracker/siginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  void dispose() {
    email.dispose();
    password.dispose();
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
                      SizedBox(height: 10),
                      Text(
                        "Register With Us",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      Text(
                        "Your information is safe with us",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 350,
                        // color: Colors.amber,
                        width: 350,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: ("Full Name"),
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
                                    return 'First is empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                controller: email,
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
                                    return 'Enter a valid email address!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                controller: password,
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
                                  if (text.length < 8) {
                                    return "Password must has 8 characters";
                                  }
                                  if (!text.contains(RegExp(r'[A-Z]'))) {
                                    return "Password must has uppercase";
                                  }
                                  if (!text.contains(RegExp(r'[0-9]'))) {
                                    return "Password must has digits";
                                  }
                                  if (!text.contains(RegExp(r'[a-z]'))) {
                                    return "Password must has lowercase";
                                  }
                                  if (!text.contains(RegExp(r'[#?!@$%^&*-]'))) {
                                    return "Password must has special characters";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                controller: password,
                                decoration: InputDecoration(
                                    hintText: ("Confirm Password"),
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
                                  if (text.length < 8) {
                                    return "Password must has 8 characters";
                                  }
                                  if (!text.contains(RegExp(r'[A-Z]'))) {
                                    return "Password must has uppercase";
                                  }
                                  if (!text.contains(RegExp(r'[0-9]'))) {
                                    return "Password must has digits";
                                  }
                                  if (!text.contains(RegExp(r'[a-z]'))) {
                                    return "Password must has lowercase";
                                  }
                                  if (!text.contains(RegExp(r'[#?!@$%^&*-]'))) {
                                    return "Password must has special characters";
                                  }
                                  return null;
                                },
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
                                    .createUserWithEmailAndPassword(
                                        email: email.text.trim(),
                                        password: password.text.trim());

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
                            "SignUp",
                            style: TextStyle(
                                // color: Color(0xffCF6F80),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You  have an account?",
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
                                      builder: (context) => Signin()),
                                );
                              },
                              child: Text(
                                "Signin Here!",
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

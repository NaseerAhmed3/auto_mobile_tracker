import 'package:auto_mobile_tracker/components.dart';
import 'package:auto_mobile_tracker/signup.dart';
import 'package:auto_mobile_tracker/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_loader_overlay/progress_loader_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showDefaultLoader(BuildContext context) async {
    /// If no widgetBuilder is specified a simple default loader will be displayed.
    ProgressLoader().widgetBuilder = null;

    await ProgressLoader().show(context);
    await Future<void>.delayed(Duration(seconds: 2));
    await ProgressLoader().dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Container(
            height: 850,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0x7fCF6F80),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Consttext(
                          ctext: "Welcome back!",
                          kfontw: FontWeight.w500,
                          kfonts: 40.0,
                          kcolor: Colors.black,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 130,
                          width: 180,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(20),
                            // color: Colors.amber,
                            image: DecorationImage(
                                image: AssetImage('assets/images/loginpic.png'),
                                fit: BoxFit.fill),
                          ),
                        ),

                        // Email Textfeild
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            width: 330,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.email),
                                suffixIconColor: Color(0x7fCF6F80),
                                hintText: "Email",
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email cannot be empty";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),

                        // Password Textfeild

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            width: 330,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(_isObscure3
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure3 = !_isObscure3;
                                    });
                                  },
                                ),
                                suffixIconColor: Color(0x7fCF6F80),
                                hintText: 'Password',
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("please enter valid password min. 6 character");
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
// Login Button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40,
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                showDefaultLoader(context);
                                signIn(emailController.text,
                                    passwordController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kcolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: const Text("Login"),
                            ),
                          ),
                        ),
                        // TextButton for Signup
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Consttext(
                                  ctext: "If you don't have an account",
                                  kfontw: FontWeight.w500,
                                  kfonts: 15.0,
                                  kcolor: Colors.black),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpPage(),
                                    ),
                                  );
                                },
                                child: Consttext(
                                    ctext: "Sign Up",
                                    kfontw: FontWeight.w400,
                                    kfonts: 15.0,
                                    kcolor: kcolor),
                              ),
                              Consttext(
                                  ctext: "here!",
                                  kfontw: FontWeight.w500,
                                  kfonts: 15.0,
                                  kcolor: Colors.black),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('user_info')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserPage(),
              ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(""),
          ));
          // print('Document does not exist on the database');
        }
      });
    }
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No user found for that email."),
          ));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Wrong password provided for that user."),
          ));
        }
      }
    }
  }
}

class SimpleProgressLoaderWidget {}

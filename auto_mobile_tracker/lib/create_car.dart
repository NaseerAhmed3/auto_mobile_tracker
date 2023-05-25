import 'package:auto_mobile_tracker/user.dart';
import 'package:auto_mobile_tracker/user_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components.dart';

class CreateCar extends StatefulWidget {
  const CreateCar({Key? key}) : super(key: key);

  @override
  State<CreateCar> createState() => _CreateCarState();
}

class _CreateCarState extends State<CreateCar> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController carNoController = TextEditingController();
  final TextEditingController vinNoController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  String? gender;
  create() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection('cars').add({
        "name": nameController.text,
        "car_no": carNoController.text,
        "vin_no": vinNoController.text,
        "make": makeController.text,
        "color": colorController.text,
        "created_by": user.uid,
        "created_at": DateTime.now(),
      }).then((value) {
        // cleartextfields();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Car added successfuuly"),
        ));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserPage(),
          ),
        );
      });
    }
  }

  cleartextfields() {
    nameController.text = "";
    vinNoController.text = "";
    carNoController.text = "";
    makeController.text = "";
    colorController.text = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
            color: kcolor,
          ),
          title: Consttext(
              ctext: "User",
              kfontw: FontWeight.w600,
              kfonts: 24.0,
              kcolor: Color(0xffCF6F80))),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        color: Colors.white,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  // hintText:
                  labelText: "Name",
                  labelStyle: TextStyle(color: Color(0xffCF6F80)),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: carNoController,
                decoration: InputDecoration(
                  labelText: "Car Number",
                  labelStyle: TextStyle(color: Color(0xffCF6F80)),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: vinNoController,
                decoration: InputDecoration(
                  labelText: "Vin Name",
                  labelStyle: TextStyle(color: Color(0xffCF6F80)),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: makeController,
                decoration: InputDecoration(
                  labelText: "Make",
                  labelStyle: TextStyle(color: Color(0xffCF6F80)),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: colorController,
                decoration: InputDecoration(
                  labelText: "Color",
                  labelStyle: TextStyle(color: Color(0xffCF6F80)),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffCF6F80)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  create();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                child: const Text("Add car"),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

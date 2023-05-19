import 'package:auto_mobile_tracker/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        title: const Text("User"),
      ),
      body: Column(children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Car name',
          ),
        ),
        TextFormField(
          controller: carNoController,
          decoration: const InputDecoration(
            hintText: 'Car number',
          ),
        ),
        TextFormField(
          controller: vinNoController,
          decoration: const InputDecoration(
            hintText: 'Vin number',
          ),
        ),
        TextFormField(
          controller: makeController,
          decoration: const InputDecoration(
            hintText: 'Car make',
          ),
        ),
        TextFormField(
          controller: colorController,
          decoration: const InputDecoration(
            hintText: 'Car color',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            create();
          },
          child: const Text("Add car"),
        ),
      ]),
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({Key? key}) : super(key: key);

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  String profilePicLink = "";
  String email = "";

  void pickUploadProfilePic() async {
    User? user = FirebaseAuth.instance.currentUser;
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
    if (user != null) {
      Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");

      await ref.putFile(File(image!.path));

      ref.getDownloadURL().then((value) async {
        if (value.isNotEmpty) {
          FirebaseFirestore.instance
              .collection("profile_pic")
              .doc(user.uid)
              .set({"profile_pic_url": value});
        }
        setState(() {
          profilePicLink = value;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('user_info')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          nameController.text = documentSnapshot.get('name') ?? "";
          addressController.text = documentSnapshot.get('address') ?? "";
          mobileController.text = documentSnapshot.get('mobile').toString();
          cnicController.text = documentSnapshot.get('cnic').toString();
          email = "${documentSnapshot.get('email')} ";

          FirebaseFirestore.instance
              .collection('profile_pic')
              .doc(user.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              if (documentSnapshot.get('profile_pic_url') != null) {
                profilePicLink = "${documentSnapshot.get('profile_pic_url')} ";
              }
              setState(() {});
            }
          });
          setState(() {});
        }
      });
    }
  }

  _update() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('user_info');
      ref.doc(user.uid).set({
        'name': nameController.text,
        'mobile': int.parse(mobileController.text),
        'cnic': cnicController.text,
        'address': addressController.text,
        'email': email,
      }).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Updated Successfully"),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            pickUploadProfilePic();
          },
          child: Container(
            margin: const EdgeInsets.only(top: 80, bottom: 24),
            height: 120,
            width: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: profilePicLink.isEmpty
                  ? const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 80,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(profilePicLink),
                    ),
            ),
          ),
        ),
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Name',
          ),
          keyboardType: TextInputType.name,
        ),
        TextFormField(
          controller: mobileController,
          decoration: const InputDecoration(
            hintText: 'Mobile',
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: cnicController,
          decoration: const InputDecoration(
            hintText: 'Cnic',
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: addressController,
          decoration: const InputDecoration(
            hintText: 'Address',
          ),
          keyboardType: TextInputType.streetAddress,
        ),
        ElevatedButton(
            onPressed: () {
              _update();
            },
            child: const Text("Update"))
      ],
    );
  }
}

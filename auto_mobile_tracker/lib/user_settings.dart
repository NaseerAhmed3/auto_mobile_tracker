import 'dart:io';

import 'package:auto_mobile_tracker/components.dart';
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
                      color: Color.fromARGB(255, 202, 139, 135),
                      size: 80,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(profilePicLink),
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 50,
            width: 330,
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Full Name",
                // hintStyle: TextStyle(color:  Color(0x7fCF6F80),),
                filled: true,
                fillColor: kcolor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
          ),
        ),
// Mobilenumber feild

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 50,
            width: 330,
            child: TextFormField(
              controller: mobileController,
              decoration: InputDecoration(
                hintText: 'Mobile',
                // hintStyle: TextStyle(color:  Color(0x7fCF6F80),),
                filled: true,
                fillColor: kcolor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),

// CNIC feild

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 50,
            width: 330,
            child: TextFormField(
              controller: cnicController,
              decoration: InputDecoration(
                hintText: 'Cnic',

                // hintStyle: TextStyle(color:  Color(0x7fCF6F80),),
                filled: true,
                fillColor: kcolor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),

//  Address feild

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 50,
            width: 330,
            child: TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'Address',

                // hintStyle: TextStyle(color:  Color(0x7fCF6F80),),
                filled: true,
                fillColor: kcolor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              keyboardType: TextInputType.streetAddress,
            ),
          ),
        ),
// UPDATE Button
        SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
              onPressed: () {
                _update();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              child: const Text("Update")),
        ),
        // kbutton(Rpage:   _update(), BText: 'Update', CHeight:40.0, CWidth: 200.0)
      ],
    );
  }
}

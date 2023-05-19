import 'package:auto_mobile_tracker/car_detail_page.dart';
import 'package:auto_mobile_tracker/create_car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController searchText = TextEditingController();

  List<Map<String, dynamic>> cars = [];
  List<Map<String, dynamic>> filteredCars = [];

  @override
  void initState() {
    super.initState();
    getCars();
  }

  getCars() {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('cars')
          .where("created_by", isEqualTo: user!.uid)
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.docs.isNotEmpty) {
          for (var doc in snapshot.docs) {
            cars.add({...doc.data(), "car": doc.id});
          }
          filteredCars = cars;
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateCar(),
                  ),
                );
              },
              child: const Text("Add Car")),
          TextFormField(
            controller: searchText,
            decoration: const InputDecoration(
              hintText: 'Search',
            ),
            onChanged: (value) => {
              if (value.isEmpty)
                {
                  filteredCars = cars,
                }
              else
                {
                  filteredCars = cars
                      .where((element) {
                        if (element["name"] != null &&
                                (element["name"] as String)
                                    .toLowerCase()
                                    .contains(searchText.text) ||
                            element["car_no"] != null &&
                                (element["car_no"] as String)
                                    .toLowerCase()
                                    .contains(searchText.text) ||
                            element["vin_no"] != null &&
                                (element["vin_no"] as String)
                                    .toLowerCase()
                                    .contains(searchText.text) ||
                            element["make"] != null &&
                                (element["make"] as String)
                                    .toLowerCase()
                                    .contains(searchText.text) ||
                            element["color"] != null &&
                                (element["color"] as String)
                                    .toLowerCase()
                                    .contains(searchText.text)) {
                          return true;
                        } else {
                          return false;
                        }
                      })
                      .map((e) => e)
                      .toList(),
                },
              setState(() {}),
            },
            keyboardType: TextInputType.text,
          ),
          Visibility(
            visible: filteredCars.isNotEmpty,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: filteredCars
                    .map(
                      (e) => Card(
                        color: Colors.blue[100],
                        child: Column(
                          children: [
                            Text(e["name"] ?? ""),
                            Text(e["car_no"] ?? ""),
                            Text(e["vin_no"] ?? ""),
                            Text(e["make"] ?? ""),
                            Text(e["color"] ?? ""),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CarDetailPage(
                                          carNo: e["car_no"] ?? ""),
                                    ),
                                  );
                                },
                                child: const Text("Details"))
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

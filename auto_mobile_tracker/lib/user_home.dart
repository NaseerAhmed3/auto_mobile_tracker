import 'package:auto_mobile_tracker/car_detail_page.dart';
import 'package:auto_mobile_tracker/components.dart';
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
          // Search textfeild
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(
                      0,
                      2,
                    ),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Color.fromARGB(137, 163, 160, 160),
                  ),
                ],
              ),
              height: 50,
              width: 330,
              child: TextFormField(
                controller: searchText,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  suffixIconColor: Color.fromARGB(126, 24, 22, 22),
                  hintText: "Search",
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
            ),
          ),

          // Add New Cars button
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consttext(
                  ctext: "Cars",
                  kfontw: FontWeight.w500,
                  kfonts: 24.0,
                  kcolor: kcolor,
                ),
                kbutton(
                    Rpage: CreateCar(),
                    BText: "Add Cars",
                    CHeight: 40.0,
                    CWidth: 100.0),
              ],
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Container(
            height: 475,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Visibility(
                visible: filteredCars.isNotEmpty,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: filteredCars
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 25, right: 25),
                            child: Stack(children: [
                              Card(
                                // color: Colors.blue[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 15,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e["name"] ?? "",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500,
                                                color: kcolor),
                                          ),
                                          Text(e["car_no"] ?? ""),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            // width: 150,
                                            height: 100,
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Consttext(
                                                      ctext: "Vin  # : ",
                                                      kfontw: FontWeight.w500,
                                                      kfonts: 14.0,
                                                      kcolor: kcolor,
                                                    ),
                                                    Consttext(
                                                      ctext: "Make : ",
                                                      kfontw: FontWeight.w500,
                                                      kfonts: 14.0,
                                                      kcolor: kcolor,
                                                    ),
                                                    Consttext(
                                                      ctext: "Color : ",
                                                      kfontw: FontWeight.w500,
                                                      kfonts: 14.0,
                                                      kcolor: kcolor,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(e["vin_no"] ?? ""),
                                                    Text(e["make"] ?? ""),
                                                    Text(e["color"] ?? ""),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 200,
                                top: 110,
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CarDetailPage(
                                              carNo: e["car_no"] ?? ""),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kcolor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    child: Text("Details"),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

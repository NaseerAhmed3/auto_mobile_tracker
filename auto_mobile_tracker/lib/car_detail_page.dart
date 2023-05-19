import 'package:auto_mobile_tracker/local_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarDetailPage extends StatefulWidget {
  final String carNo;
  const CarDetailPage({Key? key, required this.carNo}) : super(key: key);

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  dynamic speed = 0;
  // final Completer<GoogleMapController> _controller = Completer();
  bool isAuthorized = true;
  bool engineStatus = false;
  double latitude = 0;
  double longitude = 0;
  String date = "";
  List<Map<String, dynamic>> logs = [];

  String time = "";
  CameraPosition? initialPosition;

  void getData() {
    FirebaseDatabase.instance.ref(widget.carNo).get().then((DataSnapshot data) {
      if (data.exists && data.value != null) {
        isAuthorized = (data.value as Map)["Authorization"];
        engineStatus = (data.value as Map)["Engine_Status"];
        speed = ((data.value as Map)["Gps"])["Speed"];
        longitude = ((data.value as Map)["Gps"])["Longitude"];
        latitude = ((data.value as Map)["Gps"])["Latitude"];
        date = ((data.value as Map)["Gps"])["Date"];
        time = ((data.value as Map)["Gps"])["Time"];
        initialPosition =
            CameraPosition(target: LatLng(latitude, longitude), zoom: 14.0);
        setState(() {});
      }
    });
  }

  void setData() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseDatabase.instance.ref(widget.carNo).update({
      "Authorization": isAuthorized,
    }).then((_) {
      FirebaseFirestore.instance
          .collection('user_info')
          .doc(user?.uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          String name = snapshot.get("name");
          String email = snapshot.get("email");

          FirebaseFirestore.instance.collection('logs').doc().set({
            'user_name': name,
            'email': email,
            'user_id': user?.uid,
            'log_time': DateTime.now(),
            'status': true,
            'car_no': widget.carNo
          }).then((value) => getLogs());
        }
      });
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError),
      ));
    });
  }

  _authorizeDialog() async {
    await LocalAuthApi.authenticate().then((isAuthenticated) {
      if (isAuthenticated) {
        isAuthorized = !isAuthorized;
        setData();
      }
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getLogs();
  }

  getLogs() {
    logs = [];
    FirebaseFirestore.instance
        .collection('logs')
        .where("car_no", isEqualTo: widget.carNo)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          logs.add({...doc.data(), "log_id": doc.id});
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.carNo),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: initialPosition != null
                  ? GoogleMap(
                      initialCameraPosition: initialPosition!,
                      mapType: MapType.normal,
                      // onMapCreated: (GoogleMapController controller) {
                      //   _controller.complete(controller);
                      // },
                    )
                  : const SizedBox(),
            ),
            Row(
              children: [
                const Icon(Icons.speed),
                Text("$speed KM/H"),
              ],
            ),
            Row(
              children: [
                const Text("Updated on"),
                Text("$date $time"),
              ],
            ),
            Row(
              children: [
                const Text("Engine Status :"),
                Text(engineStatus ? "ON" : "OFF"),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  _authorizeDialog();
                },
                child: const Text("Authorize Start/Shut off")),
            const SizedBox(height: 24),
            Visibility(
                visible: logs.isNotEmpty,
                child: Column(
                  children: [
                    ...logs
                        .map((e) => Container(
                              color: e["status"] ? Colors.green : Colors.red,
                              child: Row(
                                children: [
                                  Text(e["user_name"] ?? ""),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(e["log_time"].toDate().toString())
                                ],
                              ),
                            ))
                        .toList()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

//import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker.dart';
import 'package:main_venture/models/demog_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:main_venture/userInfo.dart';
import 'package:main_venture/screens/home_page.dart';
import 'package:main_venture/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../providers/search_places.dart';

class RequestedDialog {
  final double lat, lng;
  Set<Marker> markcount;
  Set<Marker> markcout;

  int counter;
  StreamController<Set<Marker>> markerStreamController;
  RequestedDialog(this.lat, this.lng, this.markcount, this.markcout,
      this.counter, this.markerStreamController);

  var RequestedPop = const SnackBar(
    content:
        Text('This place is requested please wait for the admin to approve it'),
  );

  static const colortext = Color.fromARGB(255, 74, 74, 74);
  static int count = 0;
  int countquery = 0;
  bool hasEnd = false;
  var now = DateTime.now();

  /* Future savedRequestMarker(context) async {
    count += 1;
    var formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    // print(formattedTimestamp);

    GeoPoint geopoint = GeoPoint(lat, lng);

    var docu = GoogleUserStaticInfo().uid.toString();
    FirebaseFirestore.instance
        .collection("parallel_markers")
        .where('user_id_requested', isEqualTo: docu)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((documents) async {
                var data = documents.data() as Map;
                // print(data['user_id_requested']);
                // print(documents.id);// PRINTING OF DOCUMENT ID

                if (hasEnd == false) {
                  if (data['user_id_requested'] == docu) {
                    // print(data['user_id_requested']);
                    if (data['coords'].latitude == geopoint.latitude &&
                        data['coords'].longitude == geopoint.longitude) {
                      print("This location is already pinned");
                      // doublePinnedReq(context);
                      hasEnd = true;
                    } else {
                      // TESTING

                      FirebaseFirestore.instance
                          .collection("parallel_markers")
                          .where("coords", isGreaterThanOrEqualTo: geopoint)
                          .orderBy("coords", descending: true)
                          .limit(1)
                          .get()
                          .then((QuerySnapshot querySnapshot) => {
                                querySnapshot.docs.forEach((documents) async {
                                  var data = documents.data() as Map;

                                  if (data['request_status'] == true) {
                                    final pinnedData = {
                                      "coords": geopoint,
                                      "place": "pinned-request by " +
                                          GoogleUserStaticInfo()
                                              .name
                                              .toString(),
                                      "id": data['id'],
                                      "land": data['land'],
                                      "land_size": data['land_size'],
                                      "popu_future": data['popu_future'],
                                      "popu_past": data['popu_past'],
                                      "population": data['population'],
                                      "revenue": data['revenue'],
                                      "user_id_requested":
                                          GoogleUserStaticInfo().uid,
                                      "date_and_time": formattedTimestamp,
                                      "request_status": false,
                                    };

                                    var db = FirebaseFirestore.instance;
                                    db
                                        .collection("parallel_markers")
                                        .doc(count.toString() +
                                            "-" +
                                            GoogleUserStaticInfo()
                                                .email
                                                .toString())
                                        .set(pinnedData)
                                        .then((documentSnapshot) => {
                                              // print("ok"),
                                              alertmessage(context)
                                              //showing if data is saved
                                            })
                                        .catchError((error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(error);
                                    });
                                  }
                                }) //for loop
                              });
                      // print("ekis");
                      hasEnd = true;
                    }
                  }
                }

                //
              }) //for loop
            });
  } */
  var SnackDialog = const SnackBar(
    content: Text('Requested'),
  );

  Future savedRequestMarker(context) async {
    count += 1;
    var formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    // print(formattedTimestamp);

    GeoPoint geopoint = GeoPoint(lat, lng);

    final pinnedData = {
      "coords": geopoint,
      "place": "pinned-request by ${GoogleUserStaticInfo().name}",
      "land": 10000,
      "land_size": "1000",
      "popu_future": "200000",
      "popu_past": "15000",
      "population": "25000",
      "revenue": "25000",
      "user_id_requested": GoogleUserStaticInfo().uid,
      "date_and_time": formattedTimestamp,
      "request_status": false,
      "user_email_requested": GoogleUserStaticInfo().email,
    };

    var db = FirebaseFirestore.instance;
    db
        .collection("parallel_markers")
        .doc(count.toString() + "-" + GoogleUserStaticInfo().email.toString())
        .set(pinnedData)
        .then((documentSnapshot) => {
              // print("ok"),
              alertmessage(context)
              //showing if data is saved
            })
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(error);
    });

    return ScaffoldMessenger.of(context).showSnackBar(SnackDialog);
  }

  Future<int> countPerUserRequest() async {
    await FirebaseFirestore.instance
        .collection("parallel_markers")
        .where("user_id", isEqualTo: GoogleUserStaticInfo().uid)
        .get()
        .then(
            (QuerySnapshot querySnapshot) => {countquery = querySnapshot.size});

    return countquery;
  }

  removeMarkerss(context) {
    markcount.removeWhere(
        (element) => element.markerId == MarkerId("marker_$counter"));
    markcout.removeWhere(
        (element) => element.markerId == MarkerId("marker_$counter"));

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        // behavior: SnackBarBehavior.floating,
        content: Text('Tap to another place')));
  }

  Future alertmessage(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Request Sent"),
          content: const SingleChildScrollView(
            child: Text(
                "The request has been sent to the admin successfully. Please wait for the approval of admin."),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Okay', style: TextStyle(fontSize: 15.0)),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  Future showMyDialog(BuildContext context) {
    countPerUserRequest();

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return CupertinoAlertDialog(
              title:
                  Text('Do you want to request this place to be ventured out?'),
              actions: <Widget>[
                countquery < 5
                    ? CupertinoDialogAction(
                        onPressed: () async {
                          await savedRequestMarker(context);
                        },
                        child: const Text("Request",
                            style: TextStyle(fontSize: 15.0)),
                      )
                    : const Text("Note: You can only request 5 places"),
                CupertinoDialogAction(
//onPressed: null,
//SAVE USERS' ANSWERS TO THE FIREBASE

                  onPressed: () async {
                    removeMarkerss(context);
                    Navigator.of(context).pop();
                    // ito yun sana kapag initinallize dapat
                  },
                  child:
                      const Text("Replace", style: TextStyle(fontSize: 15.0)),
                ),
                CupertinoDialogAction(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // ito yun sana kapag initinallize dapat
                  },
                  child: const Text("Cancel", style: TextStyle(fontSize: 15.0)),
                ),
              ],
            );
          });
        });
  }
}

class SizeBoxTen extends StatelessWidget {
  const SizeBoxTen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10.0,
    );
  }
}

class SizeBoxTwenty extends StatelessWidget {
  const SizeBoxTwenty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20.0,
    );
  }
}

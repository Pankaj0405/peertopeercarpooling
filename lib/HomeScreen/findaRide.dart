
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ridesharingapp/HomeScreen/rideDetailCard.dart';
import 'package:ridesharingapp/sharedPreferences/sharedPreferences.dart';

final _firestore = FirebaseFirestore.instance;

var loggedInuser;
String? phone;
class FindaRide extends StatefulWidget {
  @override
  _FindaRideState createState() => _FindaRideState();
}

class _FindaRideState extends State<FindaRide> {

  String user = "";
  bool isLoading1 = false;
  Future<void> getCurrentUserName() async {
    setState(() {
      isLoading1 =
      true; // Set isLoading to false to hide the circular progress indicator
    });
    phone = await FirebaseAuth.instance.currentUser!.phoneNumber;
    try {
      final user = MySharedPreferences.instance
          .getStringValue("userName");
      if (user != null) {
        loggedInuser = user;
        print(loggedInuser);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading1 =
      false; // Set isLoading to false to hide the circular progress indicator
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserName();
  }


  @override
  Widget build(BuildContext context) {
    print(phone);
    return Scaffold(

      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);

          },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Find a Ride",style: TextStyle(
          color: Colors.white
        ),),

      ),
      body: isLoading1
          ? Center(child: CircularProgressIndicator())
          :  SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RideStream(),
          ],
        ),
      ),
    );
  }
}



class RideStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('rides').where('destination' ,whereIn:[
        "Mumbai",
        "Borivali",
        "Andheri",
        "Bandra",
        "Malad", "Dadar", "Juhu", "Goregaon",
        "Khar", "Santacruz", "Colaba", "Chembur", "Versova", "Worli", "Kurla",
        "Powai", "Vile Parle", "Marine Lines", "Lower Parel", "Mulund",
        "Ghatkopar", "Dahisar", "Byculla", "Parel", "Mahim", "Matunga",
        "Sion", "Wadala"
      ])
      // Sort the messages by timestamp DESC because we want the newest messages on bottom.
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        // If we do not have data yet, show a progress indicator.
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // Create the list of message widgets.

        List<Widget> rideWidgets = snapshot.data!.docs.map<Widget>((r) {
          final data = r.data();
          final rideSender = data['sender'];
          final rideDestination = data['destination'];
          final rideTime = data['ridetime'];
          final ridePrice = data['price'];
          final ridePhone = data['phone'];
          final rideUPI = data['upi'];
          final rideVehicleNo = data['vechicleno'];
          final timeStamp = data['timestamp'];
          final riderCapacity=data['capacity'];
          final id=data['id'];
          print(ridePhone);
          print(phone);
          print(phone);
          return RideDetailCard(
            rideSender: rideSender,
            rideDestination: rideDestination,
            rideTime : rideTime,
            ridePrice : ridePrice,
            ridePhone : ridePhone,
            rideUPI : rideUPI,
            rideVehicleNo : rideVehicleNo,
            timestamp: timeStamp,
            isMe: ridePhone == phone,
            riderCapacity: riderCapacity,
            id:id
          );
        }).toList();



        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: rideWidgets,
          ),
        );
      },
    );
  }
}

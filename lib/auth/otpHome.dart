
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ridesharingapp/auth/otpPage.dart';

class OtpHome extends StatefulWidget {
  @override
  _OtpHomeState createState() => _OtpHomeState();
}

class _OtpHomeState extends State<OtpHome> {
  TextEditingController _controller = TextEditingController();

  bool _areFieldsFilled() {
    if (_controller.text.isEmpty) {
      _showToast("Please provide your number");
      return false;
    }
    return true;
  }

  _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text('Peer 2 Peer',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                  child: Text('Carpooling',
                      style: TextStyle(
                          fontSize: 55.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(300.0, 165.0, 0.0, 0.0),
                  child: Text('.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ),
              ],
            ),
          ),

          Container(

            padding: EdgeInsets.fromLTRB(20, 100.0, 0.0, 0.0),
            child: Text(
              "You'll receive a\n6 digit code to verify next",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, right: 20, left: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Phone Number',
                prefix: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('+91'),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              maxLength: 10,
              keyboardType: TextInputType.number,
              controller: _controller,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 60.0,
            child: ElevatedButton(
              onPressed: () {
              if (_areFieldsFilled()) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OtpPage(phone: _controller.text,)));
              }

              },
              child: Text(
                'NEXT',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:110),
            child: Align(
                child: Text("©2024, Peer 2 Peer Carpooling",style: TextStyle(color: Colors.grey),),
                alignment: Alignment.bottomCenter,
            ),
          ),

        ],
      ),
    );
  }
}

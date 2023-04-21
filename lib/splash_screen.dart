
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garbage_management/login.dart';
import 'package:garbage_management/screens/recycle_station/station_home.dart';
import 'package:garbage_management/screens/user/user_home.dart';
import 'package:garbage_management/screens/volunteer/Volunteer_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
enum Role{user,company,depart}
class _SplashScreenState extends State<SplashScreen> {
  late String u="1";
  late String v="2";
  late String r="3";
  late String role="";
  late SharedPreferences localStorage;

  Future<void> checkRoleAndNavigate() async {
    localStorage = await SharedPreferences.getInstance();
    role = (localStorage.getString('role') ?? '');
    print(role);
    if (u == role.replaceAll('"', '')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Userhome()));
    }else  if (v == role.replaceAll('"', '')) {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => Volunteeerhome()));
    }else  if (r == role.replaceAll('"', '')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Stationhome()));
    }

    else  {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    }
  }


  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return Timer(duration, checkRoleAndNavigate);
  }

 /* void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => checkRoleAndNavigate()
            )
        )
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("images/bg.png"),
              ),
            /*  Padding(
                padding: const EdgeInsets.symmetric(horizontal:30.0),
                child: Image.asset("images/bg.png"),
              ),*/
              Text("Clean City",  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
              ),
            ]
        ),
      ),
    );
  }
}

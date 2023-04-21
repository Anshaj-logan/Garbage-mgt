import 'package:flutter/material.dart';
import 'package:garbage_management/login.dart';
import 'package:garbage_management/screens/recycle_station/Station_notification.dart';
import 'package:garbage_management/screens/recycle_station/station_editprofile.dart';
import 'package:garbage_management/screens/recycle_station/station_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stationhome extends StatelessWidget {
  const Stationhome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late SharedPreferences localStorage;
    return Scaffold(backgroundColor: Colors.green,
      appBar: AppBar(backgroundColor: Colors.green,elevation: 0,toolbarHeight: 10),
      body: Column(
        children: [
          Expanded(

            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Container(
                height: 100,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 270,
                        width: double.maxFinite,

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                "images/garbage.png",
                              ),
                              fit: BoxFit.fill,
                            )),


                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:30,bottom: 30 ),
                        child: Container(
                          height: 10,
                          width: double.maxFinite,
                          color: Colors.white,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Stationeditprofile()),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ]),

                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Edit Profile",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Stationnotification()),
                            );
                          },

                          child: Container(
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ]),

                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Manage Notification",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {

                            localStorage = await SharedPreferences.getInstance();
                            localStorage.setBool('login', true);
                            Navigator.pushReplacement(context,
                                new MaterialPageRoute(builder: (context) => LoginPage()));

                          },

                          child: Container(
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ]),

                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Logout",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
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

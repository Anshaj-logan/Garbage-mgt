import 'package:flutter/material.dart';
import 'package:garbage_management/login.dart';
import 'package:garbage_management/screens/volunteer/view_request.dart';
import 'package:garbage_management/screens/volunteer/volunteer_editprofile.dart';
import 'package:garbage_management/screens/volunteer/volunteer_notification.dart';
import 'package:garbage_management/screens/volunteer/volunteer_public_bin_view.dart';
import 'package:garbage_management/screens/volunteer/volunteer_request_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Volunteeerhome extends StatefulWidget {
  const Volunteeerhome({Key? key}) : super(key: key);

  @override
  State<Volunteeerhome> createState() => _VolunteeerhomeState();
}

class _VolunteeerhomeState extends State<Volunteeerhome> {

  late String login_id,user_id;
  Future<void> getLogin() async {
    localStorage = await SharedPreferences.getInstance();
    login_id = (localStorage.getString('login_id') ?? '');
    user_id = (localStorage.getString('user_id') ?? '');
    print('volun_dashlogin ${login_id}');
    print('volun_id ${user_id}');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogin();
  }
  late SharedPreferences localStorage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(backgroundColor: Colors.red,elevation: 0,toolbarHeight: 10),
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

                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: 190,
                        width: double.maxFinite,

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                "images/66152.jpg",
                              ),
                              fit: BoxFit.fill,
                            )),


                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10,bottom: 20 ),
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
                            MaterialPageRoute(builder: (context) => Volunteereditprofile()),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.red,
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
                            MaterialPageRoute(builder: (context) => Volunteernotification()),
                          );
                        },

                        child: Container(
                          height: 50,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.red,
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ViewRequest()),
                          );
                        },

                        child: Container(
                          height: 50,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.red,
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
                              Text("Request View",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.white),)
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
                            MaterialPageRoute(builder: (context) => Volunteerpublicbinview()),
                          );
                        },

                        child: Container(
                          height: 50,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.red,
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
                              Text("Public Bin View",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.white),)
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
                              color: Colors.red,
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


        ],

      ),
    );
  }
}

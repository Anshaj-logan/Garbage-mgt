import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/screens/recycle_station/station_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api.dart';

class Stationeditprofile extends StatefulWidget {
  const Stationeditprofile({Key? key}) : super(key: key);

  @override
  State<Stationeditprofile> createState() => _StationeditprofileState();
}

class _StationeditprofileState extends State<Stationeditprofile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late String loginid, user_id;
  String name = "";
  String address = "";
  String phn = "";
  String email = "";
  String username = "";
  late SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    loginid = (prefs.getString('login_id') ?? '');
    print('login_idupdate ${loginid}');
    var res = await Api()
        .getData('/user/view-recycler-profile/' + loginid.replaceAll('"', ''));
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['stationname'];
      print(name);
      address = body['data']['address'];
      phn = body['data']['phonenumber'];
      email = body['data']['email'];

      nameController.text = name;
      addressController.text = address;
      phnController.text = phn;
      emailController.text = email;
    });
  }

  _update() async {
    prefs = await SharedPreferences.getInstance();
    loginid = (prefs.getString('login_id') ?? '');

    setState(() {
      var _isLoading = true;
    });

    var data = {
      "stationname": nameController.text,
      "address": addressController.text,
      "email": emailController.text,
      "phonenumber": phnController.text,
      "login_id": loginid.replaceAll('"', '')
    };
    print(data);
    var res = await Api().authData(data, '/user/update-recycler-profile');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Stationhome()),
      );
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          "images/43022.jpg",
                        ),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.black26),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black12,
                    ),
                    label: Text(
                      "Station name",
                      style: TextStyle(color: Colors.black26),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black12),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black12,
                    ),
                    label: Text(
                      "Email",
                      style: TextStyle(color: Colors.black12),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: phnController,
                  style: TextStyle(color: Colors.black26),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black12,
                    ),
                    label: Text(
                      "Phone Number",
                      style: TextStyle(color: Colors.black26),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: addressController,
                  style: TextStyle(color: Colors.black26),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.home,
                      color: Colors.black12,
                    ),
                    label: Text(
                      "Address",
                      style: TextStyle(color: Colors.black26),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     style: TextStyle(color: Colors.black26),
              //     cursorColor: Colors.blue,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(30.0),
              //         ),
              //       ),
              //       prefixIcon: Icon(
              //         Icons.location_on_outlined,
              //         color: Colors.black12,
              //       ),
              //       label: Text(
              //         "Location",
              //         style: TextStyle(color: Colors.black26),
              //       ),
              //       // suffixIcon: Icon(Icons.mic,color: Colors.green,),
              //     ),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(right: 10),
              //       child: Text(
              //         "Forgot password ?",
              //         style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.green),
              //       ),
              //     )
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                    height: 40,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.green),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: () {
                        setState(() {
                          _update();
                        });
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

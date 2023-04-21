import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/screens/user/user_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Volunteer_home.dart';

class Volunteereditprofile extends StatefulWidget {
  const Volunteereditprofile({Key? key}) : super(key: key);

  @override
  State<Volunteereditprofile> createState() => _VolunteereditprofileState();
}

class _VolunteereditprofileState extends State<Volunteereditprofile> {

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late String loginid,user_id;
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
    user_id = (prefs.getString('user_id') ?? '');
    print('login_idupdate ${user_id}');
    var res = await Api()
        .getData('/user/view-volunteer-profile/' + user_id.replaceAll('"', ''));
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['volunteername'];
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
      "volunteername": nameController.text,
      "address": addressController.text,
      "email": emailController.text,
      "phonenumber": phnController.text,
      "login_id": loginid.replaceAll('"', '')
    };
    print(data);
    var res = await Api().authData(data, '/user/update-volunteer-profile');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Volunteeerhome()),
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
                          "images/4782264.jpg",
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
                child: TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.black26),
                  cursorColor: Colors.green,
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
                      "Volunteer name",
                      style: TextStyle(color: Colors.black26),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (valueMail) {
                    if (valueMail!.isEmpty) {
                      return 'Please enter Email Id';
                    }
                    RegExp email = new RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    if (email.hasMatch(valueMail)) {
                      return null;
                    } else {
                      return 'Invalid Email Id';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,

                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.green,
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
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Mobile Number';
                    }
                    RegExp number = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                    if (number.hasMatch(value)) {
                      return null;
                    } else {
                      return 'Invalid Mobile Number';
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: phnController,

                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.green,
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
                      style: TextStyle(color: Colors.black12),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enterAddress';
                    }

                  },
                  controller: addressController,

                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.location_city,
                      color: Colors.black12,
                    ),
                    label: Text(
                      "Address",
                      style: TextStyle(color: Colors.black12),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                    height: 40,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.green),
                    child:ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.amberAccent),
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

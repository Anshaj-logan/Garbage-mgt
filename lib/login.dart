import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/register_dashboard.dart';
import 'package:garbage_management/screens/recycle_station/station_home.dart';
import 'package:garbage_management/screens/user/user_home.dart';
import 'package:garbage_management/screens/volunteer/Volunteer_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/admin/admin_homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final email = TextEditingController();
  final pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String user = "1";
  String volunteer="2";
  String recycle="3";

  String storedvalue = "1";
  late SharedPreferences localStorage;
  String loginId = '';
  String role = '';
  String status = '';
  bool _isLoading = false;
  bool _obscureText = true;
  late String  loginid;


  _pressLoginButton() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'username': email.text.trim(), //username for email
      'password': pwd.text.trim()
    };
    print("demo detail${data}");
    var res = await Api().authData(data,'/login');
    var body = json.decode(res.body);
    print('body${body}');
    if (body['success'] == true) {
      print(body);

      role = json.encode(body['role']);
      status = json.encode(body['status']);

      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('role', role.toString());
      localStorage.setString('login_id', json.encode(body['login_id']));
      localStorage.setString('user_id', json.encode(body['user_id']));

       print('role ${role}');
       print('status ${status}');
      if (user == role.replaceAll('"', '') &&
          storedvalue == status.replaceAll('"', '')) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Userhome()));
      } else if (volunteer == role.replaceAll('"', '') &&
          storedvalue == status.replaceAll('"', '')) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Volunteeerhome(),
        ));
      } else if (recycle == role.replaceAll('"', '') &&
          storedvalue == status.replaceAll('"', '')) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Stationhome(),
        ));
      }  else {
        Fluttertoast.showToast(
          msg: "Please wait for admin approval",
          backgroundColor: Colors.grey,
        );
      }


    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  @override
  void dispose() {
    email.dispose();
    pwd.dispose();
    // TODO: implement dispose
    super.dispose();
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

                      image: DecorationImage(
                        image: AssetImage(
                          "images/5260432.jpg"

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
                      "Welcome back",
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
                  controller: email,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black12,
                    ),
                    label: Text(
                      "Username",
                      style: TextStyle(color: Colors.black26),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: pwd,
                  obscureText: true,
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
                      Icons.lock,
                      color: Colors.black12,
                    ),
                    label: Text(
                      "Password",
                      style: TextStyle(color: Colors.black12),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "Forgot password ?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(

                    height: 40,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: () {
                        _pressLoginButton();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )),
              ),

              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Don\t have an account?',
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Sign Up',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => MainDash(),
                                ));
                              })
                      ]),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/login.dart';

import 'Volunteer_home.dart';

class Volunteerregistration extends StatefulWidget {
  const Volunteerregistration({Key? key}) : super(key: key);

  @override
  State<Volunteerregistration> createState() => _VolunteerregistrationState();
}

class _VolunteerregistrationState extends State<Volunteerregistration> {


  bool _isLoading = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController corpController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  List Corpid = [];
  String? selectId;
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    addressController.dispose();
    phnController.dispose();
    emailController.dispose();
    confirmController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  Future getAllId()async{
    var res = await Api().getData('/user/view-corporation');
    var body = json.decode(res.body);

    print(res);
    setState(() {
      print(body);
      Corpid=body['data'];
      // depart_id = body['data'][0]['_id'];

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllId();
  }
  final _formKey = GlobalKey<FormState>();
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "username": usernameController.text.trim(),
      "password": passwordController.text.trim(),
      "volunteername": nameController.text.trim(),
      "address": addressController.text.trim(),
      "corporation_id": selectId,
      "phonenumber": phnController.text.trim(),
      "email": emailController.text.trim(),
    };
    print('reg data${data}');

    var res = await Api().authData(data,'/user/volunteer');
    var body = json.decode(res.body);
    print('reg body${body}');
    if(body['success']==true)
    {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

    }
    else
    {
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
                      // borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          "images/54950.jpg",
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
                      "Create Account",
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
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)) ,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      hint: Text('CorporationId'),
                      style: TextStyle(color: Colors.black),
                      value: selectId,
                      items: Corpid
                          .map((type) => DropdownMenuItem<String>(
                        value: type['_id'].toString(),
                        child: Text(
                          type['corporationname'].toString(),
                          style: TextStyle(color: Colors.black26),
                        ),
                      ))
                          .toList(),
                      onChanged: (type) {
                        setState(() {
                          selectId = type;
                        });
                      }),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please choose a name to use";
                    }
                  },
                  controller: usernameController,
                  style: TextStyle(color: Colors.black),
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
                      "User name",
                      style: TextStyle(color: Colors.black12),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (valuePass) {
                    if (valuePass!.isEmpty) {
                      return 'Please enter your Password';
                    }else if(valuePass.length<6){
                      return 'Password too short';
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
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
                      style: TextStyle(color: Colors.black26),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child:  TextFormField(
                  obscureText: true,
                  validator: (valueConPass) {
                    if (valueConPass!.isEmpty) {
                      return 'Please confirm your Password';
                    } else if (valueConPass.length<6) {
                      return 'Please check your Password';
                    }else if (valueConPass == passwordController){
                      return null;
                    }
                  },
                  controller: confirmController,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black12,
                    ),
                    label: Text(
                      "Conform Password",
                      style: TextStyle(color: Colors.black26),
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
                    child:ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        registerUser();
                      },
                      child: Text(
                        "Register",
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

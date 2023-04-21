
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/screens/user/user_request_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addrequest extends StatefulWidget {
  const Addrequest({Key? key}) : super(key: key);

  @override
  State<Addrequest> createState() => _AddrequestState();
}

class _AddrequestState extends State<Addrequest> {
  late String user_id;
  late SharedPreferences localStorage;
  bool _isLoading = false;
  DateTime selectedDate = DateTime.now();

  late String startDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDate =
        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _statuscontroller = TextEditingController();
  void addRequest()async{
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getString('user_id') ?? '');

    setState(() {
      _isLoading = true;
    });

    var data = {
      "user_id":user_id.replaceAll('"', '') ,
      "garbage_status":_statuscontroller.text.trim(),
      "date":startDate,
    };
    print(data);
    var res = await Api().authData(data, '/request/add-request');
    var body = json.decode(res.body);

    if(body['success']==true)
    {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        this.context, //add this so it uses the context of the class
        MaterialPageRoute(
          builder: (context) => Userrequestcollection(),
        ), //MaterialpageRoute
      );
      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));

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
    return Scaffold(      backgroundColor: Colors.white,
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
                          "images/Wavy_Ppl-02_Single-05.jpg",
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
                      "Add Requests",
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
                  controller:_statuscontroller ,
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
                      "Garbage Status",
                      style: TextStyle(color: Colors.black26),
                    ),
                    // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(

                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8-.0),
                    child: Container(
                      height: 45,
                      width: 150,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('${selectedDate.year}-${selectedDate
                            .month}-${selectedDate.day}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black38
                          ),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select date'),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                    height: 40,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.green),
                    child:ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.purple),
                      onPressed: () {
                        setState(() {
                          addRequest();
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

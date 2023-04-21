import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/screens/user/user_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Volunteer_home.dart';

class Volunteernotification extends StatefulWidget {
  const Volunteernotification({Key? key}) : super(key: key);

  @override
  State<Volunteernotification> createState() => _VolunteernotificationState();
}

class _VolunteernotificationState extends State<Volunteernotification> {
  DateTime selectedDate = DateTime.now();

  TextEditingController _notiController = TextEditingController();
  late String startDate;
  late SharedPreferences prefs;
  late String user_id, volunteer_id;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  List users = [];
  String? selectUser;
  /*Future<void> _selectDate(BuildContext context) async {
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
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();
  }

  Future getAllUsers() async {
    var res = await Api().getData('/user/view-users');
    var body = json.decode(res.body);

    setState(() {
      users = body['data'];
      print('userlist${users}');
      // depart_id = body['data'][0]['_id'];
    });
  }

  void addComplaint() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getString('user_id') ?? '');
    print('login_id_complaint ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "volunteer_id": user_id.replaceAll('"', ''),
      "user_id": selectUser,
      "notifications": _notiController.text,
    };
    print(data);

    var res = await Api().authData(data, '/user/add-notification');
    var body = json.decode(res.body);
    print('body${body}');
    if (body['success'] == true) {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        this.context, //add this so it uses the context of the class
        MaterialPageRoute(
          builder: (context) => Userhome(),
        ), //MaterialpageRoute
      );
      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));
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
                        "images/2892359.jpg",
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
                    "Notifications",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.maxFinite,
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    hint: Text('Users'),
                    value: selectUser,
                    items: users
                        .map((type) => DropdownMenuItem<String>(
                              value: type['_id'].toString(),
                              child: Text(
                                type['name'].toString(),
                                style: TextStyle(color: Colors.black45),
                              ),
                            ))
                        .toList(),
                    onChanged: (type) {
                      setState(() {
                        selectUser = type;
                      });
                    }),
              ),
            ),
            /* Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8 - .0),
                  child: Container(
                    height: 45,
                    width: 150,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                        style: TextStyle(fontSize: 16, color: Colors.black38),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Start date'),
                ),
              ],
            ),*/
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
                right: 20,
              ),
              child: TextField(
                controller: _notiController,
                style: TextStyle(color: Colors.black26),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.message,
                    color: Colors.black12,
                  ),
                  label: Text(
                    "Notifications",
                    style: TextStyle(color: Colors.black26),
                  ),
                  // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                ),
              ),
            ),
            Row(
              children: [
                /*  Expanded(

                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 20),
                    child: Container(
                      height: 50,
                      width: 50,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue,
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
                          Text("Send",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                ),*/
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        addComplaint();
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Volunteeerhome()),
                        );*/
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

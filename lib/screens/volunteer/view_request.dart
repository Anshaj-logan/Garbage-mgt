import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/screens/volunteer/Volunteer_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewRequest extends StatefulWidget {
  const ViewRequest({Key? key}) : super(key: key);

  @override
  State<ViewRequest> createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  String complaint = '';
  late SharedPreferences localStorage;

  late String login_id, _id;
  late bool _isExpanded;
  late bool isExpanded = false;
  List request = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    viewRequest();
    _isExpanded = false;
  }

  void viewRequest() async {
    localStorage = await SharedPreferences.getInstance();
    login_id = (localStorage.getString('login_id') ?? '');

    var res = await Api().getData('/request/view-all-request');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode == 201) {
      var body = json.decode(res.body)['data'];
      print(body);
      setState(() {
        request = body;
      });
    } else {
      setState(() {
        request = [];
        Fluttertoast.showToast(
          msg: "No Complaints yet",
          backgroundColor: Colors.grey,
        );
      });
    }
  }

  void acceptRequest() async {
    var res = await Api().getData('/request/volunteer-accept-request/' + _id);
    var body = json.decode(res.body);
    print(body);
    Fluttertoast.showToast(
      msg: "Accepted",
      backgroundColor: Colors.grey,
    );
  }

  void rejectRequest() async {
    var res = await Api().getData('/request/volunteer-reject-request/' + _id);
    var body = json.decode(res.body);
    print(body);
    Fluttertoast.showToast(
      msg: "Rejected",
      backgroundColor: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Garbage Management"),
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Volunteeerhome(),
              ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Requests",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent),
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: request.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _id = request[index]['_id'];
                    print("id${_id}");
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.lightBlueAccent),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              acceptRequest();
                                            });
                                          },
                                          child: Text(
                                            "ACCEPT",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.lightBlueAccent),
                                        height: 50,
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              rejectRequest();
                                            });
                                          },
                                          child: Text(
                                            "REJECT",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                      child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(request[index]['garbage_status']),
                                  request[index]['date'] == null
                                      ? Text("No date available")
                                      : Text(request[index]['date']),
                                ],
                              ),
                            ),
                            /*    ExpandIcon(
                            isExpanded: _isExpanded,
                            color: Colors.black,
                            expandedColor: Colors.black,
                            disabledColor: Colors.grey,
                            onPressed: (bool isExpanded) {
                              setState(() {
                                _isExpanded = isExpanded;
                              });
                            },
                          ),*/
                          ],
                        ),
                      ],
                    ),
                  )),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}

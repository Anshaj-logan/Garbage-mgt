import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/screens/recycle_station/station_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api.dart';
import '../volunteer/Volunteerlogin.dart';

class Stationnotification extends StatefulWidget {
  const Stationnotification({Key? key}) : super(key: key);

  @override
  State<Stationnotification> createState() => _StationnotificationState();
}

class _StationnotificationState extends State<Stationnotification> {
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

    var res = await Api().getData('/request/view-all-request-recycler');
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
    var res = await Api().getData('/request/recycler-accept-request/' + _id);
    var body = json.decode(res.body);
    print(body);
    Fluttertoast.showToast(
      msg: "Accepted",
      backgroundColor: Colors.grey,
    );
  }

  // List vol_id = [];
  // String? selectId;
  // Future getAllId() async {
  //   var res = await Api().getData('/user/view-volunteers');
  //   var body = json.decode(res.body);
  //
  //   print(res);
  //   setState(() {
  //     print(body);
  //     vol_id = body['data'];
  //     // depart_id = body['data'][0]['_id'];
  //   });
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getAllId();
  // }

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
                        "images/Wavy_Bus-22_Single-05.jpg",
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
                    "View-Notifications",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ],
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
                                  // Expanded(
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 30.0),
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           borderRadius:
                                  //               BorderRadius.circular(50),
                                  //           color: Colors.lightBlueAccent),
                                  //       height: 50,
                                  //       child: TextButton(
                                  //         onPressed: () {
                                  //           setState(() {
                                  //             rejectRequest();
                                  //           });
                                  //         },
                                  //         child: Text(
                                  //           "REJECT",
                                  //           style: TextStyle(
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.bold,
                                  //               color: Colors.white),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
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
          ],
        ),
      ),
    );
  }
}
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: SizedBox(
//     width: double.maxFinite,
//     child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30)),
//         ),
//         hint: Text('voluntier_name'),
//         style: TextStyle(color: Colors.black),
//         value: selectId,
//         items: vol_id
//             .map((type) => DropdownMenuItem<String>(
//                   value: type['volunteername'].toString(),
//                   child: Text(
//                     type['volunteername'].toString(),
//                     style: TextStyle(color: Colors.black26),
//                   ),
//                 ))
//             .toList(),
//         onChanged: (type) {
//           setState(() {
//             selectId = type;
//           });
//         }),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.only(
//     left: 20,
//     top: 20,
//     right: 20,
//   ),
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
//         Icons.message,
//         color: Colors.black12,
//       ),
//       label: Text(
//         "Notifications",
//         style: TextStyle(color: Colors.black26),
//       ),
//       // suffixIcon: Icon(Icons.mic,color: Colors.green,),
//     ),
//   ),
// ),

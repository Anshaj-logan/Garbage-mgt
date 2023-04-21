import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/Widgets/background.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/screens/user/add_complaint.dart';
import 'package:garbage_management/screens/user/model_comp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserComplaints extends StatefulWidget {
  const UserComplaints({Key? key}) : super(key: key);

  @override
  State<UserComplaints> createState() => _UserComplaintsState();
}

class _UserComplaintsState extends State<UserComplaints> {

  final TextEditingController _reply = TextEditingController();
  String garstatus='';
  late SharedPreferences localStorage;
  bool _isLoading = false;
  late String user_id;
  List Complaints = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    viewComplaints();
  }
  void viewComplaints()async{
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getString('user_id') ?? '');

    var res = await Api().getData('/complaint/user-added-complaints/'+user_id.replaceAll('"', ''));

    if (res.statusCode == 201) {
      var body = json.decode(res.body)['data'];

      print("req${body}");
      setState(()  {
        Complaints = body;
        print("req${Complaints}");

      });
    } else {
      setState(() {
        Complaints = [];
        Fluttertoast.showToast(
          msg: "No requests yet",
          backgroundColor: Colors.grey,
        );


      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(image: 'images/5112782.jpg'),
        Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Complaints',
              style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: Column(
                children:<Widget> [

                  SizedBox(height:20),
                  ListView.builder(
                    shrinkWrap:true,
                    itemCount: Complaints.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Container(

                          color: Colors.black54,
                          child: Row(

                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      Text(Complaints[index]['complaint_title'],
                                        style:TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ) ,),
                                      Text(
                                          'Description :'+Complaints[index]['description'],
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                      Text(
                                          'Date :'+Complaints[index]['date'],
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                      Text(
                                          'Time :'+Complaints[index]['time'],
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(onPressed: (){
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            left: 20,
                                            right: 20,
                                            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                              (Complaints[index]['reply'] == null) ? Text("No reply available"): Text(Complaints[index]['reply']),

                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                               /* Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => UserComplaints(),
                                                ));*/
                                              },
                                              child: const Text('OK'),
                                            )
                                          ],
                                        ),
                                      );
                                    });

                                },
                                    child: Text("View Reply")),
                              ),
                              SizedBox(width: 8,),

                            ],
                          ),
                        ),
                      );
                    },
                  )
                ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Complaint(),
              ));
            },
            tooltip: 'Add Complaints',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}



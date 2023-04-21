import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/Widgets/background.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/screens/user/addrequest.dart';
import 'package:garbage_management/screens/user/request_model.dart';
import 'package:garbage_management/screens/user/user_home.dart';
import 'package:garbage_management/screens/user/user_payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userrequestcollection extends StatefulWidget {
  const Userrequestcollection({Key? key}) : super(key: key);

  @override
  State<Userrequestcollection> createState() => _UserrequestcollectionState();
}

class _UserrequestcollectionState extends State<Userrequestcollection> {
  String garstatus='';
  late SharedPreferences localStorage;
  bool _isLoading = false;
  late String user_id,req_id;
  List requests = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    viewRequest();
  }

  void viewRequest()async{
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getString('user_id') ?? '');

    var res = await Api().getData('/request/user-added-request/'+user_id.replaceAll('"', ''));

    if (res.statusCode == 201) {
      var body = json.decode(res.body)['data'];

      print("req${body}");
      setState(()  {
        requests = body;
        print("req${requests}");

      });
    } else {
      setState(() {
        requests = [];
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
        BackgroundImage(image: 'images/4202055.jpg'),
        Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Userhome()));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text(
              'RequestCollections',
              style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: ()async {
                      req_id=requests[index]['_id'];
                      localStorage = await SharedPreferences.getInstance();
                      localStorage.setString('_id', req_id.toString());
                      print("req ${req_id}");

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Userpayments(),
                      ));
                    },
                    child: Card(
                      child: Container(
                        color: Colors.black54,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((requests[index]['garbage_status']),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        )),
                                    Text(('Date : '+requests[index]['date']),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        )),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
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
                builder: (context) => Addrequest(),
              ));
            },
            tooltip: 'Add request',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

/* SingleChildScrollView(
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
                        "images/4202055.jpg",
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
                    "View Request Status",
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
              child: Container(
                child: Text('hellokshbgwjhbgljadjibgilajdbtgkakldfjbgsjhdbgllfndhlkfnmghklmsklnhlsnzdlkmo',style: TextStyle(fontSize: 20,color: Colors.grey),),
                height: 250,
                width: double.maxFinite,
                decoration: BoxDecoration(border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Userhome()),
                  );
                },
                child: Container(
                  height: 50,
                  width: 80,
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
                      Text("Ok",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),


          ],

        ),
      ),
*/

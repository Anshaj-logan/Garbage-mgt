import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/Widgets/background.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/screens/user/user_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPay extends StatefulWidget {
  const ViewPay({Key? key}) : super(key: key);

  @override
  State<ViewPay> createState() => _ViewPayState();
}

class _ViewPayState extends State<ViewPay> {
  bool _isLoading = false;

  List payments = [];
  late SharedPreferences localStorage;
  late String user_id, login_id;

  late String startDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewPay();
  }

  void viewPay() async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getString('user_id') ?? '');

    var res = await Api().getData(
        '/payment/user-payment-details/' + user_id.replaceAll('"', ''));

    if (res.statusCode == 201) {
      var body = json.decode(res.body)['data'];

      print("req${body}");
      setState(() {
        payments = body;
        print("req${payments}");
      });
    } else {
      setState(() {
        payments = [];
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
              'Payments',
              style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      color: Colors.black54,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Date :' +
                                          payments[index]['date'].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
                                  Text('Amount :' + payments[index]['amount'],
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
                  );
                },
              )
            ]),
          ),
        ),
      ],
    );
  }
}

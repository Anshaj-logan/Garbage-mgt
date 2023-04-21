import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garbage_management/api.dart';
import 'package:garbage_management/screens/user/user_home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userpayments extends StatefulWidget {
  const Userpayments({Key? key}) : super(key: key);

  @override
  State<Userpayments> createState() => _UserpaymentsState();
}

class _UserpaymentsState extends State<Userpayments> {
  late String user_id, req_id;
  TextEditingController amount = TextEditingController();
  late SharedPreferences localStorage;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _statuscontroller = TextEditingController();
  void addPayment() async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getString('user_id') ?? '');
    req_id = (localStorage.getString('_id') ?? '');

    setState(() {
      _isLoading = true;
    });

    var data = {
      "user_id": user_id.replaceAll('"', ''),
      "amount": amount.text,
      "request_id": req_id
    };
    print(data);
    var res = await Api().authData(data, '/payment/add-payment');
    var body = json.decode(res.body);

    print("body${body}");
    if (res.statusCode == 201) {
      print("success${body}");
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Alert(
          context: context,
          title: "Paid",
          image: Container(
              height: 150,
              width: 150,
              child: Image.asset('images/success.png')),
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Userhome()),
              ),
              color: Color.fromRGBO(0, 179, 134, 1.0),
            ),
          ]).show();

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
        title: Text("Payment"),
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
                        "images/19199679.jpg",
                      ),
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLength: 10,
                style: TextStyle(color: Colors.black26),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0.0),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: Colors.black12,
                  ),

                  label: Text(
                    "Card Number",
                    style: TextStyle(color: Colors.black26),
                  ),

                  hintText: " 0000-0000-0000-0000",
                  hintStyle: TextStyle(color: Colors.black26),
                  // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.black26),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0.0),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.add_card_outlined,
                              color: Colors.black12,
                            ),
                            label: Text(
                              "CVC",
                              style: TextStyle(color: Colors.black26),
                            ),
                            hintText: "CVC",
                            hintStyle: TextStyle(color: Colors.black26),
                            // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.black26),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0.0),
                              ),
                            ),
                            /*  prefixIcon: Icon(
            Icons.credit_card,
            color: Colors.black12,
          ),*/
                            label: Text(
                              "MM/YY",
                              style: TextStyle(color: Colors.black26),
                            ),
                            hintText: " MM/YY",
                            hintStyle: TextStyle(color: Colors.black26),
                            // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: amount,
                style: TextStyle(color: Colors.black26),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.monetization_on_sharp,
                    color: Colors.black12,
                  ),
                  label: Text(
                    "Amount",
                    style: TextStyle(color: Colors.black26),
                  ),
                  // suffixIcon: Icon(Icons.mic,color: Colors.green,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  addPayment();
                  /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Userhome()),
                    );*/
                },
                child: Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.purple,
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
                        "Ok",
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
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:garbage_management/screens/user/user_home.dart';

import 'User_Registration.dart';

class Userlogin extends StatelessWidget {
  const Userlogin({Key? key}) : super(key: key);

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
                height: 300,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,

                    image: DecorationImage(
                      image: AssetImage(
                          "images/1603.m00.i104.n024.S.c12.136115477 People map. Communication and social networks map icon.jpg"

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
              child: TextField(
                style: TextStyle(color: Colors.black26),
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
                    "Email/Username",
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
              child: TextField(
                style: TextStyle(color: Colors.black12),
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
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Userregistration(),));
                    },
                    child: Text(
                      "Forgot password ?",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
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
                  child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.orange),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Userhome()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
            ),
          ],
        ),
      ),

    );
  }
}

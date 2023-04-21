import 'package:flutter/material.dart';
import 'package:garbage_management/login.dart';
import 'package:garbage_management/register_dashboard.dart';
import 'package:garbage_management/screens/user/add_complaint.dart';
import 'package:garbage_management/splash_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash_screen',
        routes: {

          '/splash_screen': (BuildContext context) => SplashScreen(),
         // '/forgot_pwd': (context) => Forgot(),
          '/dashboard': (context) => MainDash(),
        }
    );
  }
}

class Recycle extends StatelessWidget {
  const Recycle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home:Complaint(),
    );
  }
}
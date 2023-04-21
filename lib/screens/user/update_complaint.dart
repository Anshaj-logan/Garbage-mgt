
import 'package:flutter/material.dart';
import 'package:garbage_management/screens/user/user_complaints.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateComplaint extends StatefulWidget {
  const UpdateComplaint({Key? key}) : super(key: key);

  @override
  State<UpdateComplaint> createState() => _UpdateComplaintState();
}

class _UpdateComplaintState extends State<UpdateComplaint> {


  TextEditingController _compcontroller = TextEditingController();
  TextEditingController _descontroller = TextEditingController();
  TextEditingController _locontroller = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timecontroller = TextEditingController();
  bool _isLoading = false;

  late SharedPreferences prefs;
  late String user_id,login_id;


  DateTime selectedDate = DateTime.now();

  late String startDate;
  final _formKey = GlobalKey<FormState>();

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



  updateComplaint()async{

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: ElevatedButton(
              style: ElevatedButton.styleFrom
                (backgroundColor: Colors.lightBlueAccent),
              onPressed: () {
                updateComplaint();
                // Navigator.of(context).push( MaterialPageRoute(builder: (context)=>View_Comp()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 115, left: 115),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )),
          appBar: AppBar(
            title: Text("Complaint Management"),
            backgroundColor: Colors.lightBlueAccent,
            leading: IconButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserComplaints(),
              ));
            },
                icon: Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(

                  children: [

                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Complaint',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _compcontroller,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Complaint'),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _descontroller,
                      // controller: _vehicleNoController,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Description'),
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
                          child: const Text('Start date'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _timecontroller,
                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () async {
                        TimeOfDay? pickedTime =  await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if(pickedTime != null ){
                          print(pickedTime.format(context));   //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                          print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.

                          setState(() {
                            _timecontroller.text = formattedTime; //set the value of text field.
                          });
                        }else{
                          print("Time is not selected");
                        }
                      },
                      // controller: _vehicleNoController,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Time'),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Department',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),

                  ],
                ),
              ),
            ),
          )),
    );
  }

}
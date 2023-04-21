
import 'package:flutter/material.dart';
import 'package:garbage_management/Widgets/background.dart';
import 'package:garbage_management/screens/admin/model/volunteer_model.dart';

class ManageVolunteer extends StatefulWidget {
  const ManageVolunteer({Key? key}) : super(key: key);

  @override
  State<ManageVolunteer> createState() => _ManageVolunteerState();
}

class _ManageVolunteerState extends State<ManageVolunteer> {
  static List<String> v_id = [
    '101',
    '102',
    '103',
  ];
  static List<String> v_name = [
    'name1',
    'name2',
    'name3',
  ];

  final List<Volunteer> model = List.generate(v_id.length,
          (index) => Volunteer(v_id[index], v_name[index]));


  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        BackgroundImage(image:'images/garbage.jpg'),
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
              'ManageVolunteer',
              style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
            ),
            centerTitle: true,
          ),
          body:Container(
            child: Column(
                children:<Widget> [

                  SizedBox(height:20),
                  ListView.builder(
                    shrinkWrap:true,
                    itemCount: v_id.length,
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
                                      Text("Id:" +model[index].v_id.toString(),
                                        style:TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ) ,),
                                      Text(
                                          model[index].v_name,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(onPressed: (){},
                                    child: Text("Approve")),
                              ),
                              SizedBox(width: 8,),
                              Expanded(
                                child: ElevatedButton(onPressed: (){

                                },
                                    child: Text("Remove")),
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

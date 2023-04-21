
import 'package:flutter/material.dart';
import 'package:garbage_management/Widgets/background.dart';
import 'package:garbage_management/screens/admin/model/user_model.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({Key? key}) : super(key: key);

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  static List<String> u_id = [
    '101',
    '102',
    '103',
  ];
  static List<String> u_name = [
    'done',
    'progress',
    'progress',
  ];

  final List<Users> model = List.generate(u_id.length,
          (index) => Users(u_id[index], u_name[index]));

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              'ManageUser',
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
                    itemCount: u_id.length,
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
                                      Text("Id:" +model[index].u_id.toString(),
                                        style:TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ) ,),
                                      Text(
                                          model[index].u_name,
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

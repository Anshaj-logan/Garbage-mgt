
import 'package:flutter/material.dart';
import 'package:garbage_management/Widgets/background.dart';
import 'package:garbage_management/screens/admin/model/recycle_model.dart';

class RecycleManage extends StatefulWidget {
  const RecycleManage({Key? key}) : super(key: key);

  @override
  State<RecycleManage> createState() => _RecycleManageState();
}

class _RecycleManageState extends State<RecycleManage> {
  static List<String> r_id = [
    '101',
    '102',
    '103',
  ];
  static List<String> co_id = [
    '101',
    '102',
    '103',
  ];
  static List<String> name = [
    'station1',
    'station2',
    'station3',
  ];
  static List<String> address = [
    'address1',
    'address1',
    'address1',
  ];
  static List<String> email = [
    'e@gmail.com',
    'a@gmail.com',
    'b@gmail.com',
  ];
  static List<String> location = [
    'loc1',
    'loc2',
    'loc3',
  ];
  static List<String> phn = [
    '9000000009',
    '7888889000',
    '0999990909',
  ];
  final List<RecycleModel> model = List.generate(r_id.length,
          (index) => RecycleModel(r_id[index],co_id[index], name[index],address[index],
              email[index],location[index],phn[index]));

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
              'RecycleStationManagement',
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
                    itemCount: r_id.length,
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
                                      Text(model[index].r_id.toString(),
                                        style:TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ) ,),
                                      Text(
                                          model[index].name,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          )),
                                      Text(
                                          model[index].address,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          )),
                                      Text(
                                          model[index].email,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          )),
                                      Text(
                                          model[index].phn,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
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

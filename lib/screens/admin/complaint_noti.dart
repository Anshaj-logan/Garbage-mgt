
import 'package:flutter/material.dart';
import 'package:garbage_management/Widgets/background.dart';
import 'package:garbage_management/screens/admin/model/notify_model.dart';

class ComplaintNotify extends StatefulWidget {
  const ComplaintNotify({Key? key}) : super(key: key);

  @override
  State<ComplaintNotify> createState() => _ComplaintNotifyState();
}

class _ComplaintNotifyState extends State<ComplaintNotify> {
  static List<String> n_id = [
    '101',
    '102',
    '103',
  ];
  static List<String> u_id = [
    '101',
    '102',
    '103',
  ];
  static List<String> title = [
    'complaint1',
    'complaint2',
    'complaint3',
  ];
  static List<String> desc = [
    'description1',
    'description2',
    'description3',
  ];
  static List<String> date = [
    '10-03-2023',
    '19-02-2023',
    '20-02-2023',
  ];
  static List<String> time = [
    '01:10PM',
    '2:00PM',
    '10:00AM',
  ];
  final List<NotifyModel> model = List.generate(u_id.length,
          (index) => NotifyModel(n_id[index],u_id[index], title[index],
              desc[index], date[index], time[index],));

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
                                          model[index].title,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                      Text(
                                          model[index].desc,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                      Text(
                                          model[index].date,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                  model[index].time,
                                  style:TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  )),
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

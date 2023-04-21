import 'package:flutter/material.dart';
import 'package:garbage_management/Widgets/background.dart';
import 'package:garbage_management/screens/admin/model/status_model.dart';

class PublicStatus extends StatefulWidget {
  const PublicStatus({Key? key}) : super(key: key);

  @override
  State<PublicStatus> createState() => _PublicStatusState();
}

class _PublicStatusState extends State<PublicStatus> {
  static List<String> description = [
    'des1',
    'des2',
    'de3',
  ];
  static List<String> status = [
    'done',
    'progress',
    'progress',
  ];

  final List<StatusModel> model = List.generate(description.length,
      (index) => StatusModel(description[index], status[index]));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(image:'images/garbage.jpg'),
        Scaffold(
          backgroundColor: Colors.black45,
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
              'PublicStatus',
              style: TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
            ),
            centerTitle: true,
          ),
          body:  Column(
            children: [
              SizedBox(height: 40,),
              ListView.builder(
                shrinkWrap:true,
                itemCount: description.length,
                itemBuilder: (context,index){
                  return Card(
                    child: Container(
                      color: Colors.black54,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text("Status:" +model[index].status,
                                  style:TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                  ) ,),
                                Text("Description:"+model[index].description,
                                    style:TextStyle(
                                      fontSize: 18,
                                        color: Colors.white
                                    )),
                              ],
                            ),
                          ),
                        ],

                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ),
      ],
    );
  }
}

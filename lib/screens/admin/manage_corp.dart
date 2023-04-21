
import 'package:flutter/material.dart';
import 'package:garbage_management/Widgets/background.dart';
import 'package:garbage_management/screens/admin/model/corp_model.dart';

class ManageCorporation extends StatefulWidget {
  const ManageCorporation({Key? key}) : super(key: key);

  @override
  State<ManageCorporation> createState() => _ManageCorporationState();
}

class _ManageCorporationState extends State<ManageCorporation> {

  static List<String> corp_id = [
    '101',
    '102',
    '103',
  ];
  static List<String> corp_name = [
    'done',
    'progress',
    'progress',
  ];
  static List<String> corp_phn = [
    '9000000009',
    '7888889000',
    '0999990909',
  ];
  static List<String> corp_add = [
    'address1',
    'address1',
    'address1',
  ];
  static List<String> corp_email = [
    'e@gmail.com',
    'a@gmail.com',
    'b@gmail.com',
  ];
  final List<CorpModel> model = List.generate(corp_id.length,
          (index) => CorpModel(corp_id[index],corp_name[index], corp_phn[index],
              corp_add[index],corp_email[index]));

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
              'ManageCorporation',
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
                    itemCount: corp_id.length,
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
                                      Text(model[index].corp_id.toString(),
                                        style:TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ) ,),
                                      Text(
                                          model[index].corp_name,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                      Text(
                                          model[index].corp_add,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          )),
                                      Text(
                                          model[index].corp_email,
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          )),
                                      Text(
                                          model[index].corp_phn,
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

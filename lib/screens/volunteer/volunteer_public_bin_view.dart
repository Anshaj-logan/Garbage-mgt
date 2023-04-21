import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Widgets/background.dart';
import 'Volunteer_home.dart';
import 'bin_model.dart';

class Volunteerpublicbinview extends StatefulWidget {
  const Volunteerpublicbinview({Key? key}) : super(key: key);

  @override
  State<Volunteerpublicbinview> createState() => _VolunteerpublicbinviewState();
}

String? stringResponse;
Map mapResponse = {};

class _VolunteerpublicbinviewState extends State<Volunteerpublicbinview> {
  static List<String> id = [
    '1',
    '2',
    '3',
  ];
  static List<String> num = [
    'Bin-1',
    'Bin-2',
    'Bin-3',
  ];

  static List<String> area = [
    'Raiway',
    'Beach',
    'KSRTC',
  ];

  String binvalue = '';
  String sliced = '';

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/2059822/fields/1.json?api_key=P46UHWAFHUHCBRCO&results=3'));
    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body;
        mapResponse = jsonDecode(response.body);
        print(mapResponse);
        // binvalue = "${mapResponse['feeds'][0]['field1'] ?? ''}";
        // sliced = binvalue.substring(2, 4);
        // print(sliced);
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  final List<BinModel> model = List.generate(
      id.length, (index) => BinModel(id[index], num[index], area[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Stack(
        children: [
          BackgroundImage(image: 'images/3744337.jpg'),
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
                'View Status',
                style:
                    TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
              ),
              centerTitle: true,
            ),
            body: Container(
              child: Column(children: <Widget>[
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: id.length,
                  itemBuilder: (context, index) {
                    binvalue = "${mapResponse['feeds'][index]['field1'] ?? ''}";
                    sliced = binvalue.substring(2, 4);
                    print(sliced);
                    return Card(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              AssetImage("images/bin.webp"),
                                        ),
                                        Text(
                                          model[index].num,
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 80,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2),
                                          ),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Center(
                                          child: Text(
                                        "${sliced} %",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20),
                                      )),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      model[index].area,
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ]),
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
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';
import 'package:hackapp/homepage_components/detailspage.dart';
import 'package:hackapp/components/hackathons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackapp/components/sizeConfig.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackapp/homepage_components/addHack.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Hackathon>> getHacks() async {
    int end=0;
    int i=1;
    List<Hackathon> hacks = [];
    while(end==0){
    Map<String, String> headers = {"authtoken": "test"};
    var response = await http.get(
        "https://hackportal.herokuapp.com/events/getevents/$i",
        headers: headers);
    if (response.statusCode == 200) {
      var hackathonsJson = jsonDecode(response.body);
      if(response.body!='[]'){
      for (var u in hackathonsJson) {
        Hackathon hack = Hackathon(
            description: u['description'],
            location: u['location'],
            end: u['endDate'],
            start: u['startDate'],
            url: u['eventUrl'],
            name: u['nameOfEvent'],
            id: u['_id']);
        hacks.add(hack);
      }
      i++;
      print(i);
    }
      else{
        end=1;
      }
    }
  }
    return hacks;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(2,0,8,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Text(
                      '''Hacks happening
around you''',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Muli'
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddHack()));
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(decoration: TextDecoration.underline,fontSize: 22,),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            child: FutureBuilder(
              future: getHacks(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Container(
                      child: SpinKitFoldingCube(
                        size: 50,
                        color: kConstantBlueColor,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 13, 5),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5,0,5,0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      snapshot.data[index].name,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 35),
                                    ),
                                  ),
                                  padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6, 0, 0, 16),
                                  child: Text(
                                    snapshot.data[index].description,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HackDetails(
                                              hackathon: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Learn More',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          height: 242,
                          decoration: BoxDecoration(
                            color: kConstantBlueColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

//Container(
//child: Padding(
//padding: const EdgeInsets.all(8.0),
//child: Text(
//hackathons[index],
//style: TextStyle(color: Colors.white),
//),
//),
//height: 190,
//decoration: BoxDecoration(
//color: Color(0xff98C1D9),
//borderRadius: BorderRadius.only(
//bottomRight: Radius.circular(30),
//topLeft: Radius.circular(30)),
//),
//),

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


void main() => runApp(MaterialApp(
  home: covidtracker(),
));

typedef void func();
var data;

class retrieveData{

  static String url = 'https://disease.sh/v3/covid-19/jhucsse';

  static Future<void> getD(func f) async {
    var response = await http.get(url);
    print(response);
    if(response.statusCode ==200){
      data=convert.jsonDecode(response.body);
      print("Retrieved${data}");
      f();
    }else{
      print('not Retrieved: ${response.statusCode}.');
    }
  }
}

class covidtracker extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class DataPoint{
  String date;
  int conf;
  int deat;
  int reco;
  DataPoint(this.date, this.conf, this.deat, this.reco);
}

class _MyHomePageState extends State<covidtracker> {

  List<DataPoint> timeline = List<DataPoint>();

  void loadData(){
    setState(() {
      data = data['timelineitems'][0];

      data.forEach((key, val){
        print('${key},${val}');
        if(key != 'county' && key != 'updatedAt'){

         timeline.add(DataPoint(key, 1,2,3));
        }
      });

      print('${timeline.length}hello');
      print("\n\n");
      print(timeline);
    });
  }
  static String url = 'https://disease.sh/v3/covid-19/jhucsse';

  static Future<void> getD(func f) async {
    var response = await http.get(url);
    print(response);
    if(response.statusCode ==200){
      data=convert.jsonDecode(response.body);
      print("Retrieved${data}");
      f();
    }else{
      print('not Retrieved: ${response.statusCode}.');
    }
  }

/*@override
   Future<void> initState() async {
   super.initState();
    await getD(loadData);
  }*/

  @override
  Future<Widget> build(BuildContext context) async {
    await getD(loadData);
    print('main UI${data}');
    if(data == null){
      return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Center(
            child: Text(
              'Covid-19 Tracker',
            ),
          ),
          backgroundColor: Colors.grey[850],
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                child: Icon(Icons.show_chart, color: Colors.white,),
                onTap: (){},
                splashColor: Colors.red[650],
              ),
            ),
          ],
        ),
        body: Center(child: Text('Loading Data...'),),
      );
    }
    else{
      return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Center(
            child: Text(
              'Covid-19 Tracker',
            ),
          ),
          backgroundColor: Colors.grey[850],
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                child: Icon(Icons.show_chart, color: Colors.white,),
                onTap: (){},
                splashColor: Colors.red[650],
              ),
            ),
          ],
        ),
        body: ShowListView(timeline),
      );
    }
  }
}

class ShowListView extends StatelessWidget {
  final List<DataPoint> timeline;

  ShowListView(this.timeline);

  @override
  Widget build(BuildContext context) {
    print(timeline.length);
    print("\n\n");
    return ListView.builder(
        itemCount: timeline.length,
        itemBuilder: (context, index){
          return Column(
              children: <Widget>[
                ListTile(
                  leading: Text("${timeline[index].date}"),
                  title:  Center(child: Text("Total Cases: {timeline[index].num}")),
                ),
                Divider(),
              ]
          );
        }
    );
  }
}
//class covidtracker extends StatelessWidget {
//  @override
 //  Widget build(BuildContext context) {

 //    return Scaffold(
 //     backgroundColor: Colors.grey[900],
 //       appBar: AppBar(
//        title: Text('Covid 19 Tracker'),
 //        backgroundColor: Colors.grey[850],
 //       elevation: 0.0,
//      )
 //    );
//   }
// }

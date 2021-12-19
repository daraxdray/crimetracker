// @dart=2.9

import 'package:crimetracker/crimeList.dart';
import 'package:crimetracker/first_page.dart';
import 'package:flutter/material.dart';
import 'package:crimetracker/addCrime.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crime Report',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: HomePage(),
      )
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.all(50),
              child:
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text("Welcome to Crime Report", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                      height: 150,
                      width: 300,
                      child: Image( image: AssetImage('assets/police.png'))
                  ),
                  Text("Add New Crime"),
                  ElevatedButton(onPressed: ()=>
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCrimePage())), child: Icon(Icons.add)),

                ],
              )
          ),
        Container(
          child:
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CrimeListView())), child: Text("Admin")),
              ElevatedButton(onPressed: ()=>
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FirstPage())), child: Text("Register"))
            ],
          ),
        )
        ],
      )
    ),

    );
  }
}

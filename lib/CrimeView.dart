import 'dart:io';

import 'package:crimetracker/main.dart';
import 'package:crimetracker/model/crime.dart';
import 'package:crimetracker/repository/db_provider.dart';
import 'package:crimetracker/repository/EngineRoom.dart';
import 'package:crimetracker/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:search_map_place/search_map_place.dart';
import 'package:image_picker/image_picker.dart';

class CrimePage extends StatelessWidget {
 final Crime crime;

  const CrimePage({Key? key, required this.crime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: CrimeView(crime:crime),
      )
    );
  }
}

class CrimeView extends StatefulWidget {
  final Crime crime;

   CrimeView({Key? key, required this.crime}) : super(key: key);

  @override
  _CrimeViewState createState() => _CrimeViewState();
}

class _CrimeViewState extends State<CrimeView> {
  String currentImage = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentImage = widget.crime.img;
  }

  @override
  Widget build(BuildContext context) {
    Crime crime = widget.crime;



    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 300,
                child: CircleAvatar(
                    radius: 200,
                    child: Image.file(File(currentImage),
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Container(
                            height: 100,
                            width: 100,
                            child: InkWell(
                              child: Image.file(File(crime.img)),
                              onTap: ()=>{
                                setState(() {
                                  currentImage = crime.img;
                                })
                              },
                            )
                        ),
                        Container(
                            height: 100,
                            width: 100,
                            child: InkWell(
                              child: Image.file(File(crime.img2)),
                              onTap: ()=>{
                                setState(() {
                                  currentImage = crime.img2;
                                })
                              },
                            )
                        ),
                        Container(
                            height: 100,
                            width: 100,
                            child: InkWell(
                              child: Image.file(File(crime.img3)),
                              onTap: ()=>{
                                setState(() {
                                  currentImage = crime.img3;
                                })
                              },
                            )
                        ),

                      ]
                  )
              ),
              Container(
                  margin: EdgeInsets.only(top:20),
                  child: Text("${crime.cName}",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),)),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                        child: Text("Crime Location:  ")
                    ),
                    Container(child: Text("${crime.cLocation}",style: TextStyle(
                        fontSize: 13,
                        color: Colors.black26
                    ),)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                        child: Text("Reporter Location:  ")
                    ),
                    Container(child: Text("${crime.longLat}",style: TextStyle(
                        fontSize: 13,
                        color: Colors.black26
                    ),)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                        child: Text("Description:  ")
                    ),
                    Container(child: Text("${crime.cDescription}",style: TextStyle(
                        fontSize: 13,
                        color: Colors.black26
                    ),)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                        child: Text("Description:  ")
                    ),
                    Container(child: Text("${DateTime.parse(crime.date)}",style: TextStyle(
                        fontSize: 13,
                        color: Colors.black26
                    ),)),
                  ],
                ),
              ),

            ]
        )
    );
  }
}


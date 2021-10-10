import 'package:crimetracker/CrimeView.dart';
import 'package:crimetracker/main.dart';
import 'package:crimetracker/model/crime.dart';
import 'package:crimetracker/repository/DbProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class CrimeListView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Crime List"),),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: DbProvider.db.getAllEvents(),
            builder: (builder, snapshot){
              if(snapshot.hasData) {
                List<Crime> crimeList = snapshot.data as List<Crime>;

                return  crimeList.length > 0? ListView.builder(
                    itemCount: crimeList.length,
                    itemBuilder: (context,index) {
                      File img = File(crimeList[index].img);
                  int dLen = crimeList[index].cDescription.length;

                    return Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text("${crimeList[index].cName}"),
                          leading: CircleAvatar(
                            radius: 20,
                            child: Image.file(img),
                          ),
                          tileColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(20),
                          subtitle: Text("${crimeList[index].cDescription.substring(0,dLen > 30?30:dLen)}..."),
                          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => CrimePage(crime: crimeList[index]))),
                        ),
                      );


                    }):
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    child: Text("No Crime Added yet",style: TextStyle(fontSize: 20),)
                );
              }
              return Container(
                  child: Center(
                    child:CircularProgressIndicator(),
                  )
              );
            },
          ),)
      ),
    );
  }

}
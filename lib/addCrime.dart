import 'dart:io';

import 'package:crimetracker/main.dart';
import 'package:crimetracker/model/crime.dart';
import 'package:crimetracker/repository/DbProvider.dart';
import 'package:crimetracker/repository/EngineRoom.dart';
import 'package:crimetracker/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:image_picker/image_picker.dart';

class AddCrimePage extends StatelessWidget {
  const AddCrimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 20),
            child: Column(
                children: [
                  Center( child: Text("Please Add new Crime")),
                  CrimeForm()
                ]
            )
        ),
      )
    );
  }
}


class CrimeForm extends StatefulWidget {
  const CrimeForm({key}) : super(key: key);

  @override
  _CrimeFormState createState() => _CrimeFormState();
}

class _CrimeFormState extends State<CrimeForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  bool _autoValidate = false;
  bool processing = false;
  bool locprocessing = false;
  TextEditingController eventName = TextEditingController();
  TextEditingController eventDesc = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController currentLocation = TextEditingController();
  File _image = File('');
  File _image2 = File('');
  File _image3 = File('');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _autoValidate = false;
    processing = false;

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: EdgeInsets.only(bottom: 15,right: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                        BorderRadius.all(Radius.circular(12))),
                    child: TextFormField(
                      enabled: true,
                      controller: eventName,
                      validator: (string){
                        if(string == "") return "Please enter event title";
                        return null;
                      }
                      ,
                      style: TextStyle(color: Colors.black,),
                      decoration: InputDecoration(
                          labelText: " Event Name",
                          labelStyle: TextStyle(color: Colors.black26,),
                          fillColor: Colors.white,

                      ),
                    )),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: EdgeInsets.only(bottom: 15,right: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                        BorderRadius.all(Radius.circular(12))),
                    child: TextFormField(
                      enabled: true,
                      controller: eventDesc,
                      validator: (string){
                          if(string == "") return "Please enter event description";
                          return null;
                        },
                      style: TextStyle(color: Colors.black,),
                      decoration: InputDecoration(
                          labelText: "Event Description",
                          labelStyle: TextStyle(color: Colors.black26),
                          fillColor: Colors.black26),
                    )),
                // Container(
                //     height: 50,
                //     width: MediaQuery.of(context).size.width * 0.7,
                //     margin: EdgeInsets.only(bottom: 15,right: 10),
                //     padding: EdgeInsets.only(bottom: 10),
                //     decoration: BoxDecoration(
                //         color: Colors.grey[200],
                //         borderRadius:
                //         BorderRadius.all(Radius.circular(12))),
                //     child: TextFormField(
                //       enabled: true,
                //       validator: (string){
                //         if(string == "") return "Please enter event location";
                //         return null;
                //       },
                //       controller: location,
                //       style: TextStyle(color: Colors.black),
                //       decoration: InputDecoration(
                //           labelText: "Event Location",
                //           labelStyle: TextStyle(color: Colors.black26),
                //           fillColor: Colors.white),
                //     )),
                // Container(
                //     height: 50,
                //     width: MediaQuery.of(context).size.width * 0.7,
                //     margin: EdgeInsets.only(bottom: 15,right: 10),
                //     padding: EdgeInsets.only(bottom: 10),
                //     decoration: BoxDecoration(
                //         color: Colors.grey[200],
                //         borderRadius:
                //         BorderRadius.all(Radius.circular(12))),
                //     child: TextFormField(
                //       enabled: false,
                //       controller: currentLocation,
                //       style: TextStyle(color: Colors.white),
                //       decoration: InputDecoration(
                //           labelText: "Your current location",
                //
                //           labelStyle: TextStyle(color: Colors.white70),
                //           fillColor: Colors.white),
                //     )),

                Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: SearchMapPlaceWidget(
                      apiKey: apiKey,
                      darkMode: true,
                      icon: Icons.location_on,
                      placeholder: "Address",
                      onSelected: (Place place) async {
                        location.text = await place.description;
                        // var geo = await place.geolocation;
                      },
                    )),

                Container(
                    width: 190,
                    margin: EdgeInsets.only(top: 40),
                    child: locprocessing
                        ? Container(width:40, child: CircularProgressIndicator(backgroundColor: Colors.white,value: 5,)):
                Column(
                  children: [
                    Container(child: Text("${currentLocation.text}")),
                    TextButton(
                      // color: Colors.orange[500],
                      child: Row(
                          children: [
                            Icon(Icons.location_searching_sharp),
                            Text("Get My Location"),
                          ]
                      ),
                      onPressed: () async {
                        setState((){
                          locprocessing = true;
                        });
                        if (formKey.currentState!.validate())  {
                          currentLocation.text = await EngineRoom.getLocAddress();
                          setState(() {
                            locprocessing = false;
                          });
                        } else
                        {

                          setState(() {
                            _autoValidate = true;
                            locprocessing = false;
                          });
                        }
                      },
                    )
                  ],
                )

                ),
                Container(margin: EdgeInsets.all(50),
                  child: Text("Upload Pictures of Location")
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Container(
                        height: 100,
                        width: 100,
                        child: InkWell(
                          child:_image.path != '' ? Image.file(_image):Placeholder(),
                          onTap: ()=>{
                          selectImage(1)
                          },
                        )
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: InkWell(
                          child:_image2.path != '' ? Image.file(_image2):Placeholder(),
                          onTap: ()=>{
                          selectImage(2)
                          },
                        )
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: InkWell(
                          child:_image3.path != '' ? Image.file(_image3):Placeholder(),
                          onTap: ()=>{
                          selectImage(3)
                          },
                        )
                      ),

                    ]
                  )
                ),

                Container(
                    width: 200,
                    margin: EdgeInsets.only(top: 40),
                    child: processing
                        ? Container(width:40, child: CircularProgressIndicator(backgroundColor: Colors.white,value: 5,)):
                    ElevatedButton(
                      // color: Colors.orange[500],
                      onPressed: () {
                        setState((){
                          processing = true;
                        });
                        if (formKey.currentState!.validate() && currentLocation.text != "" && _image.path != "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saving data")));
                          setState(() {
                            processing = false;
                          });
                          saveData().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp())));

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please ensure all fields are filled")));
                          setState(() {
                            _autoValidate = true;
                            processing = false;
                          });
                        }
                      },
                      child: Text("Submit"),
                    )),
              ]
            )
        )
      ],
    );
  }


  Future<Crime> saveData(){


      Crime crime = new Crime.fromMap({
        'cName': eventName.text,
        'cDescription': eventDesc.text,
        'cLocation': location.text,
        'cCurrLocation': currentLocation.text,
        'dateCreated': DateTime.now().toString(),
        'img': _image.path,
        'img2': _image2.path,
        'img3': _image3.path
      });
      print(crime.cName);
      return DbProvider.db.insertDb(crime);
  }

  selectImage(im) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        switch(im){
          case 1:
        _image = File(image.path);
        break;
          case 2:
        _image2 = File(image.path);
            break;
         case 3:
        _image3 = File(image.path);
            break;
        }
      } else {
        print('No image selected.');
      }
    });
  }

}

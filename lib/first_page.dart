import 'package:crimetracker/main.dart';
import 'package:crimetracker/repository/db_provider.dart';
import 'package:flutter/material.dart';

import 'package:crimetracker/model/user.dart';



class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top:50),
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height:180,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Image.asset("assets/police.png")
            ),
            Container(
                child: Text("Welcome to Accident Tracker")
            ),Container(
                child: Text("Please register to proceed")
            ),
            UserForm()
          ],
        ),
      ),
    );
  }
}



class UserForm extends StatefulWidget {
  const UserForm({key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  // final ImagePicker _picker = ImagePicker();
  bool _autoValidate = false;
  bool processing = false;
  bool locprocessing = false;
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

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
                        controller: userName,
                        validator: (string){
                          if(string == "") return "Please enter your name";
                          return null;
                        }
                        ,
                        style: TextStyle(color: Colors.black,),
                        decoration: InputDecoration(
                          labelText: " User Full Name",
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
                        controller: userEmail,
                        validator: (string){
                          if(string == "") return "Please enter user email";
                          return null;
                        },
                        style: TextStyle(color: Colors.black,),
                        decoration: InputDecoration(
                            labelText: "user email",
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
                  //         if(string == "") return "Please enter user location";
                  //         return null;
                  //       },
                  //       controller: location,
                  //       style: TextStyle(color: Colors.black),
                  //       decoration: InputDecoration(
                  //           labelText: "user Location",
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
                        controller: location,
                        validator: (string){
                          if(string == "") return "Please enter user address in details";
                          return null;
                        },
                        style: TextStyle(color: Colors.black,),
                        decoration: const InputDecoration(
                            labelText: "user Location and Address",
                            labelStyle: TextStyle(color: Colors.black26),
                            fillColor: Colors.black26),
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
                        controller: phone,
                        keyboardType: TextInputType.number,
                        validator: (string){
                          if(string == "") return "Please enter user phone";
                          return null;
                        },
                        style: TextStyle(color: Colors.black,),
                        decoration: InputDecoration(
                            labelText: "User Phone number",
                            labelStyle: TextStyle(color: Colors.black26),
                            fillColor: Colors.black26),
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
                        controller: password,
                        obscureText:true,
                        keyboardType: TextInputType.text,
                        validator: (string){
                          if(string == "") return "Please enter password";
                          return null;
                        },
                        style: TextStyle(color: Colors.black,),
                        decoration: InputDecoration(
                            labelText: "User Phone number",
                            labelStyle: TextStyle(color: Colors.black26),
                            fillColor: Colors.black26),
                      )),

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
                          if (formKey.currentState!.validate()) {
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


  Future<User> saveData() async {


    User user = User.fromJson({
      'uName': userName.text,
      'uEmail': userEmail.text,
      'uAddress': location.text,
      'uPhone': phone.text,
      'uPassword': password.text,
      'dateCreated': DateTime.now().toString(),
    });
    print(user.name);
    return await DbProvider.db.insertDb(user,table:'USER') as User;
  }

}

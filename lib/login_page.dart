import 'package:crimetracker/main.dart';
import 'package:crimetracker/repository/db_provider.dart';
import 'package:crimetracker/addCrime.dart';
import 'package:crimetracker/model/user.dart';
import 'package:crimetracker/repository/db_provider.dart';
import 'package:flutter/material.dart';

import 'model/user.dart';



class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
          children: [
            Container(
              height:300,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset("assets/accident.png")
            ),
          Container(
            child: Text("Please Login")
          ),

          ],
      ),
    );
  }
}



class LoginForm extends StatefulWidget {
  const LoginForm({key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  // final ImagePicker _picker = ImagePicker();
  bool _autoValidate = false;
  bool processing = false;

  TextEditingController userEmail = TextEditingController();
  TextEditingController password = TextEditingController();
  // File _image = File('');
  // File _image2 = File('');
  // File _image3 = File('');
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
                        obscureText: true,
                        validator: (string){
                          if(string == "") return "Please enter your name";
                          return null;
                        }
                        ,
                        style: TextStyle(color: Colors.black,),
                        decoration: InputDecoration(
                          labelText: "Enter Password",
                          labelStyle: TextStyle(color: Colors.black26,),
                          fillColor: Colors.white,

                        ),
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
                            checkData().then((value) {
                              if (value == null) {
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(
                                    "Email or Password not recognized")));
                              }
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => AddCrimePage()));
                          });
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please ensure all fields are filled")));
                            setState(() {
                              _autoValidate = true;
                              processing = false;
                            });
                          }
                        },
                        child: const Text("Login"),
                      )),
                ]
            )
        )
      ],
    );
  }


  Future<User?> checkData() async {
    var user  = await  DbProvider.db.getUserByEmail(email:userEmail.text,password: password.text);
    // print(user.name);
    if(user == null){
      return null;
    }
    return user as User;
  }

}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new PartReg();
    throw UnimplementedError();
  }



}

class PartReg extends State<Register>{

  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.indigo,
      ),

      body: Container(

          child:Column(children: [
            new TextField(


              controller:email,
            ),

            new TextField(


              controller:password,
            ),



            new TextButton(onPressed:()=>Reg(email.text.trim(), password.text.trim()), child:new Text("Register"))
          ],)


      ),


    );
    throw UnimplementedError();
  }

  void saveToken(String token) async{

    final prefs=await SharedPreferences.getInstance();

    prefs.setString("token",token);


  }


  void getToken() async{

    final prefs=await SharedPreferences.getInstance();

    prefs.getString("token");


  }






  Future<void> Reg(String e,String p) async {


    Firebase.initializeApp();




         var f = FirebaseAuth.instance;

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: e, password: p).then((value) async {

      if(value.user!.email!.isNotEmpty){

        await f.currentUser!.sendEmailVerification();


          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login("لقد ارسلنا رابط تحقق الى بريدك الالكتروني اضغط عليه وسجل الدخول")),
          );


      }


    });






 }

  }
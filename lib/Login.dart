import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/GetDataAll.dart';
import 'package:flutter_firebase/Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class Login extends StatefulWidget{

  late String message;

  Login(this.message);

  @override
  State<StatefulWidget> createState() {
    
    return new PartLogin(message);
    throw UnimplementedError();
  }
  
  
  
  
}

class PartLogin extends State<Login>{

 late String message;


 PartLogin(this.message);

  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    
    
    return new Scaffold(
      
      appBar: AppBar(
        
        backgroundColor: Colors.indigo,
        
        
      ),
      
      body: new Container(

        child:Column(children: [
          new TextField(


            controller:email,
          ),

          new TextField(


            controller:password,
          ),



          new TextButton(onPressed:()=> Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new Register())),child:new Text("Register")),


          new TextButton(onPressed:()=>log(email.text.trim(), password.text.trim()), child:new Text("Login")),


          new TextButton(onPressed:()=>signInWithGoogle(), child:new Text("Sign With Google")),



          new TextButton(onPressed:()=>signInWithFacebook(), child:new Text("Sign With Facebook")),



           Text(message,style: new TextStyle(fontSize: 18.0,),maxLines: 2,),

        ],)








      ),
      
    );
    
    
    throw UnimplementedError();
  }

  void saveToken(String token) async{

    final prefs=await SharedPreferences.getInstance();

    prefs.setString("token",token);


  }

  Future<void> log(String e,String p) async {


    Firebase.initializeApp();


    var f = FirebaseAuth.instance;

   // if (f!.emailVerified) {

     var g=await f.signInWithEmailAndPassword(email: e, password: p);

   if(g.user!.emailVerified){
     print(g.user!.emailVerified.toString());
      // ).then((value) {
      //   if (value.user != null) {
      //
           saveToken(g.user!.uid);
      //
      //
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => new GetDataAll()));
      //   }
      // });
    }else{
      print(g.user!.emailVerified.toString());
      print("noAUTH");

    }


  }





 Future<UserCredential> signInWithGoogle() async {
   // Trigger the authentication flow
   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

   // Obtain the auth details from the request
   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

   // Create a new credential
   final credential = GoogleAuthProvider.credential(
     accessToken: googleAuth.accessToken,
     idToken: googleAuth.idToken,
   );

   saveToken(credential.token.toString());
   Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => new GetDataAll()));
   // Once signed in, return the UserCredential
   return await FirebaseAuth.instance.signInWithCredential(credential);
 }



 Future<UserCredential> signInWithFacebook() async {
   // Trigger the sign-in flow
   final AccessToken result = await FacebookAuth.instance.login();

   // Create a credential from the access token
   final facebookAuthCredential = FacebookAuthProvider.credential(result.token);

   saveToken(facebookAuthCredential.idToken.toString());
   Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => new GetDataAll()));
   // Once signed in, return the UserCredential
   return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
 }

  
  
}
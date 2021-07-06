


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/AddData.dart';
import 'package:flutter_firebase/Login.dart';
import 'package:flutter_firebase/Model.dart';
import 'package:flutter_firebase/UpData.dart';

import 'package:shared_preferences/shared_preferences.dart';
class GetDataAll extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {


    return new PartGet();
    throw UnimplementedError();
  }


}


final fire=FirebaseDatabase.instance.reference().child("inform");


class PartGet extends State<GetDataAll>{
  late FirebaseAuth auth;



  late Query _ref;

  // if(f!.email==null){

  getShared() async {



    final prefs=await SharedPreferences.getInstance();


    if(prefs.getString("token").toString()=="null"){
      print(prefs.getString("token").toString()+"kkkkkk");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login("")),);
      return;
    }else{
      print(prefs.getString("token").toString()+"stoooooop");

    }
  }


  @override
  initState()  {
    super.initState();

    getShared();

    // Firebase.initializeApp().whenComplete((){
    //   final uid=FirebaseAuth.instance.currentUser!.uid;
    //
    //   if(uid!=prefs){
    //
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
    //
    //     print('kkkkkkkkk');
    //     return;
    //   }
    //
    //
    // });

    




    _ref = FirebaseDatabase.instance
        .reference()
        .child('inform');
  }



  


  Widget _buildContactItem({required Map contact}) {


    return  Container(
      //
       margin: EdgeInsets.symmetric(vertical: 5),
       padding: EdgeInsets.all(5),
       height: 180,
      color: Colors.white,
      child:new ListView(
        children: [

       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['name'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.phone_iphone,
                color: Theme.of(context).accentColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['age'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 15),
              Icon(
                Icons.group_work,
                color: Colors.grey,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),

            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {

                },
                child: Row(
                  children: [
                    Icon(

                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                   new  TextButton(onPressed:()=> Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => new UpData(contact['id'],contact['name'],contact['age']))),

                            // color: Theme.of(context).primaryColor,
                            // fontWeight: FontWeight.w600
                             child:new Text("upDate")),
                  ],
                ),
              ),

              SizedBox(
                width: 20,
                child: new Text("تعديل",
                  style: TextStyle(
                    fontSize: 16,

              ),
    ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    ),
                    SizedBox(
                      width: 6,
                      
                    ),
                  new TextButton(onPressed:()=>Delete(contact['id']),child:new Text('Delete',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red[700],
                            fontWeight: FontWeight.w600))
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),


          new Container(
        child:Image.network(contact['image']),
          ),

        ],


      ),
        ],
      )
    );

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build





    return Scaffold(
      appBar: AppBar(
        title: Text('My Contacts'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {

              logout();
            },
          ),
    ]
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            contact['key'] = snapshot.key;

            return _buildContactItem(contact: contact);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddData()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
    throw UnimplementedError();
  }








  void Delete(var id){
    
    var f=FirebaseDatabase.instance.reference().child("inform");
    
    f.child(id).remove();
    
  }



Future<void> logout() async {

  final prefs=await SharedPreferences.getInstance();

  prefs.remove("token");


      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => new Login("")));


}



}
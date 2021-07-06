import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/AddData.dart';

class UpData extends StatefulWidget{

  late String id,name,age;


  UpData(this.id, this.name, this.age);

  @override
  State<StatefulWidget> createState() {

    return new PartUp(id,name,age);
    throw UnimplementedError();
  }



}

class PartUp extends State<UpData>{

  late String id,name,age;


  PartUp(this.id, this.name, this.age);



  @override
  Widget build(BuildContext context) {


    TextEditingController nameup=new TextEditingController();
    TextEditingController ageup=new TextEditingController();

    nameup.text=name;
    ageup.text=age;
    initialValue(val) {
      return TextEditingController(text: val);
    }

    initialValueage(val) {
      return TextEditingController(text: val);
    }
    return new Scaffold(

      appBar: new AppBar(

        backgroundColor: Colors.indigo,
      ),

      body: new Container(

    child: new Column(children: [

      new TextField(


      controller:nameup,
    ),

      new TextField(


        controller:ageup,
      ),


    new TextButton(onPressed:()=>upDate(id,nameup.text,ageup.text), child:new Text("upDate"))

    ],),
    ),

    );



    throw UnimplementedError();
  }


  void upDate(var id,String name,String age){


    fire.child(id).set({
      'id':id,
      "name":name,
      "age":age,
    });



  }



}
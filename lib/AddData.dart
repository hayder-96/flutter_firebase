
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:date_format/date_format.dart';
import 'package:image_picker/image_picker.dart';

class AddData extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new PartAdd();
    throw UnimplementedError();
  }


}
final fire=FirebaseDatabase.instance.reference().child("inform");

class PartAdd extends State<AddData>{

  var f;

  Future getImage() async{

    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickedFile != null) {

      setState(() {
        print(pickedFile.path);

        f= File(pickedFile.path);
      });

    }
  }





  addData(String n,String a,File ff){

    var t=formatDate(new DateTime.now(),[yyyy,'-','mm','-',dd]);

    var fullname="/image/${n}_$t";
    var ref=FirebaseStorage.instance.ref().child(fullname);
    var im=ref.putFile(ff);

    var url=im.storage.ref().getDownloadURL();



    print(url.toString());

    var id=fire.push().key;
    fire.child(id).set({
      "id":id,
      "name":n,
      "age":a,
      'image':url
    });
  }



  @override
  Widget build(BuildContext context) {


    TextEditingController name=new TextEditingController();
    TextEditingController age=new TextEditingController();

    return new Scaffold(

      appBar: new AppBar(

        backgroundColor: Colors.indigo,
      ),

      body: new Container(

        child: new Column(children: [


          new TextButton(onPressed:getImage, child:new Text("اضف صورة")),




          new TextField(

            controller: name,
          ),

          new TextField(

            controller: age,
          ),


          new TextButton(onPressed:()=>addData(name.text,age.text,f), child:new Text("save")),


         new Container(

           child:f==null?Text(""):Image.file(f),


         ),


        ],),
      ),
    );

    throw UnimplementedError();
  }





}














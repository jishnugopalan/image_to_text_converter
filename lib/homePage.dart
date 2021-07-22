import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String result="";
  late File image=File('assets/camera.png');
  late Future<File>imageFile;
  late ImagePicker imagePicker;


  pickimagefromgallery() async{
     PickedFile pickedFile=await imagePicker.getImage(source: ImageSource.gallery);
    image=File(pickedFile.path);
    setState(() {
      // ignore: unnecessary_statements
      image;
      performImageLabeling();
    });

  }
  captureImagewithCamera() async{
    PickedFile pickedFile=await imagePicker.getImage(source: ImageSource.camera);
    image=File(pickedFile.path);
    setState(() {
      // ignore: unnecessary_statements
      image;
      performImageLabeling();
    });

  }
  performImageLabeling() async{
    final FirebaseVisionImage firebaseVisionImage=FirebaseVisionImage.fromFile(image);
    final TextRecognizer recognizer=FirebaseVision.instance.textRecognizer();
    VisionText visionText=await recognizer.processImage(firebaseVisionImage);
    result="";
    setState(() {
      for(TextBlock block in visionText.blocks){
        final String txt=block.text;
        for(TextLine line in block.lines){
          for(TextElement element in line.elements){
            result+=element.text+" ";
          }
        }
        result+="\n\n";
      }
    });
  }

  @override
  void initState(){
    super.initState();
    imagePicker=ImagePicker();

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image to Text"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'),fit: BoxFit.cover


          ),


        ),
        child:Column(
          children: [
            SizedBox(width: 300,),
    Container(
    height: 280,
    width: 450,
    margin: EdgeInsets.only(top: 70),
    padding: EdgeInsets.only(left: 28,bottom: 5,right: 18),
    child: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
    result,style: TextStyle(fontSize: 16.0),
    textAlign: TextAlign.justify,
    ),
    ),
    ),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/note.jpg'),fit: BoxFit.cover


    ),
    )
    ),
            Container(

              child:Column(

                children: [


                  Center(


                    child: ElevatedButton(
                      onPressed: (){
                        pickimagefromgallery();
                      },
                      onLongPress: (){
                        captureImagewithCamera();
                      },
                      child: Text("Pick an image")
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    // ignore: unnecessary_null_comparison
                    child: image!=null ? Image.file(image,width: 360,height: 240,fit: BoxFit.fill,): Container(
                      width: 240,
                      height: 200,
                      child: Icon(Icons.camera,size: 100,color: Colors.grey),
                    ),
                  ),
                ],

              ),
            )

          ],
        ),

      ),


    );
  }
}

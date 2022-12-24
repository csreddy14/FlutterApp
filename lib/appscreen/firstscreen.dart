import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ImagePicker imagePicker;
  File _image;
  List result;

  String _name = "";
  String _confidence = "";
  //TODO declare ImageLabeler
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
    //TODO initialize labeler
    loadMyModel();
  }

  _imgFromCamera() async {
    PickedFile pickedFile =
    await imagePicker.getImage(source: ImageSource.camera);
    _image = File(pickedFile.path);
    applyModelOnImage(_image);
    setState(() {
      _image;
    });
  }

  _imgFromGallery() async {
    PickedFile pickedFile =
    await imagePicker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    applyModelOnImage(_image);
    setState(() {
      _image;
    });
  }

  loadMyModel() async {
    var resultant = await Tflite.loadModel(
        labels: "assets/mylabels.txt",
        model: "assets/my_model_unquant.tflite");
    print("Result after loading model: $resultant");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5
    );

    setState(() {
      result = res;

      String str = result[0]["label"];

      _name = str.substring(2);
      _confidence = result != null
          ? (result[0]['confidence']*100.0).toString().substring(0,2) + "%"
          : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Animal Identifier'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
          //backgroundColor: Colors.purple,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple,Colors.blueAccent],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                )
            ),
          ),
          elevation: 20,
          titleSpacing: 20,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/backgroundOpn.jpeg'), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 100,
              ),
              Container(
                margin: EdgeInsets.only(top: 185),
                child: Stack(children: <Widget>[
                  Stack(children: <Widget>[
                    Center(
                      child: Image.asset(
                        'images/frame3.png',
                        height: 220,
                        width: 220,
                      ),
                    ),
                  ]),
                  Center(
                    child: FlatButton(
                      onPressed: _imgFromGallery,
                      onLongPress: _imgFromCamera,
                      child: Container(
                        margin: EdgeInsets.only(top: 10.1),
                        child: _image != null
                            ? Image.file(
                          _image,
                          width: 130,
                          height: 198,
                          fit: BoxFit.fill,
                        )
                            : Container(
                          width: 140,
                          height: 150,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  "Name: $_name \nConfidence: $_confidence",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: 'finger_paint', fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

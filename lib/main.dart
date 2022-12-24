import 'package:flutter/material.dart';
import '/appscreen/firstscreen.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage()

  ));
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(child: Opacity(opacity: 0.4,
              child:Image.asset('images/backgroundHome.jpg',
                fit: BoxFit.cover,),),),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child:ClipOval(
                      child: Container(
                        width: 180,
                        height: 180,
                        color: Colors.green,
                        alignment: Alignment.center,
                        child: Image.asset('assets/icons/icon1.jpeg'),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text('Animal Identifier',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 40),),
                  SizedBox(height:50),
                  Text('Find your day interesting through Animal Identifier',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:Colors.white,fontSize: 20
                    ),),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: FlatButton(onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder:(context)=>MyHomePage()
                          )
                      );
                    }, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                      color: Colors.green,
                      splashColor: Colors.deepOrange,
                      padding: EdgeInsets.all(25),
                      child: Text('Continue!',
                        style: TextStyle(color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),);
  }
}
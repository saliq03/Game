import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'level1.dart';

class LevelsPage extends StatefulWidget{
  @override
  State<LevelsPage> createState()=>MyLevelsPage();

}
class MyLevelsPage extends State<LevelsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,right: 30,bottom: 10
        ),
        child: MyLevels(),
      ),
    );
  }
//  List of buttons to show as different levels
  ListView  MyLevels(){
    return ListView.builder(itemBuilder: (context,position){
      return Column(children: [
        SizedBox(
          width: double.infinity,
        height: 45,
        child: LevelButton(() {
          switch (position) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => Level1()),);
              break;
            case 1:
              // next levels
        
          }
        }, position+1),
      ),
        SizedBox(height: 15,)
      ],);
    },
    itemCount: 15,
    scrollDirection: Axis.vertical,
    // shrinkWrap: true,
    );
  }


  // Button that represent level
  ElevatedButton LevelButton(VoidCallback callback,int index){
    return ElevatedButton(
      onPressed:(){callback();} ,
      child: Text("Level $index",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
      style:ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))
      ),);
  }

}
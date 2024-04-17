
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'level1.dart';

class ScoreCard extends StatefulWidget{
  String Title;
  int Score;
  int life;
  ScoreCard(this.Title,this.Score,this.life);
  @override
  State<ScoreCard> createState() => _ScoreCard(this.Title,this.Score,this.life);
}
class _ScoreCard extends State<ScoreCard>{
  String Title;
  int Score;
  int life;
  int TotalScore=0;
  _ScoreCard(this.Title,this.Score,this.life);

  var myStars = [
    Icons.star_border_outlined,
    Icons.star_border_outlined,
    Icons.star_border_outlined,
  ];
  String titleImg='';
  @override
  void initState() {
    super.initState();
    WinorLose(life);
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

  TotalScore=Score+(life*5);
   return Scaffold(
     body:Container(
       width: double.infinity,
       height: double.infinity,
       color: Colors.yellow.shade200,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.only(right: 8,left: 8),
             child: Image.asset(titleImg),
           ),
           Row(crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(myStars[0],color: Colors.orangeAccent,size: 60,),
               Padding(
                 padding: const EdgeInsets.only(bottom: 50),
                 child: Icon(myStars[1],color: Colors.orangeAccent,size: 100,),
               ),
               Icon(myStars[2],color: Colors.orangeAccent,size: 60,),
              ],),
           Column(children: [
             Text("Total Score:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
             Container(
               width: 80,
               decoration: BoxDecoration(border: Border.all(color: CupertinoColors.black,width: 2)),
               child: Center(child: Text('$TotalScore',style: TextStyle(fontSize: 20),)),
             )
           ],),

             Bottomview(life)
         ]
       ),
     ) ,
   );
  }

  void WinorLose(int life){
    if(life==0){
      titleImg='assets/images/scorecard/failed.png';
    }
    else{
      for(int i=0;i<life;i++){
        myStars[i]=Icons.star;
      }
      titleImg='assets/images/scorecard/completed.png';
    }
  }

  Row Bottomview(int life){
    if(life>0){
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: (){ Navigator.pop(context);}, icon: Icon(Icons.menu_rounded,color: Colors.blueAccent,size:70 ,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_right_outlined,color: Colors.blueAccent,size:70)),
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Level1()),);
            }, icon: Icon(Icons.replay_circle_filled_rounded,color: Colors.blueAccent,size:70))
        ],);
    }
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(onPressed: (){ Navigator.pop(context);}, icon: Icon(Icons.menu_rounded,color: Colors.blueAccent,size:70 ,)),
        IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Level1()),);
        }, icon: Icon(Icons.replay_circle_filled_rounded,color: Colors.blueAccent,size:70))
      ],);

  }
}
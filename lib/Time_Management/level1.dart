
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meity_game/Time_Management/ScoreCard.dart';

class Level1 extends StatefulWidget{
  @override
  State<Level1> createState() => _Level1();
}
class _Level1 extends State<Level1>{
  var imgString=['','','','','','',''];
  var images=[  'assets/images/waking.png',
    'assets/images/breakfast.png',
    'assets/images/school.png',
    'assets/images/lunch.png',
    'assets/images/play.png',
    'assets/images/dinner.png',
    'assets/images/bed.png',
  ];

  Map<String ,bool>isaccepted={
   'assets/images/waking.png':false,
    'assets/images/breakfast.png':false,
    'assets/images/school.png':false,
    'assets/images/lunch.png':false,
    'assets/images/play.png':false,
    'assets/images/dinner.png':false,
    'assets/images/bed.png':false,
     };

  Map<String ,String>activitySound={
    'assets/images/waking.png':'audio/waking.mp3',
    'assets/images/breakfast.png':'audio/breakfast.mp3',
    'assets/images/school.png':'audio/school.mp3',
    'assets/images/lunch.png':'audio/lunch.mp3',
    'assets/images/play.png':'audio/play.mp3',
    'assets/images/dinner.png':'audio/dinner.mp3',
    'assets/images/bed.png':'audio/bed.mp3',
    };

  var iconsData = [
    Icons.favorite,
    Icons.favorite,
    Icons.favorite,
  ];

  int life=3;
  int score=0;
  final player=AudioPlayer();

@override
  void initState() {
    super.initState();
    images.shuffle();
    playsound('audio/Match.mp3');
  }

  @override
  Widget build(BuildContext context) {

   var _mediaquery=MediaQuery.of(context);

   SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_mediaquery.size.height*0.1),
        child: AppBar(
          backgroundColor: Colors.blue.shade400,
          title: Text("Daily Routine Puzzle",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
        ),),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ScoreRow(_mediaquery.size),
            // dragtarget
            Row(
              children: [
                SizedBox(width: 10,),
                dragTargetRoutineBox('assets/images/waking.png', '8:00 AM',0,_mediaquery.size),
                SizedBox(width: 10,),
                dragTargetRoutineBox('assets/images/breakfast.png','9:00 AM',1,_mediaquery.size),
                SizedBox(width: 10,),
                dragTargetRoutineBox('assets/images/school.png','10:00 AM',2,_mediaquery.size),
                SizedBox(width: 10,),
                dragTargetRoutineBox('assets/images/lunch.png', '1:00 PM',3,_mediaquery.size),
                SizedBox(width: 10,),
                dragTargetRoutineBox('assets/images/play.png','4:00 PM',4,_mediaquery.size),
                SizedBox(width: 10,),
                dragTargetRoutineBox('assets/images/dinner.png','8:00 PM',5,_mediaquery.size),
                SizedBox(width: 10,),
                dragTargetRoutineBox('assets/images/bed.png','10:00 PM',6,_mediaquery.size),



              ]
            ),
            SizedBox(height: _mediaquery.size.height*0.1,),

            //Draggable
            Row(
              children: [
                SizedBox(width: 10,),
                draggableRoutineBox(images[3],_mediaquery.size),
                SizedBox(width: 10,),
                draggableRoutineBox(images[4],_mediaquery.size),
                SizedBox(width: 10,),
                draggableRoutineBox(images[1],_mediaquery.size),
                SizedBox(width: 10,),
                draggableRoutineBox(images[5],_mediaquery.size),
                SizedBox(width: 10,),
                draggableRoutineBox(images[0],_mediaquery.size),
                SizedBox(width: 10,),
                draggableRoutineBox(images[6],_mediaquery.size),
                SizedBox(width: 10,),
                draggableRoutineBox(images[2],_mediaquery.size),

              ],
            )


            // top elements

          ],
        ),

      ),
    );
  }


// Row where we show timer ,life and score
  Container ScoreRow(Size size){
    return   Container(
      height: size.height*0.1,
      child: Row( crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 5,top: 5),
              child: SizedBox( height:25,width:25,child: Image.asset('assets/images/stopwatch.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text('00:00',style: TextStyle(fontSize: 15),),
            ),
          ],),

          // Row(children: [
          //
          // ],),

          Padding(
            padding: const EdgeInsets.only(top: 5,right: 8.0),
            child: Row(children: [
              Icon(iconsData[0],color: Colors.red,),
              Icon(iconsData[1],color: Colors.red,),
              Icon(iconsData[2],color: Colors.red,),
              Text("   Score: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text("$score ")],),
          ),


        ],),
    );
  }


           // Draggable Boxes
Draggable draggableRoutineBox (String img,Size size){
    return Draggable(
      data: img,
        child: Container(
          width: 100,height: size.height*0.3,color: Colors.greenAccent,
          child:  isaccepted[img]!=true?Image.asset(img,fit: BoxFit.cover,):Text(''),
        ),
        feedback: Container(
          width: 150,height: 150,
          child:  isaccepted[img]!=true?Image.asset(img):Text(''),
        ),
    childWhenDragging: Container(  width: 100,height: size.height*0.3,color: Colors.greenAccent,),
    
    onDragStarted: (){
        if(isaccepted[img]!=true){
          playsound(activitySound[img]!);
        }
    },  

    );
}


                            //  Drag-target Boxes
DragTarget<String> dragTargetRoutineBox(String img,String msg,int index,Size size){
    return DragTarget<String>(
        builder: (context,candidateData,rejectedData){
      return Container(
        width: 100,height: size.height*0.3,color: Colors.blueAccent,
        child:imgString[index]==img?Image.asset(img,fit: BoxFit.cover,):Center(child: Text(msg)),
      );
    },
    onWillAccept: (data){
      if(isaccepted[img]!=true&&isaccepted[data]!=true) {
       return true;
       }
       return false;
      },
    onAccept: (data) {
          print(data);
          print(img);
      if (data == img) {
        setState(() {
          imgString[index] = data;
          isaccepted[img] = true;
          playsound('audio/clap.wav');
          setState(() {
            score++;
            });
          if(score>=7){
            NavigateToScorecard(context,"Completed", score, life);
          }
         });
        }
      else {

        setState(() {
          life--;
          iconsData[life]=Icons.favorite_border_outlined;
        });
        if (life < 1) {
          playsound('audio/gameover.wav');
          NavigateToScorecard(context, "Failed", score, life);
        }
        else{playsound('audio/rejection.m4a');}
      }
    },
    );
}

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  Future<void> playsound(String sound) async {
    await player.play(AssetSource(sound));
  }

  void NavigateToScorecard(BuildContext context,String title,int score,int life){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScoreCard(title, score, life)),);
  }

}
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_musica/constant.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Musica(),
    );
  }
}

class Musica extends StatefulWidget {
  const Musica({Key? key}) : super(key: key);

  @override
  State<Musica> createState() => _MusicaState();
}

class _MusicaState extends State<Musica> {
  List<String> mylist= ['ar.mp3','br.mp3','cr.mp3', 'sr.mp3', 'same.mp3'];
  List<String> names=['25-25','Baller','Chobbar','Summer High','Same Beef'];
  int index=0;
  double slideval=0;
  bool isplay=false;
  final player=AudioPlayer();
  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    caldur();
    // player.onPositionChanged.listen((event) {
    //   position=event;
    // });
   }
  Future<void> caldur()async{
    await player.setSource(AssetSource(mylist[index]));
    duration=(await player.getDuration())!;
   // print(duration.inMinutes);
   // print(duration.inSeconds%60);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.indigoAccent.shade700,
            Colors.redAccent.shade400,
          ]),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Text('Musica',style: KTextStyle,),
              Container(
                height: 190,
                width: 150,
                decoration: BoxDecoration(image: DecorationImage(
                  image: AssetImage('assets/chob${index}.jpeg'),
                  fit: BoxFit.cover,
                ),),
              ),
              SizedBox(height: 10,),
              Text(names[index],style: KTextStyle,),
              SizedBox(height: 200,),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black38,),
                height: 60,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.skip_previous_outlined),color: Colors.white70,onPressed: (){
                      setState(() {
                        if(index>0){
                          index--;

                          caldur();
                        }
                        if(index<=0){
                          index=mylist.length-1;
                          caldur();
                        }
                      });
                    },),
                    IconButton(icon: (isplay==true)?Icon(Icons.pause):Icon(Icons.play_arrow),color: Colors.white70,onPressed: (){
                      setState(() {
                        isplay=!isplay;
                        (isplay==true)?player.play(AssetSource(mylist[index])):player.pause();
                      });
                    },),
                    IconButton(icon: Icon(Icons.skip_next_outlined),color: Colors.white70,onPressed: (){
                      setState(() {
                        if(index<mylist.length){
                          index++;
                          caldur();
                        }
                        if(index==mylist.length){
                          index=0;
                          caldur();
                        }
                      });
                    },),
                  ],
                ),
              ),
              Slider(value: slideval, onChanged: (double val)async{
                setState(() {
                  slideval=val;
                  //print(slideval);
                });
                await player.seek(Duration(seconds: slideval.toInt()));
              },max: duration.inSeconds.toDouble(),
                activeColor: Colors.pink,
              ),
              Text("${(slideval/60).floor()} : ${slideval.toInt()%60}",style: KTextStyle,),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        int ran=Random().nextInt(mylist.length);
        setState(() {
          index=ran;
        });
      }, label: Text('Shuffle'),
        icon: Icon(Icons.shuffle),
        backgroundColor: Colors.pink,
      ),
    );
  }
}


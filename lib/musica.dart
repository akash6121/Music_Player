import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:my_musica/constant.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dart:math';
class Musica extends StatefulWidget {
  const Musica({Key? key}) : super(key: key);

  @override
  State<Musica> createState() => _MusicaState();
}

class _MusicaState extends State<Musica> {
  List<String> mylist= ['ar.mp3','br.mp3','cr.mp3', 'sr.mp3', 'same.mp3'];
  List<String> names=['25-25','Baller','Chobbar','Summer High','Same Beef'];
  final List<Color> colours = [
    Colors.white,
    Colors.grey,
    Colors.purple,
    Colors.brown[900]!
  ];

  final List<int> duratio = [900, 700, 600, 800, 500];
  int index=0;
  double slideval=0;
  bool isplay=false;
  double ?screenheight;
  double ?screenwidth;
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
  @override
  Future<void> dispose()async{
    print("Disposing audio player");
    await player.stop();
    super.dispose();
  }
  Future<void> caldur()async{
    await player.setSource(AssetSource(mylist[index]));
    duration=(await player.getDuration())!;
    // print(duration.inMinutes);
    // print(duration.inSeconds%60);
  }
  @override
  Widget build(BuildContext context) {
   final size=MediaQuery.of(context).size;
   screenheight=size.height;
   screenwidth=size.width;
   // final arg=ModalRoute.of(context)!.settings.arguments;
    //index=arg[index];
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/chob${index}.jpeg'),
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.colorBurn),
            opacity: 100,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 9),
            child: Column(
              children: <Widget>[
                SizedBox(height: screenheight!*0.03,),
                Text('Musica',style: KTextStyle,),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 0),
                    child: Container(
                      height: screenheight!*0.3,
                      width: 400,
                      decoration: BoxDecoration(image: DecorationImage(
                        image: AssetImage('assets/chob${index}.jpeg'),
                        fit: BoxFit.cover,
                      ),),
                    ),
                  ),
                ),
                GradientText('Now Playing ', colors: [Colors.white,Colors.grey],style: TextStyle(fontSize: 20,),),
                Text(names[index],style: TextStyle(fontSize: screenheight!*0.06,color: Colors.white)),
                // Text(names[index],style: TextStyle(color: Colors.black54,fontSize: 30),),
                Align(child: FloatingActionButton(onPressed: (){
                  Navigator.pop(context);
                },backgroundColor: Colors.pink,child: Icon(Icons.reply_all_outlined),heroTag: 'btn1',),alignment: Alignment.centerLeft,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.skip_previous_outlined,size: 50,),color: Colors.white70,onPressed: (){
                      setState(() {
                        if(index>0){
                          index--;
                          caldur();
                        }
                        else if(index<=0){
                          index=mylist.length-1;
                          caldur();
                        }
                      });
                    },),
                    FloatingActionButton(child: (isplay==true)?Icon(Icons.pause,size: 50,):Icon(Icons.play_arrow,size: 50,),backgroundColor: Colors.pink,heroTag:'btn2',onPressed: (){
                      setState(() {
                        isplay=!isplay;
                        (isplay==true)?player.play(AssetSource(mylist[index])):player.pause();
                      });
                    },),
                    IconButton(icon: Icon(Icons.skip_next_outlined,size: 50,),color: Colors.white70,onPressed: (){
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
                //SizedBox(height: 10,),
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
                (isplay==true)?MusicVisualizer(colors: colours, duration: duratio, barCount: 30):Text(''),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        int ran=Random().nextInt(mylist.length);
        setState(() {
          index=ran;
          isplay=false;
          player.pause();
          caldur();
        });
      }, label: Text('Shuffle'),
        icon: Icon(Icons.shuffle),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

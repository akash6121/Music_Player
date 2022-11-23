import 'package:flutter/material.dart';
class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List<String> mylist= ['ar.mp3','br.mp3','cr.mp3', 'sr.mp3', 'same.mp3'];
  List<String> names=['25-25','Baller','Chobbar','Summer High','Same Beef'];
  List<String> singer=['Arjan Dhillon','Shubh','Jordan Sandhu','AP Dhillon','Bohemia'];
  int index=0;
  Widget createList(String img,String name,String singer){
    index++;
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/sec',arguments: {
          'index': index
        });
      },
      child: ListTile(
          leading: Image(image: AssetImage(img),),
          title: Text(name),
          subtitle: Text('Song by ${singer}', style: TextStyle(color: Colors.grey),),
          //contentPadding: EdgeInsets.all(15),
// tileColor: Colors.grey[850],
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 17,)
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    index=0;
    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: <Widget>[
              const Text('Playlist',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
              const Divider(thickness: 2,height: 8,),
              Card(color: Colors.black54,child: Column(
                children: <Widget>[
                  createList('assets/chob${index}.jpeg',names[index],singer[index]),
                  createList('assets/chob${index}.jpeg',names[index],singer[index]),
                  createList('assets/chob${index}.jpeg',names[index],singer[index]),
                  createList('assets/chob${index}.jpeg',names[index],singer[index]),
                  createList('assets/chob${index}.jpeg',names[index],singer[index]),
                ],
              ),),
            ],
          ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_musica/playlist.dart';
import 'package:my_musica/musica.dart';
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
      initialRoute: '/',
      routes: {
        '/':(context)=> Playlist(),
        '/sec':(context)=>Musica(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_music_player/src/models/player_model.dart';
import 'package:flutter_music_player/src/pages/music_player_page.dart';
import 'package:flutter_music_player/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PlayerModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        title: 'Music Player',
        home: MusicPlayerPage(),
      ),
    );
  }
}

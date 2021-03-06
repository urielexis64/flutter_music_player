import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/src/helpers/helpers.dart';
import 'package:flutter_music_player/src/models/player_model.dart';
import 'package:flutter_music_player/src/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../models/player_model.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [MainShadowContainer(), Expanded(child: Lyrics())],
        ),
      ),
    );
  }
}

class MainShadowContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
          boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black26)],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.center,
              colors: [Color(0xff33333e), Color(0xff201e28)])),
      child: Column(
        children: [
          CustomAppBar(),
          DiscImageAndDuration(),
          TitleAndPlay(),
        ],
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListWheelScrollView(
          itemExtent: 45.0,
          physics: BouncingScrollPhysics(),
          diameterRatio: 1.5,
          children: getLyrics()
              .map((e) => Text(
                    e,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white54),
                  ))
              .toList()),
    );
  }
}

class TitleAndPlay extends StatefulWidget {
  @override
  _TitleAndPlayState createState() => _TitleAndPlayState();
}

class _TitleAndPlayState extends State<TitleAndPlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  AnimationController playAnimationController;

  final assetAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    playAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    playAnimationController.dispose();
    assetAudioPlayer.dispose();
    super.dispose();
  }

  final vete = Audio('assets/Bad Bunny - Vete.mp3',
      metas: Metas(
        title: 'Vete',
        artist: 'Bad Bunny',
      ));

  void open() {
    final audioPlayerModel = context.read<PlayerModel>();

    assetAudioPlayer.open(vete);

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration = playingAudio.audio.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${vete.metas.title}',
                style: TextStyle(fontSize: 30, color: Colors.white70),
              ),
              Text(
                '${vete.metas.artist}',
                style: TextStyle(fontSize: 16, color: Colors.white24),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              final playerProvider = context.read<PlayerModel>();

              if (this.isPlaying) {
                playAnimationController.reverse();
                playerProvider.controller.stop();
                isPlaying = false;
              } else {
                playAnimationController.forward();
                playerProvider.controller.repeat();
                isPlaying = true;
              }

              if (firstTime) {
                open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
            },
            child: AnimatedIcon(
              progress: playAnimationController,
              icon: AnimatedIcons.play_pause,
              color: Colors.black,
            ),
            color: Colors.yellow[700],
            padding: EdgeInsets.all(16),
            shape: CircleBorder(),
          )
        ],
      ),
    );
  }
}

class DiscImageAndDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Row(
        children: [
          DiscImage(),
          SizedBox(
            width: 25,
          ),
          ProgressBar()
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = context.watch<PlayerModel>();
    final percentage = audioPlayerModel.percentage;
    return Container(
      child: Column(
        children: [
          Text('${audioPlayerModel.songTotalDuration}',
              style: TextStyle(color: Colors.white38)),
          SizedBox(height: 10),
          Stack(
            children: [
              Container(
                width: 3,
                height: 200,
                color: Colors.white10,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 200 * percentage,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text('${audioPlayerModel.currentSecond}',
              style: TextStyle(color: Colors.white38)),
        ],
      ),
    );
  }
}

class DiscImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final playerProvider = context.watch<PlayerModel>();
    return Container(
      width: size.width * .6,
      height: size.width * .6,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0xff484750), Color(0xff1e1c24)])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
                duration: Duration(seconds: 10),
                controller: (animationController) =>
                    playerProvider.controller = animationController,
                infinite: true,
                animate: false,
                manualTrigger: true,
                child: Image(image: AssetImage('assets/YHLQMDLG.jpg'))),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black38,
              ),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff1c1c25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_music_player/src/widgets/custom_app_bar.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [CustomAppBar(), DiscImageAndDuration()],
        ),
      ),
    );
  }
}

class DiscImageAndDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: Row(
        children: [DiscImage(), ProgressBar()],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('04:23', style: TextStyle(color: Colors.white38)),
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
                  height: 100,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text('00:34', style: TextStyle(color: Colors.white38)),
        ],
      ),
    );
  }
}

class DiscImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            Image(image: AssetImage('assets/aurora.jpg')),
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

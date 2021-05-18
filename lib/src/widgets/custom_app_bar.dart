import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Icon(Icons.chevron_left_rounded, color: Colors.white38, size: 25),
        Spacer(),
        Icon(
          Icons.messenger_outline_sharp,
          color: Colors.white38,
          size: 25,
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.headset_outlined,
          color: Colors.white38,
          size: 25,
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.ios_share,
          color: Colors.white38,
          size: 25,
        ),
      ]),
    );
  }
}

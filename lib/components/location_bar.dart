import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationBar extends StatelessWidget {
  
  const  LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Icon(FontAwesomeIcons.locationDot,color: Colors.white),
      ));
  }
}
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextButtonCmp extends StatelessWidget {

  final String title;
  VoidCallback onTap;
  final Color textColor;

   TextButtonCmp({super.key, required this.onTap , required this.textColor, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton    
    (onPressed:onTap,
     child: Text(title,style: TextStyle(color: textColor,fontSize: 18,fontFamily: 'poppins'),));
  }
}
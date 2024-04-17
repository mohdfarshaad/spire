

import 'package:flutter/material.dart';
import 'package:spire/theme/app_colors.dart';

class ButtonCmp extends StatelessWidget {
  
  final String buttonText;
  final  VoidCallback onTap;

  const ButtonCmp({super.key,required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 70,
        width:double.infinity,
        decoration: BoxDecoration(
          color: AppColors.accentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child:Center(
          child:Text(buttonText,style: const TextStyle(
            color: AppColors.lightColor,
            fontSize: 20,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w300
          ),) ,
        )
      ),
    );
  }
}
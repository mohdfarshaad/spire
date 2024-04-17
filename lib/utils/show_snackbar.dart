import 'package:flutter/material.dart';
import 'package:spire/theme/app_colors.dart';

void showSnackbar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text(text,style: 
    const TextStyle(
      color: Colors.black,
      backgroundColor: AppColors.accentColor,
    )
    ,),
    duration: const Duration(milliseconds: 5),
    )
  );
}
import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {

  final String title;
  final IconData icon;
  final VoidCallback onTap;

   const SettingsList({super.key,required this.title , required this.icon , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400)
        ),
        child: Row(
          children: [
            Icon(icon,size: 25,color: Colors.grey.shade800,),
            const SizedBox(width: 20,),
            Text(title,style: 
            const TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14,
            ),
            ),
          ],
        )
      ),
    );
  }
}
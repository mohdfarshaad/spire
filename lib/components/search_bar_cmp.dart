import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SearchBarCmp extends StatelessWidget {
   const SearchBarCmp({super.key,});

  @override
  Widget build(BuildContext context) {
    return TextField(  
      onTap: () {},    
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
        hintText: "Search",
        hintStyle: const TextStyle(
          fontFamily: "poppins",
          fontSize: 18,
          fontWeight: FontWeight.w600
        ),
        enabledBorder: OutlineInputBorder(borderSide:BorderSide(
       color: Colors.grey.shade700,
        ),borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:BorderSide(
       color: Colors.grey.shade700,
        ),
        borderRadius: BorderRadius.circular(15)
      ),
      ),
      
    );
  }
}
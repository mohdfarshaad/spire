import 'package:flutter/material.dart';
import 'package:spire/screens/added_resturant_screen.dart';
import 'package:spire/screens/liked_resturant_screen.dart';
import 'package:spire/theme/app_colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.accentColor,
          elevation: 0,
          toolbarHeight: 20,
        bottom: TabBar(
          labelPadding: const EdgeInsets.all(5),
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelStyle: TextStyle(color: Colors.grey[400],fontSize: 20,fontFamily: 'poppins'), 
          labelStyle: const TextStyle(fontSize: 20,fontFamily: 'poppins'),
          tabs: const [
            Tab(text: "Favorite",),
            Tab(text: "Added",),
          ],
        ),
      ),
      body: const TabBarView(
         children: [
          LikedResturantScreen(),
          AddedResturantScreen()
       ],
     ),
      ));
  }
}
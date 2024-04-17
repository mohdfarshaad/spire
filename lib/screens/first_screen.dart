import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spire/components/location_bar.dart';
import 'package:spire/screens/favorite_screen.dart';
import 'package:spire/screens/home_screen.dart';
import 'package:spire/screens/settings_screen.dart';
import 'package:spire/theme/app_colors.dart';

class FirstScreen extends StatefulWidget {
   const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
   int _selectedIndex = 0;

   void navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
   }

  final List _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title:  const Padding(
            padding: EdgeInsets.all(10),
               child: Text("Spire",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
          ),
      ),
       backgroundColor:AppColors.accentColor,
        toolbarHeight: 70,
        elevation: 0,
        shape:const Border(bottom: BorderSide(color: AppColors.accentColor)),
        centerTitle: false,
        actions: const [
           LocationBar(),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
          currentIndex: _selectedIndex,
          onTap: navigateBottomBar,
          selectedItemColor: AppColors.accentColor,
          unselectedItemColor:Colors.grey.shade400,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 25,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items:const [
            BottomNavigationBarItem(icon:Icon(FontAwesomeIcons.house),label: "Home",
             ),
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.solidHeart),
            label: "Favorite",
            ),
             BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.solidUser),
            label: "Account",
            )
               ]),
    );
  }
}
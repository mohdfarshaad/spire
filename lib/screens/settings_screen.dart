import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:spire/auth/change_password.dart';
import 'package:spire/components/settings_list.dart';
import 'package:spire/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(0),bottomRight: Radius.circular(0))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                backgroundImage:AssetImage('assets/images/profile.png',),
                radius: 50,
              ),
                  // const Text("Muhammed Farshad",style:TextStyle(
                  //   fontFamily: 'poppins',
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.w800,
                  //   color: Colors.white
                  // ),),
                  SizedBox(height: 20,),
                  Text(FirebaseAuth.instance.currentUser?.email ?? 'No user logged in',style:TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey.shade300,
                  ),),
                ],
            ),
          ),
              const SizedBox(width: 20,),
          Expanded(child: 
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                     SettingsList(title: "Profile", icon:FontAwesomeIcons.user, onTap:(){
                context.go('/profilescreen');
            }
            ),
            const SizedBox(height: 20,),
            SettingsList(title: "Change Password", icon:FontAwesomeIcons.key, onTap: (){
               Navigator.push(
                   context,
                    MaterialPageRoute(builder: (context) => const ChangePassword()),
            );
            }
            ),
            ],
            ),
            const SizedBox(height: 20,),
                SettingsList(
                 title: "Logout",
                 icon: FontAwesomeIcons.arrowRightFromBracket,
                 onTap: () async {
                   try {
                     await FirebaseAuth.instance.signOut();
                   } catch (e) {
                       print(" $e");}{
                   }
                   context.go('/signin');
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(
                       content: Text("Sign out"),
                       duration: Duration(seconds: 3),
                     ),
                   );
                 },
               )
            ],
            ),
          ),
          ),   
        ]
      ),
    );
  }
}
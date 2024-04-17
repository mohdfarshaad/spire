import 'package:flutter/material.dart';
import 'package:spire/theme/app_colors.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              color: AppColors.accentColor,
            ),
            padding: const EdgeInsets.all(20),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.png'),
                      radius: 30,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning",
                          style: TextStyle(
                            fontFamily: "poppins",
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Where do you want to eat ?",
                          style: TextStyle(
                            fontFamily: "poppins",
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
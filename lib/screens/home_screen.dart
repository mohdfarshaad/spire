import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spire/components/home_bar_cmp.dart';
import 'package:spire/components/restaurants_list_tile.dart';
import 'package:spire/theme/app_colors.dart';
import 'package:spire/theme/typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeBar(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text("Popular Restaurants", style: subTitleStyle),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: RestaurantListWidget(showAllRestaurants: true,),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/addresturants');
        },
        backgroundColor: AppColors.accentColor,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.restaurant, color: Colors.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spire/components/restaurants_list_tile.dart';
import 'package:spire/theme/app_colors.dart';

class LikedResturantScreen extends StatelessWidget {
  const LikedResturantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: RestaurantListWidget(showAllRestaurants: false, showLikedRestaurants: true,)
      ),
    );
  }
}
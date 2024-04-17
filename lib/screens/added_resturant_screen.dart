
import 'package:flutter/material.dart';
import 'package:spire/components/restaurants_list_tile.dart';
import 'package:spire/theme/app_colors.dart';

class AddedResturantScreen extends StatelessWidget {
  const AddedResturantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: RestaurantListWidget(showAllRestaurants: false,showLikedRestaurants: false,)
      ),
    );
  }
}
  
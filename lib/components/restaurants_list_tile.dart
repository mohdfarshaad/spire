import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spire/components/loading_indicator.dart';
import 'package:spire/screens/detail_screen.dart';

class RestaurantListWidget extends StatefulWidget {
  final bool showAllRestaurants;
  final bool showLikedRestaurants;

  const RestaurantListWidget({Key? key, this.showAllRestaurants = false, this.showLikedRestaurants = false}) : super(key: key);

  @override
  _RestaurantListWidgetState createState() => _RestaurantListWidgetState();
}

class _RestaurantListWidgetState extends State<RestaurantListWidget> {
   StreamSubscription<QuerySnapshot>? _likedRestaurantsSubscription = null;
  List<String> _likedRestaurantIds = [];

  @override
  void initState() {
    super.initState();
    if (widget.showLikedRestaurants) {
      _subscribeToLikedRestaurants();
    }
  }

  @override
  void dispose() {
    _likedRestaurantsSubscription?.cancel();
    super.dispose();
  }

  void _subscribeToLikedRestaurants() {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid;
    if (userId != null) {
      final likedRestaurantsQuery = FirebaseFirestore.instance
          .collection('restaurants')
          .where('likedUsers', arrayContains: userId)
          .snapshots();
      _likedRestaurantsSubscription = likedRestaurantsQuery.listen((snapshot) {
        setState(() {
          _likedRestaurantIds = snapshot.docs.map((doc) => doc.id).toList();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: widget.showAllRestaurants ? getAllRestaurants() : getUserRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final restaurantDocs = snapshot.data!.docs;
          if (restaurantDocs.isEmpty) {
            return Center(child: Text(widget.showAllRestaurants ? 'No restaurants found.' : 'No restaurants added by the user.'));
          }
          return ListView.builder(
            itemCount: restaurantDocs.length,
            itemBuilder: (context, index) {
              final restaurantData = restaurantDocs[index].data() as Map<String, dynamic>;
              final randomIcon = _getRandomImage();
              final name = restaurantData['name'] ?? 'Unnamed Restaurant';
              final description = restaurantData['description'] ?? 'No Description';
              final cuisine = restaurantData['cuisine'] ?? 'No Cuisine';
              final location = restaurantData['location'] ?? 'No Location';
              int likes = restaurantData['likes'] ?? 0; // Get the like count
              final restaurantId = restaurantDocs[index].id;
              final isLiked = _likedRestaurantIds.contains(restaurantId);

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(randomIcon),
                      radius: 30,
                    ),
                    title: Text(name),
                    subtitle: Text(location),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$likes'), // Display the like count
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.red : null,
                          ),
                          onPressed: () async {
                            final updatedLikes = await _toggleLikeRestaurant(restaurantId, !isLiked); // Toggle like and get updated likes
                            setState(() {
                              likes = updatedLikes; // Update the like count in the UI
                            });
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            name: name,
                            description: description,
                            cuisine: cuisine,
                            location: location,
                            image: randomIcon,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<QuerySnapshot> getUserRestaurants() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userEmail = currentUser?.email;

    final restaurantSnapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .where('userEmail', isEqualTo: userEmail)
        .where('name', isNotEqualTo: '')
        .get();

    return restaurantSnapshot;
  }

  Future<QuerySnapshot> getAllRestaurants() async {
    final restaurantSnapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .where('name', isNotEqualTo: '')
        .get();

    return restaurantSnapshot;
  }

  String _getRandomImage() {
    final images = [
      'assets/images/restaurants/r1.png',
      'assets/images/restaurants/r2.png',
      'assets/images/restaurants/r3.png',
      'assets/images/restaurants/r4.png',
      'assets/images/restaurants/r5.png',
      'assets/images/restaurants/r6.png',
      'assets/images/restaurants/r7.png',
      'assets/images/restaurants/r8.png',
      'assets/images/restaurants/r9.png',
    ];
    final randomIndex = Random().nextInt(images.length);
    return images[randomIndex];
  }
Future<int> _toggleLikeRestaurant(String restaurantId, bool isLiked) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final userId = currentUser?.uid;
  final restaurantRef = FirebaseFirestore.instance.collection('restaurants').doc(restaurantId);

  int updatedLikes; // Variable to hold the updated like count

  if (isLiked) {
    // If the restaurant is already liked, remove the like
    await restaurantRef.update({
      'likedUsers': FieldValue.arrayRemove([userId]),
      'likes': FieldValue.increment(-1),
      'likedByCurrentUser': false, // Update the field to indicate that the current user has unliked the restaurant
    });
    updatedLikes = 0; // Set the updated like count to 0
  } else {
    // If the restaurant is not liked, like it
    await restaurantRef.update({
      'likedUsers': FieldValue.arrayUnion([userId]),
      'likes': FieldValue.increment(1),
      'likedByCurrentUser': true, // Add a field to indicate that the current user has liked the restaurant
    });
    updatedLikes = 1; // Set the updated like count to 1
  }

  // Return the updated like count
  return updatedLikes;
}
}

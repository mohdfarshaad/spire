

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:spire/components/back_button_cmp.dart';
import 'package:spire/components/button_cmp.dart';
import 'package:spire/components/textfield_cmp.dart';
import 'package:spire/utils/show_snackbar.dart';

  class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({super.key});

  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
  
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {

  //Text Editing controller for getting the input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cuisineController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  //creating an firestore collection reference for restaurants collection 
  final CollectionReference _restaurantsCollection = FirebaseFirestore.instance.collection('restaurants');

  //initializing key for TextFormField
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;


  //Validations
  String?validateRestaurantName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the restaurant name';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the description';
    }
    return null;
  }

  String? validateCuisine(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the cuisine';
    }
    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the location';
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: const Text('Add Restaurant'),
        leading: BackButtonCmp(
          onTap: () {
            context.go('/');
          },
        ),
        centerTitle: true,
        toolbarHeight: 80,
      ),



      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
       
       //Form widget
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldCmp(
                controller: nameController,
                labelText: 'Restaurant Name',
                textFieldIcon: Icons.restaurant,
                validator: validateRestaurantName,
              ),
              const SizedBox(height: 20),
              TextFieldCmp(
                controller: descriptionController,
                labelText: 'Description',
                textFieldIcon: Icons.description,
                validator: validateDescription,
              ),
              const SizedBox(height: 20),
              TextFieldCmp(
                controller: cuisineController,
                labelText: 'Cuisine',
                textFieldIcon: Icons.restaurant_menu,
                validator: validateCuisine,
              ),
              const SizedBox(height: 20),
              TextFieldCmp(
                controller: locationController,
                labelText: 'Location',
                textFieldIcon: FontAwesomeIcons.locationDot,
                validator: validateLocation,
              ),
              const SizedBox(height: 20),
              _isLoading 
                  ? const Center(child: CircularProgressIndicator())
                  : ButtonCmp(
                      buttonText: 'Add',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true; // Start loading
                          });
                          try {
                            // Retrieve current user ID
                            String userId = FirebaseAuth.instance.currentUser!.uid;
                            // Add restaurant with user ID
                            await _restaurantsCollection.add({
                              'name': nameController.text,
                              'description': descriptionController.text,
                              'cuisine': cuisineController.text,
                              'location': locationController.text,
                              'userId': userId,
                              'userEmail':FirebaseAuth.instance.currentUser?.email, // Add user ID
                            });
                            showSnackbar(context, 'Restaurant added successfully');
                          } catch (e) {
                           showSnackbar(context, 'Failed to add restaurant');
                          } finally {
                            setState(() {
                              _isLoading = false; 
                            });
                            nameController.clear();
                            descriptionController.clear();
                            cuisineController.clear();
                            locationController.clear();
                          }
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  //Collection References

  //users collection
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  //restaurants collection
  final CollectionReference _restaurantsCollection = FirebaseFirestore.instance.collection('restaurants');


  //CRUD operations for user collection

  //create




  //read



  //update



  //delete




  //CRUD operations for user collection

  //create




  //read



  //update
 


  //delete


  Future<void> addRestaurant(Map<String, dynamic> restaurantData) async {
    try {
      await _restaurantsCollection.add(restaurantData);
    } catch (e) {
      print('Error adding restaurant: $e');
      throw e;
    }
  }

  Stream<QuerySnapshot> getRestaurantsStream() {
    return _restaurantsCollection.snapshots();
  }

  Future<void> updateRestaurant(String id, Map<String, dynamic> updatedData) async {
    try {
      await _restaurantsCollection.doc(id).update(updatedData);
    } catch (e) {
      print('Error updating restaurant: $e');
      throw e;
    }
  }

  Future<void> deleteRestaurant(String id) async {
    try {
      await _restaurantsCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting restaurant: $e');
      throw e;
    }
  }
}

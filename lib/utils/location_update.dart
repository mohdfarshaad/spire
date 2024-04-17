// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationUpdate extends StatefulWidget {
  const LocationUpdate({super.key});

  @override
  _LocationUpdateState createState() => _LocationUpdateState();
}

class _LocationUpdateState extends State<LocationUpdate> {
  String _locality = 'Loading...';

  @override
  void initState() {
    super.initState();
    _checkPermissionAndFetchLocation();
  }

  Future<void> _checkPermissionAndFetchLocation() async {
    var permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      _fetchLocation();
    } else if (permissionStatus.isDenied) {
      _fetchLocation();
      setState(() {
        _locality = 'Permission denied';
      });
    } else if (permissionStatus.isPermanentlyDenied) {
      setState(() {
        _locality = 'Permission permanently denied';
      });
    }
  }

  Future<void> _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark>? placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        setState(() {
          _locality = placemarks.first.locality ?? 'Unknown';
        });
      } else {
        setState(() {
          _locality = 'No placemarks found';
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _locality = 'Error fetching location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _locality,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'poppins',
        color: Colors.grey.shade700,
      ),
    );
  }
}

import 'dart:async';

import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TestMap extends StatefulWidget {
  const TestMap({super.key});

  @override
  State<TestMap> createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  late GoogleMapController googleMapController;
  // static const CameraPosition initialCameraPosition = CameraPosition(
  //     target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  double? latitude;
  double? longtitude;
  Position? positionMain;
  String? address;

  Set<Marker> markes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomText(
              message: 'Coordinates',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText),
          const SizedBox(
            height: 5,
          ),
          CustomText(
              message:
                  'lattiude=${latitude?.toString()} longtitude= ${longtitude?.toString()} ',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText),
          const SizedBox(
            height: 5,
          ),
          const CustomText(
              message: 'Address',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText),
          const SizedBox(
            height: 5,
          ),
          CustomText(
              message: '${address}',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
              onPressed: () async {
                Position position = await _determinePosition();
                getAddressFromLatLong(position);
              },
              child: Text('get address'))
        ],
      ),
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        // timeLimit: Duration(hours: 1),
        forceAndroidLocationManager: true);
    setState(() {
      latitude = position.latitude;
      longtitude = position.longitude;
      positionMain = position;
    });
    return position;
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address =
        '${place.street},${place.locality},${place.administrativeArea},${place.country}';
    setState(() {});
    print(placemark);
  }
}

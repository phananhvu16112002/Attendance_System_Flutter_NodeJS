import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/services/GetLocation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class FloatingButtonMap extends StatefulWidget {
  const FloatingButtonMap({super.key});

  @override
  State<FloatingButtonMap> createState() => _MapState();
}

class _MapState extends State<FloatingButtonMap> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(10.732734759792725, 106.69977462350948), zoom: 18);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white)),
        backgroundColor: AppColors.primaryButton,
        centerTitle: true,
        title: const Text(
          'My Location',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await GetLocation().determinePosition();
          print('Latitude: ${position.latitude}');
          print('Longtitude: ${position.longitude}');

          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 18))); // should pass data from provider
          markers.clear();
          markers.add(Marker(
              icon: BitmapDescriptor.defaultMarker,
              flat: true,
              visible: false,
              markerId: const MarkerId('CurrentLocation'),
              position: LatLng(position.latitude, position.longitude)));
        },
        label: const Text(
          'Current Location',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: AppColors.primaryButton,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.location_history),
      ),
    );
  }
}

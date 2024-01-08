import 'dart:io';

import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/services/GetLocation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _MapState();
}

class _MapState extends State<TestApp> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(10.732734759792725, 106.69977462350948), zoom: 15.6746);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  Set<Marker> markers = {};

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/images/marker_icon.png')
        .then((value) => {
              setState(() {
                markerIcon = value;
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    addCustomIcon();
    super.initState();
  }

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
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markers,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                googleMapController = controller;
              },
              circles: {
                Circle(
                    circleId: CircleId('1'),
                    center: initialCameraPosition.target,
                    radius: 430,
                    strokeWidth: 2,
                    fillColor: Color(0xff006491).withOpacity(0.2))
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await GetLocation().determinePosition();
          print('Latitude: ${position.latitude}');
          print('Longtitude: ${position.longitude}');
          String? address = await GetLocation().getAddressFromLatLong(position);
          print('address: $address');

          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 15.6746))); // should pass data from provider
          markers.clear();
          markers.add(Marker(
              icon: markerIcon,
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

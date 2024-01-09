import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/services/GetLocation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _MapState();
}

class _MapState extends State<TestApp> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(10.732734759792725, 106.69977462350948), zoom: 16);
  BitmapDescriptor iconBitMap = BitmapDescriptor.defaultMarker;

  Set<Marker> markers = {};
  bool isInsideLocation = false;

  List<LatLng> listPolygons = const [
    LatLng(10.73343784161409, 106.69639213882168),
    LatLng(10.733140054627112, 106.69978513319467),
    LatLng(10.730731395097495, 106.70003189642024),
    LatLng(10.73030974595168, 106.69736578067798)
  ];

  void addCustomIcon() async {
    var value = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1), devicePixelRatio: 1),
        'assets/images/marker_icon.png');
    setState(() {
      iconBitMap = value;
    });
  }

  bool isLocationInsideTDTU(LatLng location) {
    List<map_tool.LatLng> convertPolygonsPoints = listPolygons
        .map((e) => map_tool.LatLng(e.latitude, e.longitude))
        .toList();
    isInsideLocation = map_tool.PolygonUtil.containsLocation(
        map_tool.LatLng(location.latitude, location.longitude),
        convertPolygonsPoints,
        false);
    if (isInsideLocation) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
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
            child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white)),
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
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                googleMapController = controller;
              },
              polygons: {
                Polygon(
                  polygonId: const PolygonId('Ton Duc Thang Location'),
                  points: listPolygons,
                  fillColor: Colors.blue.withOpacity(0.1),
                  strokeColor: Colors.blue,
                  strokeWidth: 2,
                )
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await GetLocation().determinePosition();
          var address = await GetLocation().getAddressFromLatLong(position);
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 16)));

          // markers.clear();
          markers.add(Marker(
              icon: iconBitMap,
              infoWindow: const InfoWindow(title: 'Current Location'),
              markerId: const MarkerId('CurrentLocation'),
              draggable: true,
              position: LatLng(position.latitude, position.longitude)));
          bool check = isLocationInsideTDTU(
              LatLng(position.latitude, position.longitude));
          if (check) {
            print('INSIDE-----------------------');
          } else {
            print('OUTSIDE-------------------------');
          }
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

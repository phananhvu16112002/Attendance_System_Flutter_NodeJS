import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation {
  double? latitude;
  double? longtitude;
  Position? positionMain;
  String? address;

  Future<Position> determinePosition() async {
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
        timeLimit: const Duration(hours: 2),
        forceAndroidLocationManager: true);
    latitude = position.latitude;
    longtitude = position.longitude;
    positionMain = position;
    return position;
  }

  Future<String?> getAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    var temp =
        '${place.street},${place.locality},${place.subAdministrativeArea},${place.administrativeArea},${place.country}';
    address = processAddress(temp);
    print('address $address');
    return address;
  }

  String processAddress(String address) {
    List<String> components = address.split(',');
    List<String> filteredComponents =
        components.where((component) => component.trim().isNotEmpty).toList();
    String processedAddress = filteredComponents.join(',');
    return processedAddress;
  }

  Future<bool> updateLocation(StudentDataProvider provider) async {
    Position position = await determinePosition();
    String? address = await getAddressFromLatLong(position);
    provider.setLatitude(position.latitude);
    provider.setLongtitude(position.longitude);
    provider.setLocation(address!);

    if (provider.userData.latitude != 0 &&
        provider.userData.longtitude != 0 &&
        provider.userData.location.isNotEmpty) {
      print('------ latitude: ${provider.userData.latitude}');
      print('------ longitude: ${provider.userData.longtitude}');
      print('------ location: ${provider.userData.location}');

      return true;
    }
    return false;
  }
}

import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
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
    await SecureStorage().writeSecureData('latitude', latitude.toString());
    await SecureStorage().writeSecureData('longtitude', longtitude.toString());

    positionMain = position;
    return position;
  }

  Future<String?> getAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address =
        '${place.street},${place.locality},${place.subAdministrativeArea},${place.administrativeArea},${place.country}';
    return address;
  }
}

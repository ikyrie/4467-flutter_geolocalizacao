import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    try {
      var locationPermission = await Permission.location.status;
      if (locationPermission.isGranted) {
        return await Geolocator.getCurrentPosition();
      } else {
        throw Exception("Permissão de localização negada");
      }
    } catch (e) {
      print(e);
      return Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0);
    }
  }
}
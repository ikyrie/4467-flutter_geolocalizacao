import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geo/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final LocationService locationService = LocationService();
  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("Alura"),
      position: LatLng(-23.588357, -46.632499),
      infoWindow: InfoWindow(
        title: "Alura",
        snippet: "Cursos online de tecnologia",
      ),
    ),
    Marker(
      markerId: MarkerId("FIAP Aclimação"),
      position: LatLng(-23.574147, -46.623090),
      infoWindow: InfoWindow(
        title: "FIAP Aclimação",
        snippet: "Unidade Aclimação da faculdade FIAP",
      ),
    ),
    Marker(
      markerId: MarkerId("FIAP Paulista"),
      position: LatLng(-23.564455, -46.652757),
      infoWindow: InfoWindow(
        title: "FIAP Paulista",
        snippet: "Unidade Paulista da faculdade FIAP",
      ),
    ),
  };

  void createMarker(LatLng latLng) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController snippetController = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(16, 26, 16, MediaQuery.of(context).viewInsets.bottom + 36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    label: Text("Título do marcador"),
                  ),
                ),
                SizedBox(height: 24,),
                TextFormField(
                  controller: snippetController,
                  decoration: const InputDecoration(
                    label: Text("Descrição do marcador"),
                  ),
                ),
                SizedBox(height: 24,),
                InkWell(
                  onTap: () {
                    setState(() {
                      Marker marker = Marker(
                        markerId:
                            MarkerId("${latLng.latitude}, ${latLng.longitude}"),
                        position: latLng,
                        infoWindow: InfoWindow(
                          title: titleController.text,
                          snippet: snippetController.text,
                        ),
                      );
                      _markers.add(marker);
                      Navigator.pop(context);
                    });
                  },
                  child: Ink(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF4D5BD9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Adicionar marcador",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _goToUserLocation() async {
    Position position = await locationService.getCurrentLocation();
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            GoogleMap(
              markers: _markers,
              onLongPress: (latLng) => createMarker(latLng),
              onMapCreated: (GoogleMapController controller) =>
                  _controller.complete(controller),
              initialCameraPosition: CameraPosition(
                  target: LatLng(-23.560334, -46.641272), zoom: 14),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 60),
              child: InkWell(
                onTap: () async {
                  _goToUserLocation();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4D5BD9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 56,
                  width: 56,
                  child: Icon(Icons.my_location, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

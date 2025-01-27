import 'package:flutter/material.dart';
import 'package:geo/location_page.dart';

void main(List<String> args) {
  runApp(GeoApp());
}

class GeoApp extends StatelessWidget {
  const GeoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Geo",
      theme: theme,
      home: LocationPage(),
    );
  }
}


ThemeData theme = ThemeData(
  useMaterial3: true,
  colorScheme:
      ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.light),
);

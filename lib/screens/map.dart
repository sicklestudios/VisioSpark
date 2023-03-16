import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? currentPosition;
  bool isLoading = true;
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  GoogleMapController? _googleMapController;
  @override
  void initState() {
    setState(() {
      isLoading = false;
    });
    getLocation();
    super.initState();
  }

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        currentPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: currentPosition ??
                  const LatLng(33.6036036036036, 72.99049466690306),
              zoom: 50),
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          markers: {
            Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet),
              markerId: const MarkerId("u1"),
              position: currentPosition ?? const LatLng(33.6093177, 73.0005767),
            ),
            Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRose),
              markerId: const MarkerId("u2"),
              position: LatLng(33.609318, 73.038579),
            )
          },
          onMapCreated: (mapController) {
            _googleMapController = mapController;
            // ),
          }),
    );
  }

  // void getCurrentLocation() async {
  //   Position position = await GeolocatorPlatform.instance.getCurrentPosition();
  //   print(position);
  //   currentPosition = LatLng(position.latitude, position.longitude);
  //   // print("GetCurrentLocation Running: Latitude ${position.latitude} Longitude ${position.longitude}");
  //   // return currentPosition!;
  // }
}

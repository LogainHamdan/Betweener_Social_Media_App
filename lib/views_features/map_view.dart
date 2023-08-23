import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

import '../core/utils/constants.dart';

class GoogleMapView extends StatefulWidget {
  static String id = '/googleMapView';
  static const LatLng sourceLocation = LatLng(37.33500926, -122.0327188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  const GoogleMapView({Key? key}) : super(key: key);

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) => currentLocation = location);
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        APIKey,
        PointLatLng(GoogleMapView.sourceLocation.latitude,
            GoogleMapView.sourceLocation.longitude),
        PointLatLng(GoogleMapView.destination.latitude,
            GoogleMapView.destination.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  currentLocation!.latitude!, currentLocation!.longitude!),
              zoom: 13.5),
          polylines: {
            Polyline(
                polylineId: const PolylineId("route"),
                points: polylineCoordinates,
                width: 6)
          },
          markers: {
            Marker(
                markerId: const MarkerId("currentLocation"),
                position: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!)),
            const Marker(
                markerId: MarkerId("source"),
                position: GoogleMapView.sourceLocation),
            const Marker(
                markerId: MarkerId("destination"),
                position: GoogleMapView.destination),
          }),
    );
  }
}

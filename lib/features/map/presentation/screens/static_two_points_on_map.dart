// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   map.GoogleMapController? _mapController;
//   Set<map.Marker> _markers = {};
//
//   final map.LatLng pointA = map.LatLng(37.7749, -122.4194); // Example coordinates
//   final map.LatLng pointB = map.LatLng(37.3352, -122.0096); // Example coordinates
//
//   @override
//   void dispose() {
//     _mapController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//       ),
//       body: map.GoogleMap(
//         onMapCreated: (controller) {
//           _mapController = controller;
//           _addMarkers();
//         },
//         initialCameraPosition: map.CameraPosition(
//           target: pointA,
//           zoom: 10,
//         ),
//         markers: _markers,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           double distance = _calculateDistance();
//           // Do something with the calculated distance
//           print('Distance between points A and B: $distance meters');
//         },
//         child: Icon(Icons.calculate),
//       ),
//     );
//   }
//
//   void _addMarkers() {
//     setState(() {
//       _markers.add(
//         map.Marker(
//           markerId: map.MarkerId('pointA'),
//           position: pointA,
//           infoWindow: map.InfoWindow(title: 'Point A'),
//         ),
//       );
//       _markers.add(
//         map.Marker(
//           markerId: map.MarkerId('pointB'),
//           position: pointB,
//           infoWindow: map.InfoWindow(title: 'Point B'),
//         ),
//       );
//     });
//   }
//
//   double _calculateDistance() {
//     Geodesy geodesy = Geodesy();
//     num distance = geodesy.distanceBetweenTwoGeoPoints(
//       LatLng(pointA.latitude, pointA.longitude),
//       LatLng(pointB.latitude, pointB.longitude),
//     );
//     return distance.toDouble();
//   }
// }
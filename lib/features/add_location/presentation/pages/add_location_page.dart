import 'package:e_butler_task/core/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationPage extends ConsumerStatefulWidget {
  static const String route = AppRouter.KAddLocationRoute;
  const AddLocationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddLocationPageState();
}

class _AddLocationPageState extends ConsumerState<AddLocationPage> {
  Completer<GoogleMapController> _controller = Completer();

  // on below line we are specifying our camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(37.42796133580664, -122.885749655962),
    zoom: 14.4746,
  );
  List<Marker> _marker = [];
  final List<Marker> _list = const [
    // List of Markers Added on Google Map
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 80.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),

    Marker(
        markerId: MarkerId('2'),
        position: LatLng(25.42796133580664, 80.885749655962),
        infoWindow: InfoWindow(
          title: 'Location 1',
        )),

    Marker(
        markerId: MarkerId('3'),
        position: LatLng(20.42796133580664, 73.885749655962),
        infoWindow: InfoWindow(
          title: 'Location 2',
        )),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GFG"),
        ),
        body: Container(
          width: 350,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(50),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          height: 350,
          child: GoogleMap(
            initialCameraPosition: _kGoogle,
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ));
  }
}

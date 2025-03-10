import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapBox;
import 'package:sqa/utils/helper.dart';

class LocationPickerView extends StatefulWidget {
  const LocationPickerView({super.key});

  @override
  State<LocationPickerView> createState() => _LocationPickerViewState();
}

class _LocationPickerViewState extends State<LocationPickerView> {
  mapBox.MapboxMap? _mapboxMap;
  mapBox.CameraOptions? _cameraOptions;
  mapBox.Point? _pickedLocation;
  mapBox.PointAnnotationManager? _pointAnnotationManager;

  @override
  Widget build(BuildContext context) {
    final double fullWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _getDeviceLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Pick Location"),
            ),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                width: fullWidth,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop({
                      'latitude': _pickedLocation?.coordinates.lat,
                      'longitude': _pickedLocation?.coordinates.lng,
                    });
                  },
                  child: const Text("Confirm Location"),
                ),
              ),
            ),
            body: mapBox.MapWidget(
              cameraOptions: _cameraOptions,
              mapOptions: mapBox.MapOptions(pixelRatio: 2),
              styleUri: "mapbox://styles/rbrns13/cm4rbtq2m00c601r0dfkbhcjz",
              onMapCreated: _onMapCreated,
              onTapListener: _onMapTapped,
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _onMapCreated(mapBox.MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
    _mapboxMap?.compass.updateSettings(mapBox.CompassSettings(enabled: false));
    _mapboxMap?.annotations.createPointAnnotationManager().then((value) {
      _pointAnnotationManager = value;
    });
  }

  void _onMapTapped(mapBox.MapContentGestureContext mapContext) async {
    mapBox.Point point = mapContext.point;
    _pickedLocation = point;

    Uint8List imageData = await SqaHelper().flutterIconToUint8List(
        Icons.location_pin, Theme.of(context).primaryColor, 140);

    if (_pointAnnotationManager != null) {
      await _pointAnnotationManager!.deleteAll();
      _pointAnnotationManager!.create(
        mapBox.PointAnnotationOptions(
          geometry: point,
          image: imageData,
        ),
      );
    }
    debugPrint("On Map Tapped");
  }

  Future? _getDeviceLocation() async {
    var position = await Geolocator.getCurrentPosition();
    _cameraOptions = mapBox.CameraOptions(
      zoom: 8,
      center: mapBox.Point(
        coordinates: mapBox.Position(
            position.longitude, position.latitude, position.altitude),
      ),
    );
  }
}

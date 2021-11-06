import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tosler/utils/constants.dart';

class LocationPage extends StatelessWidget {
  LocationPage({Key? key, required this.latitude, required this.longitude})
      : super(key: key);
  static Route<dynamic> route(double latitude, double longitude) =>
      CupertinoPageRoute(
          builder: (context) => LocationPage(
                latitude: latitude,
                longitude: longitude,
              ));

  double latitude;
  double longitude;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Car location"),
      ),
      child: SafeArea(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(latitude, longitude),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return Text("lat: $latitude, lng: $longitude");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(latitude, longitude),
                  builder: (ctx) => Container(
                    child: Icon(
                      CupertinoIcons.car_detailed,
                      color: PurplePizzazz,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

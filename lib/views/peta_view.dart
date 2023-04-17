import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:project2/providers/peta_provider.dart';

class PetaView extends StatelessWidget {
  const PetaView({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.read<PetaProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Maps Locations"),),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: prov.latLng,
              onMapReady: (){
                prov.mapready == true;
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://mt3.google.com/vt/lyrs=m&x=(x)&y=(y)&z=(z)',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: prov.latLng,
                    builder: (context) {
                      return Icon(
                        FontAwesomeIcons.mapPin,
                        color: Colors.red,
                        size: 45,
                      );
                    }
                  )
                ],
              )
            ],
            mapController: prov.mapController,
          )
        ],
      ),
    );
  }
}
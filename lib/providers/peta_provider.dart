import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class PetaProvider with ChangeNotifier {
  LocationAccuracy _accuracy = LocationAccuracy.low;
  LatLng latLng = LatLng(0, 0);
  LatLng latLng_lama = LatLng(0, 0);

  MapController mapController = MapController();
  bool mapready = false;
  bool mulaibaca = false;

  void mulai_bacalokasi (){
    if(mulaibaca == false){
      mulaibaca == true;
      _bacalokasi();
    }
  }
  
  void stop_bacalokasi (){
      mulaibaca == false;
  }

  Future<bool> cekizin() async{
    var izin = await Geolocator.checkPermission();
    if(izin != LocationPermission.always && 
       izin != LocationPermission.whileInUse){
      izin = await Geolocator.requestPermission();
    }
    if(izin != LocationPermission.always && 
       izin != LocationPermission.whileInUse){
      return false;
    }
    return true;
  }

  Future _bacalokasi() async {
    final izin = await cekizin();
    if(izin == false)return;

    try{
      final lokasi = await Geolocator.getCurrentPosition(
        desiredAccuracy: _accuracy,
      );
      latLng = LatLng(lokasi.latitude, lokasi.longitude);
      naikkan_akurasi();

      if(mapready == true){
        final jarak = Geolocator.distanceBetween(
          latLng.latitude,
          latLng.longitude,
          latLng_lama.latitude,
          latLng_lama.longitude
        );
        if (jarak > 100){
          latLng_lama = latLng;
          mapController.move(latLng, 17);
        }
      }
      print('Lokasi Ditemukan $lokasi');
      }catch(e){
        print('Lokasi Error');
        turunkan_akurasi();
      }

    if(mulaibaca == true){
      await Future.delayed(Duration(seconds: 1));
      _bacalokasi();
    }
  }

  void naikkan_akurasi(){
    if(_accuracy == LocationAccuracy.low){
      _accuracy = LocationAccuracy.medium;
      }else if(_accuracy == LocationAccuracy.medium){
        _accuracy = LocationAccuracy.best;
        }else if(_accuracy == LocationAccuracy.best){
          _accuracy = LocationAccuracy.bestForNavigation;
          }
  }

  void turunkan_akurasi(){
    if(_accuracy == LocationAccuracy.bestForNavigation){
      _accuracy = LocationAccuracy.best;
      }else if(_accuracy == LocationAccuracy.best){
        _accuracy = LocationAccuracy.medium;
        }else if(_accuracy == LocationAccuracy.medium){
          _accuracy = LocationAccuracy.low;
          }
  }
}
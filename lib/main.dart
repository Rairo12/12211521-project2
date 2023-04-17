import 'package:flutter/material.dart';
import 'package:project2/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:project2/providers/dashboard_provider.dart';
import 'package:project2/providers/berita_panel_provider.dart';
import 'package:project2/providers/peta_provider.dart';

void main(List<String> args) {
  runApp(MultiProvider(
    builder: (context, Widget) {
      return MaterialApp(
        home: LoginView(),
      );
    },
    providers: [
      ChangeNotifierProvider(create: (c) => DashboardProvider()),
      ChangeNotifierProvider(create: (c) => BeritaPanelProvider()),
      ChangeNotifierProvider(create: (c) => PetaProvider()),
    ],
  ));
}

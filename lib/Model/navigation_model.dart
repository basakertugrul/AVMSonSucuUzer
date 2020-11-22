import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;
  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Anasayfa", icon: Icons.home),
  NavigationModel(title: "İndirimler", icon: Icons.trending_down),
  NavigationModel(title: "Etkinlikler", icon: Icons.notifications),
  NavigationModel(title: "Trendler", icon: Icons.trending_up),
  NavigationModel(title: "Galeri", icon: Icons.video_library),
  NavigationModel(title: "Bilboard", icon: Icons.video_label),
];
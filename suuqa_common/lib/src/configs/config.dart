import 'dart:ui';
import 'package:flutter/material.dart';

class Config {
  // General
  static String title = 'Suuqa';
  static Color pColor = Color(0xFF00A8FF);
  static Color sColor = Color(0xFF0097E6);
  static Color wColor = Color(0xFF353b48);
  static Color tColor = Color(0xFF353b48);
  static Color bgColor = Color(0xFFf5f6fa);

  static List<String> categories = ['Cars', 'Tech', 'Home', 'Media', 'Baby', 'Services', 'Freebies'];
  static BorderRadius borderRadius = BorderRadius.all(Radius.circular(10.0));

  // Paths
  static String pathUploadPhoto = 'lib/src/assets/images/upload-photo.png';
  static String pathPlaceholderProfile = 'lib/src/assets/images/placeholder-profile.png';

  // Algolia/Firestore Indices/Ref
  static String alerts = 'alerts';
  static String chats = 'chats';
  static String messages = 'messages';
  static String orders = 'orders';
  static String productsSelling = 'products-selling';
  static String productsSold = 'products-sold';
  static String requests = 'requests';
  static String users = 'users';
}
import 'package:flutter/material.dart';
import '../pages/contacts.page.dart';
import '../pages/counter.page.dart';
import '../pages/gallery.page.dart';
import '../pages/home.page.dart';
import '../pages/meteo.page.dart';

class GlobalParameters {
  static final Map<String, Widget Function(BuildContext)> routes = {
    "/": (context) => HomePage(),
    "/counter": (context) => CounterPage(),
    "/gallery": (context) => GalleryPage(),
    "/meteo": (context) => MeteoPage(),

  };

  static final menus=[
    {
      "title":"Home",
      "route":"/",
      "icon":Icon(Icons.home)
    },
    {
      "title":"Counter",
      "route":"/counter",
      "icon":Icon(Icons.memory)
    },
    {
      "title":"Contacts",
      "route":"/contacts",
      "icon":Icon(Icons.contacts)
    },
    {
      "title":"Meteo",
      "route":"/meteo",
      "icon":Icon(Icons.repeat)
    },
    {
      "title":"Gallery",
      "route":"/gallery",
      "icon":Icon(Icons.camera)
    }
  ];
}
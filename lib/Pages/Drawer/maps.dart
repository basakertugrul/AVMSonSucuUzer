import 'package:flutter/material.dart';
import '../../commons/collapsing_navigation_drawer_widget.dart';
import '../../widgets/location/location.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(80, 77, 229, 100),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        title: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(73, 70, 218, 100),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      drawer: CollapsingNavigationDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MapScreen(),
        ],
      ),
    );
  }
}
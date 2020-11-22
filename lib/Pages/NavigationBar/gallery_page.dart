import 'package:avmv005/main.dart';
import 'package:avmv005/widgets/gallery.dart';
import 'package:flutter/material.dart';
import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';
class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: CollapsingNavigationDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            //Gallery Widgetını Göster
            Gallery(),
          ],
        ),
      ),
    );
  }
}

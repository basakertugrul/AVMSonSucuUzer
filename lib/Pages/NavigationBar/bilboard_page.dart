import 'package:avmv005/main.dart';
import 'package:avmv005/widgets/bilboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';

class BilboardScreen extends StatefulWidget {
  @override
  _BilboardScreenState createState() => _BilboardScreenState();
}

class _BilboardScreenState extends State<BilboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: CollapsingNavigationDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            //Bilboards Widget
            Bilboards(),
          ],
        ),
      ),
    );
  }
}
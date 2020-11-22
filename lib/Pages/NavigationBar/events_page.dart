import 'package:avmv005/main.dart';
import 'package:avmv005/widgets/events.dart';
import 'package:flutter/material.dart';
import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';
class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: CollapsingNavigationDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            //Events Widgetını göster.
            Events(),
          ],
        ),
      ),
    );
  }
}

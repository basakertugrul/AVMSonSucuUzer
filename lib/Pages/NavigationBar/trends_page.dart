import 'package:avmv005/main.dart';
import 'package:avmv005/widgets/trends_widget.dart';
import 'package:flutter/material.dart';
import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';
class TrendsScreen extends StatefulWidget {
  @override
  _TrendsScreenState createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: CollapsingNavigationDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            // Trends Widgetını getir
            /*Birçok sayfada benzer işler yapan GridView yapısı için 
              farklı widgetlar kullanıyoruz. Daha efektif bir yapı için 
              tek bir widgetın farklı sayfalardan farklı Firebase Koleksiyonları
              için çağırılması daha sağlıklı olacaktır.
              */
            Trends(),
          ],
        ),
      ),
    );
  }
}

import 'package:avmv005/Pages/Drawer/cinema.dart';
import 'package:avmv005/Pages/Drawer/search.dart';
import 'package:avmv005/Pages/NavigationBar/new_home_page.dart';
import 'package:avmv005/Pages/landing_page.dart';
import 'package:avmv005/View_Model/user_model.dart';
import 'package:avmv005/custom_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:avmv005/widgets/location/location.dart';

import 'commons/collapsing_navigation_drawer_widget.dart';

class ScaffoldOgesi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScaffoldState();
}

class ScaffoldState extends State<ScaffoldOgesi> {
  int aktifOge = 0;
  gecerliSayfa(int aktif) {
    switch (aktif) {
      case 0:
        return HomeScreenNew();
        break;

      case 1:
        return SearchListExample();
        break;

      case 2:
        return CinemaPage();
        break;

      case 3:
        return MapScreen();
        break;

      case 4:
        return ChangeNotifierProvider(
          create: (context) => UserModel(),
          child: LandingPage(),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: gecerliSayfa(aktifOge),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: aktifOge,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // ignore: deprecated_member_use
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              // ignore: deprecated_member_use
              title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.videocam),
              // ignore: deprecated_member_use
              title: Text('Cinema'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              // ignore: deprecated_member_use
              title: Text('Location'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              // ignore: deprecated_member_use
              title: Text('Profile'),
            ),
          ],
          selectedItemColor: selectedColor,
          unselectedItemColor: unSelectedColor,
          onTap: (int i) {
            aktifOge = i;
            setState(() {});
          }),
      drawer: CollapsingNavigationDrawer(),
    );
  }
}

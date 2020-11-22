import 'package:avmv005/View_Model/user_model.dart';
import 'package:avmv005/custom_navigation_drawer.dart';
import 'package:avmv005/locator.dart';
import 'package:avmv005/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool light;
void main() {
  setupLocator();
  runApp(
    MaterialApp(initialRoute: "/", routes: {
      "/": (context) => ScaffoldOgesi(),
    }),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        title: 'Avm+',
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Color(0xFFFEF9EB),
        ),
        home: ScaffoldOgesi(),
      ),
    );
  }
}

/*class DrawerCodeOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 120.0,
            width: double.maxFinite,
            color: Color.fromRGBO(101, 99, 250, 100),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Align(
                child: FlutterLogo(
                  size: 40.0,
                ),
                alignment: Alignment.bottomLeft,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text("Homepage"),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, "/");
                  },
                ),
                ListTile(
                    title: Text("Discounts"),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new DiscountsScreen()));
                    }),
                ListTile(
                    title: Text("Trends"),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new TrendsScreen()));
                    }),
                ListTile(
                    title: Text("Events"),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new EventsScreen()),
                      );
                    }),
                ListTile(
                    title: Text("Gallery"),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new GalleryScreen()));
                    }),
                ListTile(
                    title: Text("Bilboard"),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new BilboardScreen()));
                    }),
                ListTile(
                  title: Text("Settings"),
                  trailing: Icon(Icons.arrow_right),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}*/

Widget buildAppBar() {
  return new AppBar(
    backgroundColor: selectedColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    )),
    title: Container(
      decoration: BoxDecoration(
        color: unSelectedColor,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

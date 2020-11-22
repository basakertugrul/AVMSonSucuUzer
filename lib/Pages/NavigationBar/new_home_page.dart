import 'dart:async';
import 'package:avmv005/widgets/content_scroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../main.dart';
import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';

import '../course_info_screen.dart';

class HomeScreenNew extends StatefulWidget {
  @override
  _HomeScreenNewState createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  PageController _pageController;
  Future getPosts() async {
    var firestore = Firestore.instance;
    //"Anasayfa_Ust" Koleksiyonundaki bütün veriyi çeker.
    QuerySnapshot qs =
        await firestore.collection("Anasayfa_Ust").getDocuments();

    return qs.documents;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  _movieSelector(int index) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget widget) {
          double value = 1;
          if (_pageController.position.haveDimensions) {
            value = _pageController.page - index;
            value = (1 - (value.abs() * 0.3) + 0.6).clamp(0.0, 1.0);
          }
          return Center(
            child: SizedBox(
              height: Curves.easeInOut.transform(value) * 270.0,
              width: Curves.easeInOut.transform(value) * 400,
              child: widget,
            ),
          );
        },
        child: FutureBuilder(
            future: getPosts(),
            builder: (_, AsyncSnapshot snapshot) {
              //Veriler Yüklenene Kadar Ne Olacağı
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                //Verileri Göster
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 0.4),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Center(
                        //Animated Containera Tıklayınca Full Screende Aç
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CourseInfoScreen(
                                imageUrl: snapshot.data[index].data["image"]
                                    .toString(),
                                avmName: snapshot.data[index].data["avm_name"]
                                    .toString(),
                                brandName: snapshot
                                    .data[index].data["brand_name"]
                                    .toString(),
                                info: snapshot.data[index].data["info"]
                                    .toString(),
                                stars: snapshot.data[index].data["stars"],
                                title: snapshot.data[index].data["title"]
                                    .toString(),
                              ),
                            ),
                          ),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutQuint,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Hero(
                              tag: snapshot.data[index].data["image"],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                  image: NetworkImage(
                                    snapshot.data[index].data['image'],
                                  ),
                                  height: 220.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (light == null) ? Colors.white : Colors.black,
      appBar: buildAppBar(),
      drawer: CollapsingNavigationDrawer(),
      // Alternatif Bir Menu ve Search Buttonu Tasarımı

      /*backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Anasayfa"),
        leading: IconButton(
          padding: EdgeInsets.only(left: 30.0),
          onPressed: () => ('Menu'),
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 30.0),
            onPressed: () => ('Search'),
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.black,
          )
        ],
      ),*/
      body: ListView(
        children: <Widget>[
          Container(
            height: 280.0,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return _movieSelector(index);
              },
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Avmler",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          //Content Scroll Widgetı
          //Anasayfanın altındaki horizontal yapı
          ContentScroll(),
        ],
      ),
    );
  }
}

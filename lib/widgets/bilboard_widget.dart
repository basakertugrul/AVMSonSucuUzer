import 'package:avmv005/Pages/course_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bilboards extends StatelessWidget {
  Future getPosts() async {
    var firestore = Firestore.instance;
    //Firebase Koleksiyon
    QuerySnapshot qs = await firestore.collection("Bilboards").getDocuments();

    return qs.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: FutureBuilder(
            future: getPosts(),
            builder: (_, AsyncSnapshot snapshot) {
              //Veriler yüklenirken
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                //Veriler yüklendikten sonra
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    //Containera tıklanınca FullScreende aç
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseInfoScreen(
                            imageUrl:
                                snapshot.data[index].data["image"].toString(),
                            avmName: snapshot.data[index].data["avm_name"]
                                .toString(),
                            brandName: snapshot.data[index].data["brand_name"]
                                .toString(),
                            info: snapshot.data[index].data["info"].toString(),
                            stars: snapshot.data[index].data["stars"],
                            title:
                                snapshot.data[index].data["title"].toString(),
                          ),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: 150,
                        child: Stack(
                          children: <Widget>[
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOutQuint,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      snapshot.data[index].data['image'],
                                    )),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black87,
                                  )
                                ],
                              ),
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        SizedBox(height: 30.0),
      ],
    );
  }
}

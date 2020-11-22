import 'package:avmv005/Pages/course_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Gallery extends StatelessWidget {
  Future getPosts() async {
    var firestore = Firestore.instance;
    //Firebaseden Koleksiyonu çek
    QuerySnapshot qs = await firestore.collection("Gallery").getDocuments();

    return qs.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 500,
          width: 300,
          child: FutureBuilder(
            future: getPosts(),
            builder: (_, AsyncSnapshot snapshot) {
              //Veriler yüklenirken
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } //Veriler yüklendikten sonra
              else {
                return GridView.builder(
                    primary: false,
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.only(top: 15.0, left: 5.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (_, index) {
                      //Seçilen Containerı FullScreende göster
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
                              info:
                                  snapshot.data[index].data["info"].toString(),
                              stars: snapshot.data[index].data["stars"],
                              title:
                                  snapshot.data[index].data["title"].toString(),
                            ),
                          ),
                        ),
                        child: Container(
                            width: 100,
                            height: 150,
                            child: Stack(
                              children: <Widget>[
                                Container(
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
                                )
                              ],
                            )),
                      );
                    });
              }
            },
          ),
        )
      ],
    );
  }
}

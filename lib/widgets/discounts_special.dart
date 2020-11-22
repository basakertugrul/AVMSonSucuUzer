import 'package:avmv005/Pages/See_All/discounts_special_see_all.dart';
import 'package:avmv005/Pages/course_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiscountPageSpecials extends StatelessWidget {
  Future getPosts() async {
    var firestore = Firestore.instance;
    //Firebaseden Koleksiyonu çek
    QuerySnapshot qs =
        await firestore.collection("Avm+_Special_Discounts").getDocuments();

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "AVM+ Special Discounts",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiscountsSpecialSeeAll(),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 150.0,
          width: 350.0,
          color: Colors.white,
          child: FutureBuilder(
            future: getPosts(),
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
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
                          margin: EdgeInsets.all(10.0),
                          width: 220,
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
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                                height: 400,
                                width: 300,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ],
    );
  }
}

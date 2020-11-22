import 'package:avmv005/Pages/course_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';

class DiscountsSlidesSeelAllWidget extends StatelessWidget {
  Future getPosts() async {
    var firestore = Firestore.instance;

    QuerySnapshot qs =
        await firestore.collection("AVM_Discounts").getDocuments();

    return qs.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - 50.0,
          width: MediaQuery.of(context).size.width - 50.0,
          child: FutureBuilder(
            future: getPosts(),
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
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
                    return Container(
                      width: 300,
                      height: 300,
                      child: Stack(
                        children: <Widget>[
                          Material(
                            child: GestureDetector(
                              onTap: () => {},
                              child: FlipCard(
                                direction: FlipDirection.HORIZONTAL, // default
                                front: Container(
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
                                      ),
                                    ],
                                  ),
                                ),

                                back: Container(
                                  color: Color(0xfff4f4f4),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            //Geri Dön
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    CourseInfoScreen(
                                                  imageUrl: snapshot
                                                      .data[index].data["image"]
                                                      .toString(),
                                                  avmName: snapshot.data[index]
                                                      .data["avm_name"]
                                                      .toString(),
                                                  brandName: snapshot
                                                      .data[index]
                                                      .data["brand_name"]
                                                      .toString(),
                                                  info: snapshot
                                                      .data[index].data["info"]
                                                      .toString(),
                                                  stars: snapshot.data[index]
                                                      .data["stars"],
                                                  title: snapshot
                                                      .data[index].data["title"]
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            icon: Icon(Icons.arrow_forward),
                                            iconSize: 30.0,
                                            color: Colors.blueAccent,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            snapshot.data[index].data['title'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0F0449),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      IconTheme(
                                        data: IconThemeData(
                                          color: Colors.amber,
                                          size: 20,
                                        ),
                                        child: StarDisplay(
                                          value: int.parse(snapshot
                                                  .data[index].data['stars'])
                                              .round(),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].data['avm_name']
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xFFC9CBCE),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].data['brand_name']
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xFFC9CBCE),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class StarDisplayWidget extends StatelessWidget {
  final int value;
  final Widget filledStar;
  final Widget unfilledStar;
  const StarDisplayWidget({
    Key key,
    this.value = 0,
    @required this.filledStar,
    @required this.unfilledStar,
  })  : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value ? filledStar : unfilledStar;
      }),
    );
  }
}

class StarDisplay extends StarDisplayWidget {
  const StarDisplay({Key key, int value = 0})
      : super(
          key: key,
          value: value,
          filledStar: const Icon(Icons.star),
          unfilledStar: const Icon(Icons.star_border),
        );
}

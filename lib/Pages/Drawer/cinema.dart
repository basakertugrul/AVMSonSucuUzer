import 'package:avmv005/Pages/CinemaFullScreen.dart';
import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';
import 'package:avmv005/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class CinemaPage extends StatefulWidget {
  @override
  _CinemaPageState createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  String avm = "Agora";
  bool dark = false;

  Future getPosts() async {
    var firestore = Firestore.instance;
    //Anasayfa_Avmler Koleksiyonunu çek
    QuerySnapshot qs = await firestore
        .collection("Cinema")
        .orderBy("avm_name", descending: false)
        .getDocuments();
    return qs.documents;
  }

  @override
  Widget build(BuildContext context) {
    print(avm);

    Future getMovies(String avmName) async {
      var firestore = Firestore.instance;
      //Anasayfa_Avmler Koleksiyonunu çek
      QuerySnapshot qs = await firestore
          .collection("Cinema")
          .document(avmName)
          .collection("Movies")
          .getDocuments();
      print(qs.documents.toString());

      return qs.documents;
    }

    void changeAvmName(String avmName) {
      avm = avmName;
      setState(() {
        avm = avmName;
      });
      getMovies(avm);
      dark = true;
      print(avmName);
    }

    return Scaffold(
      appBar: buildAppBar(),
      drawer: CollapsingNavigationDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: 100,
              width: double.infinity,
              child: FutureBuilder(
                future: getPosts(),
                builder: (_, AsyncSnapshot snapshot) {
                  //Veriler Yülenirke
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading..."),
                    );
                  } //Veriler Yüklendikten sonra
                  else {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        //Seçilen Containerı(Avmyi) AvmScreende göster
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 15.0,
                          ),
                          width: 100,
                          child: FlatButton(
                            onPressed: () => changeAvmName(snapshot
                                .data[index].data['avm_name']
                                .toString()),
                            child: snapshot.data[index].data['avm_name']
                                        .toString() ==
                                    avm
                                ? Text(
                                    snapshot.data[index].data['avm_name']
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.black),
                                    textAlign: TextAlign.left,
                                  )
                                : Text(
                                    snapshot.data[index].data['avm_name']
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Color(0xFF77838F)),
                                    textAlign: TextAlign.left,
                                  ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SingleChildScrollView(
              child: Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: getMovies(avm),
                  builder: (_, AsyncSnapshot snapshot) {
                    //Veriler Yülenirke
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text(avm),
                      );
                    } //Veriler Yüklendikten sonra
                    else {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CinemaFullScreen(
                                  image: snapshot.data[index].data["image"]
                                      .toString(),
                                  link: snapshot.data[index].data["link"]
                                      .toString(),
                                  stars: snapshot.data[index].data["stars"]
                                      .toString(),
                                  summary: snapshot.data[index].data["summary"]
                                      .toString(),
                                  time: snapshot.data[index].data["time"],
                                  title: snapshot.data[index].data["title"]
                                      .toString(),
                                  type: snapshot.data[index].data["type"]
                                      .toString(),
                                  session0: snapshot
                                      .data[index].data['sessions'][0]
                                      .toString(),
                                  session1: snapshot
                                      .data[index].data['sessions'][1]
                                      .toString()
                                      .toString(),
                                  session2: snapshot
                                      .data[index].data['sessions'][2]
                                      .toString()
                                      .toString(),
                                  fragman: snapshot.data[index].data["fragman"]
                                      .toString(),
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 10.0,
                                  ),
                                  width: 121,
                                  height: 175,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(0.0, 0.4),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image(
                                      image: NetworkImage(
                                        snapshot.data[index].data['image'],
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    width: 120.0,
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
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    IconTheme(
                                      data: IconThemeData(
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      child: StarDisplay(
                                        value: snapshot
                                            .data[index].data['stars']
                                            .round(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      snapshot.data[index].data['stars']
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFFC9CBCE),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Column(
                                  children: [
                                    Text(
                                      snapshot.data[index].data['sessions'][0]
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF77838F),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      snapshot.data[index].data['sessions'][1]
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF77838F),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      snapshot.data[index].data['sessions'][2]
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF77838F),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                  ],
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    _launchURL(
                                        snapshot.data[index].data["link"]);
                                  },
                                  child: new Text(
                                    'Satın Al',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Color(0xFF674DFF),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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

_launchURL(String link) async {
  String url = Uri.encodeFull(link);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

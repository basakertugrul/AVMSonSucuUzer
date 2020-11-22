import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AvmScreen extends StatefulWidget {
  //Seçilen Avmnin hangi parametrelerini alıcaz

  final String avmName;
  final String imageUrl;
  final String stars;
  final bool carPark;
  final bool cafe;
  final bool food;

  AvmScreen(
      {@required this.avmName,
      this.imageUrl: "",
      this.stars: "0.0",
      this.carPark: false,
      this.cafe: false,
      this.food: false});

  @override
  _AvmScreenState createState() => _AvmScreenState();
}

class _AvmScreenState extends State<AvmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(20.0, 40.0, 0.0),
                    //Hero sayfaya güzel bir geçiş veriyor
                    child: Hero(
                      tag: widget.imageUrl,
                      child: Image(
                        height: 150,
                        width: 150,
                        //Fill resmi sığdır
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          widget.imageUrl,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    // X Y Z Ekseninde Konum Belirleme
                    transform: Matrix4.translationValues(10.0, 40.0, 0.0),
                    child: Text(
                      widget.avmName.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // İlk 3 icon
                  Container(
                    transform: Matrix4.translationValues(10.0, 40.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.only(left: 5.0),
                          onPressed: () => print('Favorilere Eklendi'),
                          icon: Icon(Icons.card_giftcard),
                          iconSize: 20.0,
                          color: widget.carPark == true
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        IconButton(
                          padding: EdgeInsets.only(left: 5.0),
                          onPressed: () => print('Favorilere Eklendi'),
                          icon: Icon(Icons.local_cafe),
                          iconSize: 20.0,
                          color:
                              widget.cafe == true ? Colors.blue : Colors.grey,
                        ),
                        IconButton(
                          padding: EdgeInsets.only(left: 5.0),
                          onPressed: () => print('Favorilere Eklendi'),
                          icon: Icon(Icons.fastfood),
                          iconSize: 20.0,
                          color:
                              widget.food == true ? Colors.blue : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  // Yıldız sayısını gösteren kısım
                  Container(
                    transform: Matrix4.translationValues(-40.0, 30.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            padding: EdgeInsets.only(left: 35.0, right: 10.0),
                            onPressed: () => print('Favorilere Eklendi'),
                            icon: Icon(Icons.stars),
                            iconSize: 20.0,
                            color: Colors.blue),
                        Container(
                          child: Text(
                            widget.stars.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Alttaki 3 icon (web,telefon,konum)
                  Container(
                    transform: Matrix4.translationValues(10.0, 20.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.only(left: 5.0),
                          onPressed: () => print('Web Sitesi'),
                          icon: Icon(Icons.web_asset),
                          iconSize: 20.0,
                          color: widget.carPark == true
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        IconButton(
                          padding: EdgeInsets.only(left: 5.0),
                          onPressed: () => print('Telefon'),
                          icon: Icon(Icons.phone),
                          iconSize: 20.0,
                          color:
                              widget.cafe == true ? Colors.blue : Colors.grey,
                        ),
                        IconButton(
                          padding: EdgeInsets.only(left: 5.0),
                          onPressed: () => print('Konum'),
                          icon: Icon(Icons.location_on),
                          iconSize: 20.0,
                          color:
                              widget.food == true ? Colors.blue : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

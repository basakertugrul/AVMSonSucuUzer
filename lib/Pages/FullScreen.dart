import 'package:avmv005/Model/favorites.dart';
import 'package:avmv005/Utils/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'CircularClipper.dart';

enum ButtonType { AddFavorite, DeleteFavorite }

class FullScreen extends StatefulWidget {
  //Full Screende hangi parametreleri göstermek istiyoruz
  final String imageUrl;
  final String avmName;
  final String brandName;
  final String info;
  final String stars;
  final String title;

  FullScreen(
      {this.imageUrl,
      this.avmName,
      this.brandName,
      this.info,
      this.stars,
      this.title});
  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  DatabaseHelper dbh1 = DatabaseHelper();
  var _buttonType = ButtonType.AddFavorite;
  IconData iconData = Icons.bookmark_border;
  @override
  Widget build(BuildContext context) {
    void _changeButtonType() {
      if (_buttonType == ButtonType.AddFavorite) {
        try {
          dbh1.addFavorites(Favorites(
              widget.imageUrl.toString(),
              widget.avmName.toString(),
              widget.brandName.toString(),
              widget.info.toString(),
              widget.stars.toString(),
              widget.title.toString()));
          print("Kaydedildi.");
          iconData = Icons.bookmark;
        } catch (e) {
          print("Kaydederken bir hata oluştu" + e.toString());
        }
      } else {
        try {
          dbh1.deleteFavorite(widget.imageUrl);
          iconData = Icons.bookmark_border;
          print("Silindi.");
        } catch (e) {
          print("Silme işlemi sırasında bir hata oluştu" + e.toString());
        }
      }
      setState(() {
        _buttonType = _buttonType == ButtonType.AddFavorite
            ? ButtonType.DeleteFavorite
            : ButtonType.AddFavorite;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                //X Y Z Eksenine Göre Konum Belirleme
                transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                child: Hero(
                  tag: widget.imageUrl,
                  child: ClipShadowPath(
                    shadow: Shadow(blurRadius: 20.0),
                    //Githubdan Çektiğimiz Bir Tasarım
                    //Resmin Altının Oval Olmasını Sağlıyor
                    clipper: CircularClipper(),
                    child: Image(
                      height: 350.0,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        widget.imageUrl,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(left: 30.0),
                    //Geri Dön
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.blueAccent,
                  ),
                  IconButton(
                    padding: EdgeInsets.only(right: 30.0),
                    onPressed: () => print("kkk"),
                    icon: Icon(Icons.favorite_border),
                    iconSize: 30.0,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              Positioned(
                bottom: 0.0,
                left: 20.0,
                child: IconButton(
                  onPressed: () => {_changeButtonType()},
                  icon: Icon(iconData),
                  iconSize: 40.0,
                  color: Colors.blueAccent,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 25.0,
                child: IconButton(
                  onPressed: () => print('Paylaş'),
                  icon: Icon(Icons.share),
                  iconSize: 35.0,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.withOpacity(1.0),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.0),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Yer',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          widget.avmName.toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Marka',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          widget.brandName.toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Yıldız',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "⭐" + widget.stars,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Container(
                  height: 200.0,
                  //SingleChildScrollView Texte Kendi İçinde de Kaydırma Özelliği Verir.
                  child: SingleChildScrollView(
                    child: Text(
                      widget.info,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

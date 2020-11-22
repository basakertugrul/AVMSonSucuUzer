import 'package:avmv005/Pages/NavigationBar/bilboard_page.dart';
import 'package:avmv005/Pages/NavigationBar/discounts_page.dart';
import 'package:avmv005/Pages/NavigationBar/events_page.dart';
import 'package:avmv005/Pages/NavigationBar/gallery_page.dart';
import 'package:avmv005/Pages/NavigationBar/trends_page.dart';

import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;

  CollapsingListTile({
    @required this.title,
    @required this.icon,
    @required this.animationController,
    this.isSelected = false,
    this.onTap,
  });

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  Animation<double> widthAnimation, sizedBoxAnimation;
  @override
  void initState() {
    super.initState();
    widthAnimation =
        Tween<double>(begin: 200, end: 70).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.title);
        if (widget.title == "Anasayfa") {
          Navigator.pushNamed(context, "/");
        }
        if (widget.title == "İndirimler") {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new DiscountsScreen()),
          );
        }
        if (widget.title == "Trendler") {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new TrendsScreen()),
          );
        }
        if (widget.title == "Etkinlikler") {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new EventsScreen()),
          );
        }
        if (widget.title == "Galeri") {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new GalleryScreen()),
          );
        }
        if (widget.title == "Bilboard") {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new BilboardScreen()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? selectedColor : unSelectedColor,
              size: 38.0,
            ),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.value >= 190)
                ? Text(
                    widget.title,
                    style: widget.isSelected
                        ? listTitleSelectedTextStyle
                        : listTitleDefaultTextStyle,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

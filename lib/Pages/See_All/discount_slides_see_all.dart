import 'package:avmv005/commons/collapsing_navigation_drawer_widget.dart';
import 'package:avmv005/widgets/discounts_see_all_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DiscountsSlidesSeeAll extends StatefulWidget {
  @override
  _DiscountsSlidesSeeAllState createState() => _DiscountsSlidesSeeAllState();
}

class _DiscountsSlidesSeeAllState extends State<DiscountsSlidesSeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Avm Discounts"),
      ),
      drawer: CollapsingNavigationDrawer(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            //Discounts See All Widget
            DiscountsSlidesSeelAllWidget(),
          ],
        ),
      ),
    );
  }
}

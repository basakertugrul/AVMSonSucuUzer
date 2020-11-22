import 'package:avmv005/Model/favorites.dart';
import 'package:avmv005/Model/user_model.dart';
import 'package:avmv005/Pages/landing_page.dart';
import 'package:avmv005/Repository/user_repository.dart';
import 'package:avmv005/Utils/database_helper.dart';
import 'package:avmv005/View_Model/user_model.dart';
import 'package:avmv005/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'design_course_app_theme.dart';

enum ButtonType { AddFavorite, DeleteFavorite }

class CourseInfoScreen extends StatefulWidget {
  final String imageUrl;
  final String avmName;
  final String brandName;
  final String info;
  final String stars;
  final String title;

  CourseInfoScreen(
      {this.imageUrl,
      this.avmName,
      this.brandName,
      this.info,
      this.stars,
      this.title});

  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
  Color color = DesignCourseAppTheme.nearlyBlue;
  DatabaseHelper _databaseHelper;
  List<Favorites> allFavoritesList;
  DatabaseHelper dbh1 = DatabaseHelper();
  Icon icon = new Icon(
    Icons.favorite,
    color: DesignCourseAppTheme.nearlyWhite,
    size: 30,
  ); //Icons.favorite;

  var _buttonType = ButtonType.AddFavorite;
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    super.initState();

    allFavoritesList = List<Favorites>();
    _databaseHelper = DatabaseHelper();

    _databaseHelper.allFavorites().then((allFavoritesMapList) {
      for (Map readFavoritesMap in allFavoritesMapList) {
        allFavoritesList.add(Favorites.fromMap(readFavoritesMap));
        if (Favorites.fromMap(readFavoritesMap).imageUrl ==
            widget.imageUrl.toString()) {
          _buttonType = ButtonType.DeleteFavorite;
          icon = new Icon(
            Icons.favorite,
            color: DesignCourseAppTheme.nearlyBlack,
            size: 30,
          );
          color = DesignCourseAppTheme.nearlyWhite;
          break;
        } else {
          print("false");
        }
      }
      setState(() {});
    }).catchError((hata) => print("hata:" + hata));

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: null);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserRepository _userRepository = locator<UserRepository>();
    User _user;
    void _changeButtonType() async {
      _user = await _userRepository.currentUser();
      print(_user.toString());
      if (_user == null) {
        showAlertDialog(BuildContext context) {
          // set up the buttons
          Widget cancelButton = FlatButton(
            child: Text("Kapat"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
          Widget continueButton = FlatButton(
            child: Text("Oturum Aç"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                            create: (context) => UserModel(),
                            child: LandingPage(),
                          )));
            },
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text("Oturum Aç"),
            content: Text("Kaydetmek İçin Oturum Açmanız Gerekiyor!"),
            actions: [
              cancelButton,
              continueButton,
            ],
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        }

        showAlertDialog(context);
      } else {
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
            icon = new Icon(
              Icons.favorite,
              color: DesignCourseAppTheme.nearlyBlack,
              size: 30,
            );
            color = DesignCourseAppTheme.nearlyWhite; //Icons.favorite;
          } catch (e) {
            print("Kaydederken bir hata oluştu" + e.toString());
          }
        } else {
          try {
            dbh1.deleteFavorite(widget.imageUrl);
            icon = new Icon(
              Icons.favorite,
              color: DesignCourseAppTheme.nearlyWhite,
              size: 30,
            );
            color = DesignCourseAppTheme.nearlyBlue;
            //Icons.favorite;
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
    }

    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image(
                    height: 350.0,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      widget.imageUrl,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.darkerText,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '\$28.99',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.nearlyBlue,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        widget.stars,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color: DesignCourseAppTheme.grey,
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: DesignCourseAppTheme.nearlyBlue,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  getTimeBoxUI(
                                      widget.avmName.toUpperCase(), 'Avm'),
                                  getTimeBoxUI(widget.brandName, 'Marka'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child: Text(
                                  widget.info,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              right: 35,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: IconButton(
                        icon: icon,
                        onPressed: () => {_changeButtonType()},
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: DesignCourseAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
